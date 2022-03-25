/**
 LinkAdapterView.swift
 edelkroneTest
 
 Collection of views dealing with link adapters from edelkrone
 
 Created by Carsten Müller on 08.03.22.
 */

import SwiftUI

struct LinkAdapterStatusView: View{
  var adapter: LinkAdapter
  var body: some View{
    let labelSize = Font.applicationFontSize(.body)
    HStack(alignment: .bottom, spacing: 10){
      HStack(alignment: .bottom, spacing: 1){
        Text("Firmware: ").font(.body)
        Text("\u{26AB}")
          .font(.custom("Symbols-Regular", size:labelSize))
          .foregroundColor( adapter.updateRequired ? .red : .green)
      }
      
      HStack(alignment: .bottom, spacing: 1){
        Text("Radio: ").font(.body)
        Text("\u{26AB}")
          .font(.custom("Symbols-Regular", size:labelSize))
          .foregroundColor( adapter.radioUpdateRequired ? .red : .green)
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
        Text((!adapter.isPaired ? "not-":"")+"paired")
          .font(.applicationFont(.title2))
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
        .buttonStyle(ColoredGlyphButtonStyle(buttonColor:  adapter.isConnected ? Color.green : Color.red,
                                             shadowRadius: 0,
                                             glyph:Text(adapter.isConnected ? "\u{22f3}":"\u{22f2}")
                                              .font(.custom("Symbols-Regular", size: buttonSize+10))
                                            ))
        
        
        Button( action: {edelkroneAPI.shared.detect(adapter: adapter)}){
          Text("Detect")
            .font(.applicationFont(.title2))
            .frame(maxWidth:.infinity, alignment: .center)
          
        }.buttonStyle(ColoredGlyphButtonStyle(buttonColor: .mint,
                                              shadowRadius: 0,
                                              glyph:Text("\u{22f4}")
                                                .font(.custom("Symbols-Regular", size: buttonSize+10))
                                             ))
      }
      .padding([.leading, .trailing],10)
      
    }
    .border(Color("Outline"), width: 3)
    //.frame(maxWidth: .infinity)
    
    //.border(Color("Seperator"), width: 2, edges: [.top])
  }
}

struct LinkAdapterList: View {
  var linkAdapters: [LinkAdapter]
  var body: some View{
    VStack(alignment: .leading, spacing: 8){
      Text("Detected Adapters:")
        .font(.applicationFont(.title2))
        //.padding([.bottom],8)
      if(linkAdapters.isEmpty){
        VStack{
          Text("None")
            .font(.applicationFont(.largeTitle)).foregroundColor(.red)
          Text("check Connection, Hostname and Port")
            .font(.applicationFont(.title2))
        }
      }else{
        List{
          ForEach(linkAdapters) { linkAdapter in
            LinkAdapterView(adapter: linkAdapter)
             }

        }.frame(maxWidth:.infinity, maxHeight: .infinity)
          .listRowInsets(EdgeInsets())
          .listStyle(.bordered)
          .background(.pink)
        
      }
    }.padding([.top,.bottom],12)
      .padding([.trailing,.leading],8)
      .border(Color("Outline"), width: 2)
      .frame(minWidth: 680, idealWidth: 700, maxWidth: .infinity, minHeight: 200, idealHeight: 400, maxHeight: .infinity, alignment: .trailing)
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
