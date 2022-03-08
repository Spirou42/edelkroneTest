//
//  LinkAdapterView.swift
//  edelkroneTest
//
//  Created by Carsten Müller on 08.03.22.
//

import SwiftUI

struct LinkAdapterStatusView: View{
  var adapter: LinkAdapter
  var body: some View{
    
    HStack(alignment: .bottom, spacing: 10){
      HStack(alignment: .bottom, spacing: 1){
        Text("Firmware: ").font(.body)
        Text(adapter.updateRequired ? "\u{1F534}":"\u{1F7E2}").font(.footnote)
      }
  
      HStack(alignment: .bottom, spacing: 1){
        Text("Radio: ").font(.body)
        Text(adapter.radioUpdateRequired ? "\u{1F534}":"\u{1F7E2}").font(.footnote)
      }
    }.frame(maxHeight:18)
  }
}

struct LinkAdapterView: View {
  var adapter: LinkAdapter
  let buttonSize:CGFloat = 35.0
  let buttonPadding:CGFloat = 5.0
  var body: some View {
    VStack(alignment: .center,spacing: 3){
      HStack(alignment: .center,spacing: 0){
        VStack(alignment: .center,spacing: 1){
          Text(adapter.linkType)
            .font(.largeTitle)
            .padding([.bottom],2)
          
          Text((!adapter.isPaired ? "not-":"")+"paired")
            .font(.body)
            .padding([.bottom],3)

          Text("<"+adapter.id+">")
            .font(.title3)
          
          LinkAdapterStatusView(adapter: adapter)
            .padding([.top],0)
            .padding([.bottom],5)
        }
        
        .padding([.top],8)
        .padding([.bottom],2)
        .padding([.leading, .trailing],15)
        .border(Color("Seperator"), width: 1, edges:[.trailing])
        
        Button( action: adapter.isPaired ? {} : {}){
           HStack {
             if(adapter.isPaired){
               Text("\u{22f3}").font(.custom("Symbols-Regular", size: buttonSize))
             }else{
               Text("\u{22f2}").font(.custom("Symbols-Regular", size: buttonSize))
             }
           }
           //.frame(minWidth: buttonSize, idealWidth: buttonSize, maxWidth: buttonSize, minHeight: buttonSize, idealHeight: buttonSize, maxHeight: buttonSize, alignment: .center)
           .padding(buttonPadding)
           .foregroundColor(.white)
           .background(adapter.isPaired ? Color.green : Color.red)
           .cornerRadius(buttonSize/2)
         }.buttonStyle(PlainButtonStyle())
          .padding(31)
          
      }
      .border(Color("Seperator"), width: 3)
      
        //.border(Color("Seperator"), width: 2, edges: [.top])
     
    }
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
