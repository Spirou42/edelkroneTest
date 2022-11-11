/**
 LinkAdapterView.swift
 edelkroneTest
 
 Collection of views dealing with link adapters from edelkrone
 
 Created by Carsten Müller on 08.03.22.
 Copyright © 2022 Carsten Müller. All rights reserved.
 */

import SwiftUI
import edelkroneAPI
import Extensions

struct LinkAdapterStatusView: View{
  var adapter: LinkAdapter
  var body: some View{
    let labelSize = Font.applicationFontSize(.body)
    HStack(alignment: .bottom, spacing: 10){
      HStack(alignment: .bottom, spacing: 1){
        Text("Firmware: ").font(.body)
          .shadow(color:.white, radius: 0.15, x:0.7, y:0.7)
          .shadow(color:.lightGray, radius: 0.15, x:-0.7, y:-0.7)

        Text("\u{26AB}")
          .font(.custom("Symbols-Regular", size:labelSize))
          .foregroundColor( adapter.updateRequired ? Color.Theme.Red : Color.Theme.Green)
          .shadow(color:.white, radius: 0.2, x:0.7, y:0.7)
          .shadow(color:.lightGray, radius: 0.2, x:-0.7, y:-0.7)

      }
      
      HStack(alignment: .bottom, spacing: 1){
        Text("Radio: ").font(.body)
          .shadow(color:.white, radius: 0.15, x:0.7, y:0.7)
          .shadow(color:.lightGray, radius: 0.15, x:-0.7, y:-0.7)

        Text("\u{26AB}")
          .font(.custom("Symbols-Regular", size:labelSize))
          .foregroundColor( adapter.radioUpdateRequired ? Color.Theme.Red : Color.Theme.Green)
          .shadow(color:.white, radius: 0.2, x:0.7, y:0.7)
          .shadow(color:.lightGray, radius: 0.2, x:-0.7, y:-0.7)

      }
    }.frame(maxHeight:18)
  }
}

struct LinkAdapterView: View{
  
  @StateObject var adapter: LinkAdapter
  
  let buttonSize:CGFloat = Font.applicationFontSize(.title2)
  let buttonPadding:CGFloat = 5.0
  
  var body: some View {
    
    
    HStack(alignment: .center,spacing: 0){
      VStack(alignment: .center,spacing: 1){
        HStack(spacing: 20) {
          Text(adapter.linkType)
            .font(.applicationFont(.largeTitle))
            .padding([.bottom],2)
          Text(adapter.id).monospacedDigit()
            .font(.applicationFont(.title))
          
        }
        .shadow(color:.white, radius: 0.3, x:1.5, y:1.5)
        .shadow(color:.lightGray, radius: 0.3, x:-1.5, y:-1.5)

        Text((!adapter.isPaired ? "not-":"")+"paired")
          .font(.applicationFont(.title2))
          .shadow(color:.white, radius: 0.15, x:0.7, y:0.7)
          .shadow(color:.lightGray, radius: 0.15, x:-0.7, y:-0.7)

          .padding([.bottom],3)
        
        
        LinkAdapterStatusView(adapter: adapter)
          .padding([.top],0)
          .padding([.bottom],5)
      }
      .padding([.top],8)
      .padding([.bottom],2)
      .padding([.leading, .trailing],20)
      .border(Color("Seperator"), width: 1, edges:[.trailing])
      .fixedSize(horizontal: true, vertical: true)
      Spacer()
      HStack(alignment: .center, spacing: 8){
        Button( action: adapter.isConnected ? {edelkroneAPI.shared.disconnect()} : {
          if adapter.isPaired {
            edelkroneAPI.shared.attachConnectedAdapter(adapterID: adapter.id)
          }else{
            edelkroneAPI.shared.wirelessPairingScanStart(adapter: adapter)
          }
          
        }){
          
          Text(adapter.isConnected ? "Disconnect":"Connect")
            .font(.applicationFont(.title2))
            .frame(maxWidth:.infinity, alignment: .center)
        }
        .buttonStyle(GradientGlyphButtonStyle(buttonColor:  adapter.isConnected ? Color.Theme.Green : Color.Theme.Red,
                                              shadowRadius: 0,
                                              glyph:Text(adapter.isConnected ? "\u{22f3}":"\u{22f2}").font(.custom("Symbols-Regular", size: buttonSize+10)),
                                              glyphPadding: 10
                                             ))
        
        
        Button( action: {edelkroneAPI.shared.detect(adapter: adapter)}){
          Text("Detect")
            .font(.applicationFont(.title2))
            .frame(maxWidth:.infinity, alignment: .center)
          
        }.buttonStyle(GradientGlyphButtonStyle(buttonColor: Color.Theme.BlueLighter,
                                               shadowRadius: 3,
                                               glyph:Text("\u{22f4}").font(.custom("Symbols-Regular", size: buttonSize+10)),
                                               glyphPadding: 10
                                              ))
      }
      .padding([.leading, .trailing],10)
      
    }
    //.border(Color("Outline"), width: 3)
    .fixedSize(horizontal: false, vertical: false)
    
    .frame(maxWidth: .infinity)
    .background(
      RoundedRectangle(cornerRadius: 10)
        .fill(Color.lightWhite)
        .shadow(color:.lightGray, radius:4,x:6,y:6)
        .shadow(color:.white, radius: 4,x: -6, y:-6)
    )
    
  }
}

struct LinkAdapterList: View {
  var linkAdapters: [LinkAdapter]
  var body: some View{
    VStack(alignment: .leading, spacing: 8){
      Text("Detected Adapters:")
        .font(.applicationFont(.title2))
        .shadow(color:.white, radius: 0.2, x:-1, y:-1)
        .shadow(color:.lightGray, radius: 0.2, x:1, y:1)
      
      //.padding([.bottom],8)
      List{
        if(linkAdapters.isEmpty){
          Spacer()
          VStack(){
            Text("No Adapter found")
              .font(.applicationFont(.largeTitle)).foregroundColor(.red)
            Spacer()
            Text("check Connection, Hostname and Port")
              .font(.applicationFont(.title2))
          }.frame(maxWidth:.infinity, maxHeight: .infinity)
          
        }else{
          ForEach(linkAdapters) { linkAdapter in
            LinkAdapterView(adapter: linkAdapter)
              .padding([.top, .bottom],10)
              .padding([.leading, .trailing],10)

          }
        }
      }.frame(maxWidth:.infinity, maxHeight: .infinity)
        .listRowInsets(EdgeInsets())
        .listStyle(.bordered)
        .colorMultiply(.darkWhite)
    }.padding([.top,.bottom],12)
      .padding([.trailing,.leading],8)
    //.border(Color("Outline"), width: 2)
      .frame(minWidth: 796, idealWidth: 1194, maxWidth: .infinity, minHeight: 300, idealHeight:1000, maxHeight: .infinity, alignment: .leading)
      .background(Rectangle().fill(Color.lightWhite))
  }
}

struct LinkAdapterView_Previews: PreviewProvider {
  static var previews: some View {
    LinkAdapterView(adapter: LinkAdapter())
  }
}

struct LinkAdapterStatusView_Previews: PreviewProvider{
  static var previews: some View {
    LinkAdapterStatusView(adapter: LinkAdapter())
  }
}

struct LinkAdapterListView_Previews: PreviewProvider {
  static var previews: some View{
    LinkAdapterList(linkAdapters:edelkroneAPI.shared.scannedLinkAdapters)
  }
}
