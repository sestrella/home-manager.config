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

    device.register(
      forDisconnectNotification: self,
      selector: #selector(deviceDisconnected(_:device:))
    )
  }

  @objc func deviceDisconnected(
    _ notification: IOBluetoothUserNotification,
    device: IOBluetoothDevice
  ) {

    let name = device.name ?? "<unknown>"
    print("Disconnected: \(name)")
  }

  private func runScript() {
    print("Device changed, switching display input...")

    let process = Process()
    process.launchPath = "/usr/bin/env"
    process.arguments = ["m1ddc", displayArg, inputArg]

    let outPipe = Pipe()
    let errPipe = Pipe()
    process.standardOutput = outPipe
    process.standardError = errPipe

    do {
      try process.run()
      process.waitUntilExit()

      let outData = outPipe.fileHandleForReading.readDataToEndOfFile()
      let errData = errPipe.fileHandleForReading.readDataToEndOfFile()
      if let outStr = String(data: outData, encoding: .utf8), !outStr.isEmpty {
        print("m1ddc output: \(outStr)")
      }
      if let errStr = String(data: errData, encoding: .utf8), !errStr.isEmpty {
        print("m1ddc error: \(errStr)")
      }
      print("m1ddc exited with code \(process.terminationStatus)")
    } catch {
      print("Failed to run m1ddc: \(error)")
    }
  }
}
let args = CommandLine.arguments
guard args.count == 3 else {
  print("Usage: \(args[0]) <display> <input>")
  exit(1)
}
let display = args[1]
let input = args[2]

let watcher = BluetoothWatcher(display: display, input: input)
RunLoop.main.run()
