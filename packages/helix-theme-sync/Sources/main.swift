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

NSApplication.shared.run()
