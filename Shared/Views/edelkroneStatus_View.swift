/**
 edelkroneStatus.swift
 edelkroneTest
 
 Created by Carsten Müller on 09.03.22.
 Copyright © 2022 Carsten Müller. All rights reserved.
 */

import SwiftUI
import edelkroneAPI

struct edelkroneStatus_View: View {
  @AppStorage(Preferences.Hostname.rawValue) private  var hostname = ""
  @AppStorage(Preferences.Port.rawValue) private var port = 8080
  
  @ObservedObject var edelkrone: edelkroneAPI
  
  var body: some View {
    
    HStack(spacing: 1){
      // Hostname
      HStack(alignment: .firstTextBaseline, spacing:3 ){
        Text("Host:")
          .font(.applicationFont(.body))
          .fixedSize(horizontal: true, vertical: true)
          .shadow(color:.white, radius: 0.15, x:0.7, y:0.7)
          .shadow(color:.lightGray, radius: 0.15, x:-0.7, y:-0.7)
        Text(hostname+":"+String(port))
          .font(.applicationFont(.body))
          .fixedSize(horizontal: true, vertical: true)
          .padding(EdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3))
          .inset()
          .background(.white)
      }.padding( EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 10))
        
      
      // Status
      HStack(alignment: .firstTextBaseline, spacing:3 ){
        Text("Status:")
          .font(.applicationFont(.body))
          .fixedSize(horizontal: true, vertical: true)
          .shadow(color:.white, radius: 0.15, x:0.7, y:0.7)
          .shadow(color:.lightGray, radius: 0.15, x:-0.7, y:-0.7)
        
        Text( edelkrone.hasAdapters ? "online" : "offline")
          .font(.applicationFont(.body))
          .fixedSize(horizontal: true, vertical: true)
          .padding(EdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3))
          .inset()
        .background(.white)
      }.padding( EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))


      // Link
      HStack(alignment: .firstTextBaseline, spacing: 3){
        Text("Link:")
          .font(.applicationFont(.body))
          .fixedSize(horizontal: true, vertical: true)
          .shadow(color:.white, radius: 0.15, x:0.7, y:0.7)
          .shadow(color:.lightGray, radius: 0.15, x:-0.7, y:-0.7)
        
        Text(edelkrone.connectedAdapterID).monospacedDigit().frame(width:100.0)
          .font(.applicationFont(.body))
          .padding(EdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3))
          .inset()
          .background(.white)
      }
      .padding( EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        
      
      // ThreadIndicators
      HStack(spacing:3){
        Text("Threads:  ")
          .font(.applicationFont(.body))
          .fixedSize(horizontal: true, vertical: true)
          .shadow(color:.white, radius: 0.15, x:0.7, y:0.7)
          .shadow(color:.lightGray, radius: 0.15, x:-0.7, y:-0.7)
      	
        Text("\u{26AB}").font(.custom("Symbols-Regular", size: 10)).foregroundColor(edelkrone.scanResultThreadIsRunning ? .green : .red)
          .shadow(color:.white, radius: 0.2, x:0.7, y:0.7)
          .shadow(color:.lightGray, radius: 0.2, x:-0.7, y:-0.7)
        Text("\u{26AB}").font(.custom("Symbols-Regular", size: 10)).foregroundColor(edelkrone.pairingStatusThreadIsRunning ? .green : .red)
          .shadow(color:.white, radius: 0.2, x:0.7, y:0.7)
          .shadow(color:.lightGray, radius: 0.2, x:-0.7, y:-0.7)

        Text("\u{26AB}").font(.custom("Symbols-Regular", size: 10)).foregroundColor(edelkrone.periodicStatusThreadIsRunning ? .green : .red)
          .shadow(color:.white, radius: 0.2, x:0.7, y:0.7)
          .shadow(color:.lightGray, radius: 0.2, x:-0.7, y:-0.7)
      }.padding( EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
      
      
      Spacer()
      Button(action:edelkrone.reset){
        Text("Reset").font(.applicationFont(.body))
          .shadow(color:.white, radius: 0.15, x:0.7, y:0.7)
          .shadow(color:.lightGray, radius: 0.15, x:-0.7, y:-0.7)

      }.padding(EdgeInsets(top: 5, leading: 50, bottom: 5, trailing: 10))
        
    }.frame(minWidth:796, idealWidth: 1194)
      .background(Rectangle().fill(Color.lightLightGray))
    
    
  }
}

struct edelkroneStatus_View_Previews: PreviewProvider {
  static var previews: some View {
    edelkroneStatus_View(edelkrone: edelkroneAPI.shared)
  }
}
