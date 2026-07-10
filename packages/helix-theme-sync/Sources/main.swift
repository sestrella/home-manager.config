// The Swift Programming Language
// https://docs.swift.org/swift-book

import Cocoa

DistributedNotificationCenter.default().addObserver(
	forName: Notification.Name("AppleInterfaceThemeChangedNotification"),
	object: nil,
	queue: .main
) { _ in
	print("Appearance changed")
}

NSWorkspace.shared.notificationCenter.addObserver(
	forName: NSWorkspace.didWakeNotification,
	object: nil,
	queue: nil
) { _ in
	print("Wake up hook")
}

NSApplication.shared.run()
