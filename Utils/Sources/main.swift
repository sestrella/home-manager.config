// The Swift Programming Language
// https://docs.swift.org/swift-book

import AppleSiliconDDC
import ArgumentParser
import Foundation
import IOBluetooth
import Darwin
import Logging

let logger = Logger(label: "com.sestrella.Utils")

final class BluetoothWatcher: NSObject {
    private var connectNotification: IOBluetoothUserNotification?
    private let displayArg: String
    private let inputArg: String
    init(display: String, input: String) {
        self.displayArg = display
        self.inputArg = input
        super.init()

        connectNotification =
            IOBluetoothDevice.register(
                forConnectNotifications: self,
                selector: #selector(deviceConnected(_:device:))
            )

        logger.info("Watching for Bluetooth devices...")
        logger.info("Using display: \(self.displayArg), input: \(self.inputArg)")
    }

    deinit {
        unregister()
    }

    func unregister() {
        logger.info("Deregistering Bluetooth hook...")
        connectNotification?.unregister()
    }

    @objc func deviceConnected(
        _ notification: IOBluetoothUserNotification,
        device: IOBluetoothDevice
    ) {

        guard let name = device.name else {
            return
        }

        logger.info("Connected: \(name)")

        if name.contains("MX Keys") {
            runScript()
        }
    }

    private func runScript() {
        logger.info("Device changed, switching display input via AppleSiliconDDC...")

        // Find matching display by ioDisplayLocation or serial; fall back to first detected
        let displays = AppleSiliconDDC.getIoregServicesForMatching()
        var target: AppleSiliconDDC.IOregService? = nil
        for d in displays {
            if d.ioDisplayLocation == displayArg || d.alphanumericSerialNumber == displayArg {
                target = d
                break
            }
        }
        if target == nil {
            if displays.count > 0 {
                target = displays[0]
                logger.warning("Target display not found; using first detected display: \(displays[0].ioDisplayLocation)")
            } else {
                logger.error("No displays found to switch")
                return
            }
        }

        // Parse inputArg into integer (supports decimal or hex like 0xNN or xNN)
        func parseInput(_ s: String) -> Int? {
            let lower = s.lowercased()
            if lower.hasPrefix("0x") {
                return Int(lower.dropFirst(2), radix: 16)
            } else if lower.hasPrefix("x") {
                return Int(lower.dropFirst(1), radix: 16)
            } else {
                return Int(s)
            }
        }

        guard let valueInt = parseInput(inputArg) else {
            logger.error("Invalid input value: \(inputArg)")
            return
        }

        let writeOK = AppleSiliconDDC.write(service: target!.service, command: UInt8(0x60), value: UInt16(valueInt))
        if writeOK {
            logger.info("Input switched (VCP 0x60) to value \(valueInt)")
        } else {
            logger.error("Failed to switch input via AppleSiliconDDC")
        }
    }
}

@main
struct UtilsCommand: ParsableCommand {
    static var configuration = CommandConfiguration(abstract: "Bluetooth display input switcher (watcher)")

    @Argument(help: "ioDisplayLocation or serial of the target display")
    var display: String

    @Argument(help: "Input value to set (decimal or hex like 0xNN)")
    var input: String

    mutating func run() throws {
        logger.info("Starting with PID \(ProcessInfo.processInfo.processIdentifier)")
        let watcher = BluetoothWatcher(display: display, input: input)

        var sources: [DispatchSourceSignal] = []
        let signals: [Int32] = [SIGINT, SIGTERM]
        for sig in signals {
            // Let Dispatch handle these signals
            signal(sig, SIG_IGN)
            let source = DispatchSource.makeSignalSource(signal: sig, queue: .main)
            source.setEventHandler {
                logger.info("Utils is shutting down gracefully...")
                watcher.unregister()
                source.cancel()
                Darwin.exit(0)
            }
            sources.append(source)
            source.resume()
        }

        RunLoop.main.run()
    }
}
