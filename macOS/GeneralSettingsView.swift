//
//  GeneralSettingsView.swift
//  edelkroneTest (macOS)
//
//  Created by Carsten Müller on 04.03.22.
//

import SwiftUI

struct GeneralSettingsView: View {
  @AppStorage(Preferences.Hostname.rawValue) private  var hostname = ""
  @AppStorage(Preferences.Port.rawValue) private var port = 8080
  @AppStorage(Preferences.LinkAdapter.rawValue) private var linkId = ""
  var body: some View {
    VStack {
      Form {

        TextField(text: $hostname,prompt: Text("Required")){
          Text("Hostname: ")
        }

        TextField(text: Binding(get: { String(port) }, set: { port = Int($0) ?? 0 }), prompt:Text("Required")){
          Text("Port:")
        }
        
        TextField(text: $linkId, prompt:Text("Required")){
          Text("Link ID:")
        }
        
      }
      .padding(20)
      .frame(width: 350, height: 100)
    }
  }
}

struct GeneralSettingsView_Previews: PreviewProvider {
  static var previews: some View {
    GeneralSettingsView()
  }
}
