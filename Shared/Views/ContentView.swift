//
//  ContentView.swift
//  Shared
//
//  Created by Carsten Müller on 02.03.22.
//

import SwiftUI

struct ContentView: View {
  @AppStorage(Preferences.Hostname.rawValue) private  var hostname = ""
  @AppStorage(Preferences.Port.rawValue) private var port = 8080
  @StateObject var edelkroneAPI = edelkroneModel.shared
  
  var body: some View {
    VStack(alignment: .leading, spacing: 2){
      LinkAdapterList(linkAdapters:edelkroneAPI.adapters)
      edelkroneStatus(edelkrone: edelkroneAPI)
    }.frame(maxWidth: .infinity, maxHeight:.infinity)
  }
  
}



struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ContentView()
    }
  }
}
