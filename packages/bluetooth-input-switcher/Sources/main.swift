// The Swift Programming Language
// https://docs.swift.org/swift-book

import AppleSiliconDDC
import Darwin
import Foundation
import IOBluetooth
import Logging

let INPUT_COMMAND: UInt8 = 0x60

let logger = Logger(label: "com.sestrella.BluetoohInputSwitcher")

// TODO: Improvements
// - Check if the input is different before attempting to change it
// - Set external monitor as the main display
final class BluetoothWatcher: NSObject {
    private var connectNotification: IOBluetoothUserNotification?
    private let display: String
    private let input: UInt16
    private let deviceFilter: String

    init(display: String, input: UInt16, deviceFilter: String) {
        self.display = display
        self.input = input
        self.deviceFilter = deviceFilter
        super.init()

        connectNotification =
            IOBluetoothDevice.register(
                forConnectNotifications: self,
                selector: #selector(deviceConnected(_:device:))
            )

        logger.info("Watching for Bluetooth devices...")
        logger.info("Using display: \(self.display), input: \(self.input), deviceFilter: \(self.deviceFilter)")
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

        if name.contains(self.deviceFilter) {
            runScript()
        }
    }

    private func runScript() {
        logger.info("Device changed, switching display input via AppleSiliconDDC...")

        // Find matching display by ioDisplayLocation or serial; fall back to first detected
        let displays = AppleSiliconDDC.getIoregServicesForMatching()
        var target: AppleSiliconDDC.IOregService? = nil
        for d in displays {
            if d.ioDisplayLocation == self.display || d.alphanumericSerialNumber == self.display {
                target = d
                break
            }
        }
        if target == nil {
            if displays.count > 0 {
                target = displays[0]
                logger.warning(
                    "Target display not found; using first detected display: \(displays[0].ioDisplayLocation)"
                )
            } else {
                logger.error("No displays found to switch")
                return
            }
        }

        let readValue = AppleSiliconDDC.read(service: target!.service, command: INPUT_COMMAND)
        guard readValue!.current != input else {
            logger.info("Input \(input) is already selected")
            return
        }

        let writeOK = AppleSiliconDDC.write(
            service: target!.service, command: INPUT_COMMAND, value: input)
        if writeOK {
            logger.info("Input switched (VCP 0x60) to value \(input)")
        } else {
            logger.error("Failed to switch input via AppleSiliconDDC")
        }
    }
}

struct Config: Codable {
    let deviceFilter: String
    let display: String
    let input: UInt16
}

func loadConfig(path: String) -> Config? {
    let expanded = (path as NSString).expandingTildeInPath
    let fileManager = FileManager.default
    guard fileManager.fileExists(atPath: expanded) else {
        logger.error("Configuration file not found at \(expanded)")
        return nil
    }

    let url = URL(fileURLWithPath: expanded)

    guard let data = try? Data(contentsOf: url) else {
        logger.error("Error reading configuration file at \(expanded)")
        return nil
    }

    let decoder = JSONDecoder()
    do {
        let config = try decoder.decode(Config.self, from: data)
        return config
    } catch {
        logger.error("Error parsing configuration: \(error)")
        return nil
    }
}

@main
struct BluetoothInputSwitcher {
    static func main() {
        logger.info("Starting with PID \(ProcessInfo.processInfo.processIdentifier)")

        // TODO: Remove hard-coded config path
        let configPath = "~/.config/bluetooth-input-switcher/config.json"
        guard let config = loadConfig(path: configPath) else {
            logger.error("Failed to load configuration; exiting.")
            Darwin.exit(1)
        }

        let watcher = BluetoothWatcher(display: config.display, input: config.input, deviceFilter: config.deviceFilter)

        var sources: [DispatchSourceSignal] = []
        let signals: [Int32] = [SIGINT, SIGTERM]
        for sig in signals {
            signal(sig, SIG_IGN)
            let source = DispatchSource.makeSignalSource(signal: sig, queue: .main)
            source.setEventHandler {
                logger.info("bluetooth-input-switcher is shutting down gracefully...")
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
