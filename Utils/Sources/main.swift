// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import IOBluetooth

final class BluetoothWatcher: NSObject {
  private var connectNotification: IOBluetoothUserNotification?

  override init() {
    super.init()

    connectNotification =
      IOBluetoothDevice.register(
        forConnectNotifications: self,
        selector: #selector(deviceConnected(_:device:))
      )

    print("Watching for Bluetooth devices...")
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
    print("Device changed")
  }
}

let _watcher = BluetoothWatcher()
RunLoop.main.run()
