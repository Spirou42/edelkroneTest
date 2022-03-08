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
    
    let buttonSize:CGFloat = 35.0
    let buttonPadding:CGFloat = 5.0
        
    VStack{
     
     Spacer()
     HStack{
      Button("LinkAdapter",action: {edelkroneModel.shared.findLinkAdapters()})
      
      
     Button( action: edelkroneAPI.isConnected ? edelkroneAPI.disconnect : edelkroneAPI.connect){
        HStack {
          if(edelkroneAPI.isConnected){
            Text("\u{22f3}").font(.custom("Symbols-Regular", size: buttonSize))
          }else{
            Text("\u{22f2}").font(.custom("Symbols-Regular", size: buttonSize))
          }
        }
        //.frame(minWidth: buttonSize, idealWidth: buttonSize, maxWidth: buttonSize, minHeight: buttonSize, idealHeight: buttonSize, maxHeight: buttonSize, alignment: .center)
        .padding(buttonPadding)
        .foregroundColor(.white)
        .background(edelkroneAPI.isConnected ? Color.green : Color.red)
        .cornerRadius(buttonSize)
      }.buttonStyle(PlainButtonStyle())
     }
      
      HStack{
        Text("Hostname:").padding(0)
        Text(hostname)
        Spacer().frame(width: 30)
        Text("Port:").padding(0)
        Text(String(port))
      }.padding( EdgeInsets(top: 20, leading: 10, bottom: 5, trailing: 10))
       
    }.fixedSize()
    .onAppear(perform: {edelkroneModel.shared.findLinkAdapters()})
  }
  
  func listInstalledFonts() {
    let fontFamilies = NSFontManager.shared.availableFontFamilies.sorted()
    for family in fontFamilies {
      print(family)
      let familyFonts = NSFontManager.shared.availableMembers(ofFontFamily: family)
      if let fonts = familyFonts {
        for font in fonts {
          print("\t\(font)")
        }
      }
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
