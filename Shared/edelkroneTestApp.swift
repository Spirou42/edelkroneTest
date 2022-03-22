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
      Joystick(isDebug: true,
               freedoms: .all,
               colorStyle: edelkroneTestApp.colorized ,
               action: { (joyStickState, stickPosition) in
       // print("Some action for " + joyStickState.rawValue + " with value "+String(stickPosition))
      }
      )
      {
        VStack{
          Text("Tilt")
          Text("Pan")
        }.font(.applicationFont(.title).weight(.semibold)).foregroundColor(.white)

      }
      
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
    edelkroneAPI.shared.scanLinkAdapters()
  }
}
#endif


