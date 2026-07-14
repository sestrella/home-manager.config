// The Swift Programming Language
// https://docs.swift.org/swift-book

import Cocoa
import Foundation
import Logging
import ArgumentParser

let logger = Logger(label: "com.sestrella.helix-theme-sync")

class ThemeChangedObserver {
	let center = DistributedNotificationCenter.default
	let fileManager = FileManager.default

	private var configDir: String
	private var runtimeDir: String
	private var theme: String

	private var centralObserver: NSObjectProtocol?
	private var workspaceObserver: NSObjectProtocol?

	init(configDir: String, runtimeDir: String, theme: String) {
		self.configDir = configDir
		self.runtimeDir = runtimeDir
		self.theme = theme
	}

	func add() {
		logger.info("Adding central observer...")
		centralObserver = center.addObserver(
			forName: Notification.Name("AppleInterfaceThemeChangedNotification"),
			object: nil,
			queue: .main
		) { _ in
			self.themeChanged()
		}

		logger.info("Adding workspace observer...")
		workspaceObserver = NSWorkspace.shared.notificationCenter.addObserver(
			forName: NSWorkspace.didWakeNotification,
			object: nil,
			queue: nil
		) { _ in
			self.themeChanged()
		}
	}

	func remove() {
		guard let observer = centralObserver else {
			return
		}

		logger.info("Removing central observer...")
		center.removeObserver(observer)

		guard let observer = workspaceObserver else {
			return
		}

		logger.info("Removing central observer...")
		NSWorkspace.shared.notificationCenter.removeObserver(observer)
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
			logger.info("Creating themes directory at \(themesDir)")
			try fileManager.createDirectory(
				atPath: themesDir,
				withIntermediateDirectories: true
			)

			let destinationPath = "\(runtimeDir)/themes/\(theme)_\(suffix).toml"
			let themePath = "\(themesDir)/\(theme).toml"

			if fileManager.fileExists(atPath: themePath) {
				logger.info("Removing existing theme file at \(themePath)")
				try fileManager.removeItem(atPath: themePath)
			}

			logger.info("Creating symlink from \(themePath) to \(destinationPath)")
			try fileManager.createSymbolicLink(
				atPath: themePath,
				withDestinationPath: destinationPath
			)
		} catch {
			logger.error("Error in symlinkTheme: \(error.localizedDescription)")
		}
	}
}

struct HelixThemeSync: ParsableCommand {
    @Option(name: .shortAndLong, help: "Helix config directory")
    var configDir: String

    @Option(name: .shortAndLong, help: "Helix runtime directory")
    var runtimeDir: String

    @Option(name: .shortAndLong, help: "Theme name")
    var theme: String

    func run() throws {
        let observer = ThemeChangedObserver(
            configDir: configDir,
            runtimeDir: runtimeDir,
            theme: theme
        )
        observer.add()
        NSApplication.shared.run()
        observer.remove()
    }
}

HelixThemeSync.main()
