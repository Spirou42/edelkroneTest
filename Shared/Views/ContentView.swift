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
  @ObservedObject var edelkrone = edelkroneAPI.shared

  
  var body: some View {
    VStack(alignment: .leading, spacing: 2){
      switch edelkrone.apiState{
      case .presentLinkAdapters:
        LinkAdapterList(linkAdapters:edelkrone.scannedLinkAdapters)
      case .pairMotionControlSystems:
        MotionControlSystemScan_List(ungroupedMotionSystems: edelkrone.ungroupedMotionControlSystems)
      case .showMotionControlInterface:
        Text("Not implemented yet")
      }
      Spacer()
      edelkroneStatus_View(edelkrone: edelkrone)
    }.frame(minWidth: 680,idealWidth: 900 ,maxWidth: .infinity, minHeight:150,maxHeight:.infinity)
  }
  
}



struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ContentView()
    }
  }
}
