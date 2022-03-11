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
        Text(adapter.linkType)
          .font(.applicationFont(.largeTitle))
          .padding([.bottom],2)
        
        Text((!adapter.isPaired ? "not-":"")+"paired")
          .font(.applicationFont(.title2))
          .padding([.bottom],3)
                
        Text(adapter.id).monospacedDigit()
          .font(.applicationFont(.title))
        
        LinkAdapterStatusView(adapter: adapter)
          .padding([.top],0)
          .padding([.bottom],5)
      }
      .padding([.top],8)
      .padding([.bottom],2)
      .padding([.leading, .trailing],20)
      .border(Color("Seperator"), width: 1, edges:[.trailing])
      .fixedSize(horizontal: true, vertical: true)
      
      VStack(alignment: .leading, spacing: 8){
        Button( action: adapter.isConnected ? {edelkroneModel.shared.disconnect()} : {edelkroneModel.shared.connect(adapter: adapter)}){
          HStack {
            Text(adapter.isConnected ? "\u{22f3}":"\u{22f2}" )
              .font(.custom("Symbols-Regular", size: buttonSize+10))
            Text(adapter.isConnected ? "Disconnect":"Connect")
              .font(.applicationFont(.title2))
          }
          .frame(width: 120, height:30)
          .padding([.leading,.trailing],6)
          .padding([.top,.bottom],5)
          .foregroundColor(.white)
          .background(adapter.isConnected ? Color.green : Color.red)
          .cornerRadius(buttonSize/4)
          
        }
        .buttonStyle(PlainButtonStyle())
        //.padding()
        
        Button( action: {edelkroneModel.shared.detect(adapter: adapter)}){
          HStack{
            Text("Detect")
              .font(.applicationFont(.title2))
          }
          .frame(width:120, height: 30)
          .padding([.leading,.trailing],6)
          .padding([.top,.bottom],5)
          .foregroundColor(.white)
          .background(Color.mint)
          .cornerRadius(buttonSize/4)
          
        }.buttonStyle(PlainButtonStyle())
        //.padding()
        
        
        
      }
      .padding([.leading, .trailing],10)
      
    }
    .border(Color("Seperator"), width: 3)
    //.frame(maxWidth: .infinity)
    
    //.border(Color("Seperator"), width: 2, edges: [.top])
  }
}

struct LinkAdapterList: View {
  var linkAdapters: [LinkAdapter]
  var body: some View{
    VStack(alignment: .leading, spacing: 0){
      Text("Detected Adapters:")
        .font(.applicationFont(.callout))
      if(linkAdapters.isEmpty){
        VStack{
          Text("None")
            .font(.applicationFont(.largeTitle)).foregroundColor(.red)
          Text("check Connection, Hostname and Port")
            .font(.applicationFont(.title2))
        }
      }else{
        List(linkAdapters){
          LinkAdapterView(adapter: $0)
        }.frame(maxWidth:.infinity, maxHeight: .infinity)
          .listRowInsets(EdgeInsets())
          .listStyle(.bordered)
          .background(.pink)
        
      }
    }.padding([.top],5)
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
    LinkAdapterList(linkAdapters:edelkroneModel.shared.adapters)
  }
}
