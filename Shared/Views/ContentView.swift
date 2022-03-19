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
      if !edelkrone.hasScannedMCS{
      	LinkAdapterList(linkAdapters:edelkrone.scannedLinkAdapters)
      }else{
        MotionControlSystemScan_List(ungroupedMotionSystems: edelkrone.ungroupedMotionControlSystems)
      }
      edelkroneStatus_View(edelkrone: edelkrone)
    }.frame(minWidth: 200,idealWidth: 800 ,maxWidth: .infinity, minHeight:150,maxHeight:.infinity)
  }
  
}



struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ContentView()
    }
  }
}
