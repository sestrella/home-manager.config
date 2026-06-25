// The Swift Programming Language
// https://docs.swift.org/swift-book

import AppleSiliconDDC
import CoreGraphics
import Darwin
import Foundation
import IOBluetooth
import Logging

let INPUT_COMMAND: UInt8 = 0x60

let logger = Logger(label: "com.sestrella.BluetoohInputSwitcher")

final class BluetoothWatcher: NSObject {
  struct DisplayOrigin {
    let displayID: CGDirectDisplayID
    let x: Int32
    let y: Int32
  }

  private var connectNotification: IOBluetoothUserNotification?
  private var disconnectNotification: IOBluetoothUserNotification?

  private let display: String
  private let input: UInt16
  private let deviceFilter: String

  init(display: String, input: UInt16, deviceFilter: String) {
    self.display = display
    self.input = input
    self.deviceFilter = deviceFilter
    super.init()

    connectNotification = IOBluetoothDevice.register(
      forConnectNotifications: self,
      selector: #selector(deviceConnected(_:device:))
    )

    logger.info("Watching for Bluetooth devices...")
    logger.info(
      "Using display: \(self.display), input: \(self.input), deviceFilter: \(self.deviceFilter)")
  }

  func unregister() {
    logger.info("Deregistering Bluetooth hooks...")
    connectNotification?.unregister()
    disconnectNotification?.unregister()
  }

  @objc private func deviceConnected(
    _ notification: IOBluetoothUserNotification,
    device: IOBluetoothDevice
  ) {
    guard let name = device.name else {
      return
    }

    if name.contains(self.deviceFilter) {
      logger.info("Connected: \(name)")
      disconnectNotification = device.register(
        forDisconnectNotification: self,
        selector: #selector(deviceDisconnected(_:device:))
      )

      switchDisplayInput()
      swapDisplays(
        mainDisplayID: CGDirectDisplayID(2),
        extendedDisplayID: CGDirectDisplayID(1)
      )
    }
  }

  @objc private func deviceDisconnected(
    _ notification: IOBluetoothUserNotification,
    device: IOBluetoothDevice
  ) {
    guard let name = device.name else {
      return
    }

    logger.info("Disconnected: \(name)")
    // TODO: Remove hard-coded displayIDs
    swapDisplays(
      mainDisplayID: CGDirectDisplayID(1),
      extendedDisplayID: CGDirectDisplayID(2)
    )
  }

  private func switchDisplayInput() {
    logger.info("Device changed, switching display input via AppleSiliconDDC...")

    let displays = AppleSiliconDDC.getIoregServicesForMatching()
    var target: AppleSiliconDDC.IOregService? = nil
    for display in displays {
      if display.alphanumericSerialNumber == self.display {
        target = display
        break
      }
    }

    guard let service = target?.service else {
      logger.error("No service found for display \(display)")
      return
    }

    let readValue = AppleSiliconDDC.read(service: service, command: INPUT_COMMAND)
    if let currentValue = readValue?.current {
      guard currentValue & 0x00FF != input else {
        logger.info("Input \(input) is already selected")
        return
      }
    }

    let writeOK = AppleSiliconDDC.write(service: service, command: INPUT_COMMAND, value: input)
    guard writeOK else {
      logger.error("Failed to switch input via AppleSiliconDDC")
      return
    }

    logger.info("Input switched (VCP 0x60) to value \(input)")

  }

  private func swapDisplays(
    mainDisplayID: CGDirectDisplayID,
    extendedDisplayID: CGDirectDisplayID
  ) {
    if CGDisplayIsMain(mainDisplayID) == 1 {
      logger.info("Display \(mainDisplayID) is already the main display")
      return
    }

    let origin = CGDisplayBounds(mainDisplayID).origin

    logger.info(
      "Setting display \(mainDisplayID) as the main display and \(extendedDisplayID) as the extended display"
    )
    setDisplaysOrigin(origins: [
      DisplayOrigin(displayID: mainDisplayID, x: 0, y: 0),
      DisplayOrigin(displayID: extendedDisplayID, x: Int32(-origin.x), y: 0),
    ])
  }

  private func setDisplaysOrigin(origins: [DisplayOrigin]) {
    var config: CGDisplayConfigRef?

    let beginDisplay = CGBeginDisplayConfiguration(&config)
    guard beginDisplay == .success else {
      logger.error("Could not begin configuration: \(beginDisplay)")
      return
    }

    for origin in origins {
      let configureDisplay = CGConfigureDisplayOrigin(
        config, origin.displayID, origin.x, origin.y)
      guard configureDisplay == .success else {
        logger.error(
          "Failed to configure origin for display \(origin.displayID): \(configureDisplay)")
        return
      }
    }

    let completeDisplay = CGCompleteDisplayConfiguration(config, .permanently)
    guard completeDisplay == .success else {
      logger.error("Could not complete configuration: \(completeDisplay)")
      return
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

    let watcher = BluetoothWatcher(
      display: config.display, input: config.input, deviceFilter: config.deviceFilter)

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
