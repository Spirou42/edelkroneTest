/**
 edelkroneTestApp.swift
 Shared
 
 Created by Carsten Müller on 02.03.22.
 Copyright © 2022 Carsten Müller. All rights reserved.
 */

import SwiftUI
import edelkroneAPI


@main
class edelkroneTestApp: App {
#if os(macOS)
  @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
#endif
  //  @StateObject var edelkroneAPI = edelkroneModel.shared
  static var colorized = ColorStyle(thumbGradient: Gradient(colors:[Color("JoystickThumbDark"),
                                                                    Color("JoystickThumbLight")]
                                                           ),
                                    backgroundGradient: Gradient(colors:[Color("JoystickBackgroundDark"),
                                                                         Color("JoystickBackgroundLight")]
                                                                ),
                                    strokeColor: Color("JoystickRing"),
                                    iconColor: .pink)
  
  
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    
#if os(macOS)
    Settings {
      SettingsView()
    }
#endif
  }
  
  required init(){
    
  }
}

#if os(macOS)
class AppDelegate: NSObject, NSApplicationDelegate {
  
  func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }
  
  func applicationDidFinishLaunching(_ notification: Notification) {
    edelkroneAPI.shared.scanLinkAdapters()
  }
}
#endif


