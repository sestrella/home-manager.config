// The Swift Programming Language
// https://docs.swift.org/swift-book

import Cocoa
import Foundation

class ThemeChangedObserver {
	let center = DistributedNotificationCenter.default
	let fileManager = FileManager.default

	private var configDir: String
	private var runtimeDir: String
	private var theme: String

	private var observer: NSObjectProtocol?

	init(configDir: String, runtimeDir: String, theme: String) {
		self.configDir = configDir
		self.runtimeDir = runtimeDir
		self.theme = theme
	}

	func add() {
		observer = center.addObserver(
			forName: Notification.Name("AppleInterfaceThemeChangedNotification"),
			object: nil,
			queue: .main
		) { _ in
			self.themeChanged()
		}

		NSWorkspace.shared.notificationCenter.addObserver(
			forName: NSWorkspace.didWakeNotification,
			object: nil,
			queue: nil
		) { _ in
			self.themeChanged()
		}
	}

	func remove() {
		guard let foo = observer else {
			return
		}

		center.removeObserver(foo)
	}

	private func themeChanged() {
		let isDark = UserDefaults.standard.string(forKey: "AppleInterfaceStyle") == "Dark"

		if isDark {
			symlinkTheme(suffix: "dark")
			return
		}

		symlinkTheme(suffix: "light")
	}

	private func symlinkTheme(suffix: String) {
		do {
			let themesDir = "\(configDir)/themes"
			print("Creating directory \(themesDir)")
			try fileManager.createDirectory(
				atPath: themesDir,
				withIntermediateDirectories: true
			)

			let destinationPath = "\(runtimeDir)/themes/\(theme)_\(suffix).toml"
			let themePath = "\(themesDir)/\(theme).toml"

			if fileManager.fileExists(atPath: themePath) {
				print("Removing existing file: \(themePath)")
				try fileManager.removeItem(atPath: themePath)
			}

			print("Symlinking \(destinationPath) into \(themePath)")
			try fileManager.createSymbolicLink(
				atPath: themePath,
				withDestinationPath: destinationPath
			)
		} catch {
			// TODO: Handle errors
			print(error)
		}
	}
}

let observer = ThemeChangedObserver(
	configDir: "/Users/sestrella/.config/helix",
	runtimeDir: "/nix/store/gk2kj3ngbdbmhmgphcmsff5m8i4xf874-helix-default-runtime",
	theme: "solarized"
)
observer.add()
NSApplication.shared.run()
observer.remove()
