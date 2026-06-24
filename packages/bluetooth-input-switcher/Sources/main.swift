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

    // connectNotification =
    //   IOBluetoothDevice.register(
    //     forConnectNotifications: self,
    //     selector: #selector(deviceConnected(_:device:))
    //   )

    logger.info("Watching for Bluetooth devices...")
    logger.info(
      "Using display: \(self.display), input: \(self.input), deviceFilter: \(self.deviceFilter)")
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

    if name.contains(self.deviceFilter) {
      logger.info("Connected: \(name)")
      // switchDisplayInput()
      foo()
    }
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

  func foo() {
    // var displayCount: UInt32 = 0
    // CGGetActiveDisplayList(0, nil, &displayCount)

    // var displayIDs = [CGDirectDisplayID](repeating: 0, count: Int(displayCount))
    // CGGetActiveDisplayList(displayCount, &displayIDs, &displayCount)

    // for displayID in displayIDs {
    //   if CGDisplayIsBuiltin(displayID) == 1 {
    //     // builtinDisplay = displayID
    //   }
    // }

    let builtinDisplay = CGDirectDisplayID(1)

    if CGDisplayBounds(builtinDisplay).origin == CGPoint(x: 0, y: 0) {
      setDisplaysOrigin(displays: [
        DisplayOrigin(displayID: builtinDisplay, x: -1710, y: 0),
        DisplayOrigin(displayID: CGDirectDisplayID(2), x: 0, y: 0),
      ])
    } else {
      setDisplaysOrigin(displays: [
        DisplayOrigin(displayID: builtinDisplay, x: 0, y: 0),
        DisplayOrigin(displayID: CGDirectDisplayID(2), x: 1710, y: 0),
      ])
    }

    // let builtinBounds = CGDisplayBounds(builtinDisplay)
    // let externalBounds = CGDisplayBounds(externalDisplay)

    // TODO: Built-in display is set to main
    // if CGDisplayBounds(builtinDisplay).origin == CGPoint(x: 0, y: 0) {
    //   logger.info("Setting external display to main")
    //   setDisplayOrigin(displayID: builtinDisplay, x: -1710, y: 0)
    //   setDisplayOrigin(displayID: externalDisplay, x: 0, y: 0)
    // } else {
    //   logger.info("Setting built-in display to main")
    //   setDisplayOrigin(displayID: externalDisplay, x: 1710, y: 0)
    //   setDisplayOrigin(displayID: builtinDisplay, x: 0, y: 0)
    // }

    // guard let foo = target else {
    //   logger.error("Target not found")
    //   return
    // }

    // let displayID: CGDirectDisplayID = 2

    // var config: CGDisplayConfigRef?
    // let beginDisplay = CGBeginDisplayConfiguration(&config)
    // guard beginDisplay == .success else {
    //   logger.error("Could not begin display configuration \(beginDisplay)")
    //   return
    // }

    // let configureDisplay = CGConfigureDisplayOrigin(config, displayID, 0, 0)
    // guard configureDisplay == .success else {
    //   logger.error("Failed to configure display origin: \(configureDisplay)")
    //   return
    // }

    // let completeDisplay = CGCompleteDisplayConfiguration(config, .permanently)
    // guard completeDisplay == .success else {
    //   logger.error("Could not complete display configuration: \(completeDisplay)")
    //   return
    // }

    // logger.info("Display serial number: \(CGDisplaySerialNumber(displayID))")
    // logger.info("Display Built-in: \(CGDisplayBounds(1))")
    // logger.info("Display DELL P2422HE: \(CGDisplayBounds(2))")
  }

  struct DisplayOrigin {
    let displayID: CGDirectDisplayID
    let x: Int32
    let y: Int32
  }

  func setDisplaysOrigin(displays: [DisplayOrigin]) {
    var config: CGDisplayConfigRef?

    let beginDisplay = CGBeginDisplayConfiguration(&config)
    guard beginDisplay == .success else {
      logger.error("Could not begin configuration: \(beginDisplay)")
      return
    }

    for display in displays {
      let configureDisplay = CGConfigureDisplayOrigin(
        config, display.displayID, display.x, display.y)
      guard configureDisplay == .success else {
        logger.error(
          "Failed to configure origin for display \(display.displayID): \(configureDisplay)")
        // TODO: Do not exit immediately
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
    watcher.foo()

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

    // RunLoop.main.run()
  }
}
