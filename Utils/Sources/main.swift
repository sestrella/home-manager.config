// The Swift Programming Language
// https://docs.swift.org/swift-book

import AppleSiliconDDC
import Foundation
import IOBluetooth

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

        print("Watching for Bluetooth devices...")
        print("Using display: \(displayArg), input: \(inputArg)")
    }

    deinit {
        unregister()
    }

    func unregister() {
        print("Deregistering Bluetooth hook...")
        connectNotification?.unregister()
    }

    @objc func deviceConnected(
        _ notification: IOBluetoothUserNotification,
        device: IOBluetoothDevice
    ) {

        guard let name = device.name else {
            return
        }

        print("Connected: \(name)")

        if name.contains("MX Keys") {
            runScript()
        }
    }

    private func runScript() {
        print("Device changed, switching display input via AppleSiliconDDC...")

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
                print("Warning: target display not found; using first detected display: \(displays[0].ioDisplayLocation)")
            } else {
                print("No displays found to switch")
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
            print("Invalid input value: \(inputArg)")
            return
        }

        let writeOK = AppleSiliconDDC.write(service: target!.service, command: UInt8(0x60), value: UInt16(valueInt))
        if writeOK {
            print("Input switched (VCP 0x60) to value \(valueInt)")
        } else {
            print("Failed to switch input via AppleSiliconDDC")
        }
    }
}

let args = CommandLine.arguments
if args.count != 3 {
    print("Usage: \(args[0]) <display> <input>")
    exit(1)
}
let display = args[1]
let input = args[2]

print("Starting with PID \(ProcessInfo.processInfo.processIdentifier)")
let watcher = BluetoothWatcher(display: display, input: input)

let signals: [Int32] = [SIGINT, SIGTERM]
for sig in signals {
    // Let Dispatch handle these signals
    signal(sig, SIG_IGN)
    let source = DispatchSource.makeSignalSource(signal: sig, queue: .main)
    source.setEventHandler {
        print("Utils is shutting down gracefully...")
        watcher.unregister()
        source.cancel()
        exit(0)
    }
    source.resume()
}

RunLoop.main.run()
