//
//  edelkroneTestApp.swift
//  Shared
//
//  Created by Carsten Müller on 02.03.22.
//

import SwiftUI



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
      
//      Joystick(isDebug: true,
//               enabled: false,
//               freedoms: .all,
//               colorStyle: edelkroneTestApp.colorized ,
//               action: { (joyStickState, stickPosition) in  }){
//        VStack{
//          Text("Pan")
//          Text("Tilt")
//        }.font(.applicationFont(.title).weight(.heavy)).foregroundColor(.white)
//      }
      
      
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


