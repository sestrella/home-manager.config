// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

private class ThemeObserver: NSObject {
	private let center = DistributedNotificationCenter.default()

	override init() {
		super.init()
		print("Starting observer...")
		center.addObserver(
			self,
			selector: #selector(themeChanged(_:)),
			name: NSNotification.Name("AppleInterfaceThemeChangedNotification"),
			object: nil
		)
	}

	deinit {
		print("Removing observer...")
		center.removeObserver(self)
	}

	@objc func themeChanged(_ notification: String) {
		let theme = UserDefaults.standard.string(forKey: "AppleInterfaceStyle")
		print("Theme: \(theme ?? "Unknown")")
	}
}

@main
struct HelixThemeSync {
	static func main() {
		let _ = ThemeObserver()
		RunLoop.main.run()
	}
}
