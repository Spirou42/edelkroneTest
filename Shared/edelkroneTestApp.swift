//
//  edelkroneTestApp.swift
//  Shared
//
//  Created by Carsten Müller on 02.03.22.
//

import SwiftUI

@main
struct edelkroneTestApp: App {
#if os(macOS)
	@NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
#endif
//  @StateObject var edelkroneAPI = edelkroneModel.shared
	
	var body: some Scene {
        WindowGroup {
            ContentView()
        }
				#if os(macOS)
				Settings {
						SettingsView()
				}
				#endif
    }
}

#if os(macOS)
class AppDelegate: NSObject, NSApplicationDelegate {
  
		func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
				return true
		}
  
  func applicationDidFinishLaunching(_ notification: Notification) {
    edelkroneModel.shared.findLinkAdapters()
  }
}
#endif


