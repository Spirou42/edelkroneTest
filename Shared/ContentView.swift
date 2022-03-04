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
    VStack{
      if(edelkroneAPI.isConnected){
        Text("Is Connected")
          .padding(10)
      }else{
        Button( action: edelkroneAPI.connect){
          Image("Plus")
            .font(Font.system(size: 24, weight: .light))
            .foregroundColor(Color.red)
          Text("Connect")
            .multilineTextAlignment(.center)
            .padding(.bottom)
        }.padding(.top,10)
        
      }
      
      HStack{
        Text("Hostname:").padding(0)
        Text(hostname)
        Spacer().frame(width: 30)
        Text("Port:").padding(0)
        Text(String(port))
      }.padding(20)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ContentView()
    }
  }
}
