//
//  edelkroneStatus.swift
//  edelkroneTest
//
//  Created by Carsten Müller on 09.03.22.
//

import SwiftUI

struct edelkroneStatus: View {
  @AppStorage(Preferences.Hostname.rawValue) private  var hostname = ""
  @AppStorage(Preferences.Port.rawValue) private var port = 8080
  
  @StateObject var edelkrone: edelkroneModel
  
  var body: some View {
    HStack{
      // Hostname
      HStack(alignment: .firstTextBaseline, spacing:3 ){
        Text("Host:")
          .font(.applicationFont(.body))
        Text(hostname+":"+String(port))
          .font(.applicationFont(.body))
          .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
          .inset()
          .background(.white)
      }.padding( EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
      
      // Status
      HStack(alignment: .firstTextBaseline, spacing:3 ){
        Text("Status:")
          .font(.applicationFont(.body))
        Text( edelkrone.hasAdapters ? "online" : "offline")
          .font(.applicationFont(.body))
          .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
          .inset()
        //.background(.white)
      }.padding( EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
      HStack(alignment: .firstTextBaseline, spacing: 3){
        Text("Link:")
          .font(.applicationFont(.body))
        Text(edelkrone.connectedAdapterID).monospacedDigit().frame(width:92)
          .font(.applicationFont(.body))
          .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
          .inset()
      }.padding( EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
    }
  }
}

struct edelkroneStatus_Previews: PreviewProvider {
  static var previews: some View {
    edelkroneStatus(edelkrone: edelkroneModel.shared)
  }
}
