/**
 ContentView.swift
 Shared
 
 Created by Carsten Müller on 02.03.22.
 Copyright © 2022 Carsten Müller. All rights reserved.
 */
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
        ScannedMotionControlSystem_List(ungroupedMotionSystems: edelkrone.ungroupedMotionControlSystems)
        PairingGroupList(pairedGroups: edelkrone.motionControlGroups)
      case .showMotionControlInterface:
        MotionControlInterface()
      }
      Spacer()
      edelkroneStatus_View(edelkrone: edelkrone)
    }.frame(minWidth: 680,idealWidth: 900 ,maxWidth: .infinity, minHeight:150,maxHeight:.infinity)
      .background(Rectangle().fill(Color.lightWhite))
  }
  
}



struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ContentView()
    }
  }
}
