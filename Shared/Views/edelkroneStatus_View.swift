//
//  edelkroneStatus.swift
//  edelkroneTest
//
//  Created by Carsten Müller on 09.03.22.
//

import SwiftUI

struct edelkroneStatus_View: View {
  @AppStorage(Preferences.Hostname.rawValue) private  var hostname = ""
  @AppStorage(Preferences.Port.rawValue) private var port = 8080
  
  @StateObject var edelkrone: edelkroneAPI
  
  var body: some View {
    
    HStack(spacing: 1){
      // Hostname
      HStack(alignment: .firstTextBaseline, spacing:3 ){
        Text("Host:")
          .font(.applicationFont(.body))
          .fixedSize(horizontal: true, vertical: true)
        Text(hostname+":"+String(port))
          .font(.applicationFont(.body))
          .fixedSize(horizontal: true, vertical: true)
          .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
          .inset()
          .background(.white)
      }.padding( EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 10))
      
      // Status
      HStack(alignment: .firstTextBaseline, spacing:3 ){
        Text("Status:")
          .font(.applicationFont(.body))
          .fixedSize(horizontal: true, vertical: true)
        Text( edelkrone.hasAdapters ? "online" : "offline")
          .font(.applicationFont(.body))
          .fixedSize(horizontal: true, vertical: true)
          .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
          .inset()
        //.background(.white)
      }.padding( EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
      
      HStack(alignment: .firstTextBaseline, spacing: 3){
        Text("Link:")
          .font(.applicationFont(.body))
          .fixedSize(horizontal: true, vertical: true)
        Text(edelkrone.connectedAdapterID).monospacedDigit().frame(width:92.0)
          .font(.applicationFont(.body))
          .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
          .inset()
      }.padding( EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
      
      //Spacer()
      Button(action:edelkrone.reset){
        Text("Reset").font(.applicationFont(.body))
      }.padding([.leading],50)
    }
      
    
    
  }
}

struct edelkroneStatus_View_Previews: PreviewProvider {
  static var previews: some View {
    edelkroneStatus_View(edelkrone: edelkroneAPI.shared)
  }
}