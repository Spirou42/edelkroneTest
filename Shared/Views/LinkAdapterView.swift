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

struct LinkAdapterView: View {
  var adapter: LinkAdapter
  let buttonSize:CGFloat = Font.applicationFontSize(.largeTitle)
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
          
          Text(adapter.id)
            .font(.applicationFont(.title))
          
          
          LinkAdapterStatusView(adapter: adapter)
            .padding([.top],0)
            .padding([.bottom],5)
        }
        .padding([.top],8)
        .padding([.bottom],2)
        .padding([.leading, .trailing],20)
        .border(Color("Seperator"), width: 1, edges:[.trailing])
  
        HStack(alignment: .center, spacing: 0){
          Button( action: adapter.isPaired ? {} : {}){
            HStack {
              if(adapter.isPaired){
                Text("\u{22f3}")
                  .font(.custom("Symbols-Regular", size: buttonSize+5))
              }else{
                Text("\u{22f2}").font(.custom("Symbols-Regular", size: buttonSize+5))
              }
              Text("Connect").font(.applicationFont(.largeTitle))
              
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(adapter.isPaired ? Color.green : Color.red)
            .cornerRadius(buttonSize/4)
            
          }
          .buttonStyle(PlainButtonStyle())
          .padding()

          Button( action: {}){
            HStack{
              Text("Detect")
                .font(.applicationFont(.largeTitle))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(Color.mint)
            .cornerRadius(buttonSize/4)
            
          }.buttonStyle(PlainButtonStyle())
            .padding()
          
          
          
        }
				// .padding([.leading],
        .frame(maxWidth: .infinity)
        .fixedSize(horizontal: false, vertical: true)
        
      }
      .border(Color("Seperator"), width: 3)
      .frame(maxWidth: .infinity)

      //.border(Color("Seperator"), width: 2, edges: [.top])
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
    List{
      LinkAdapterView(adapter: LinkAdapter())
      LinkAdapterView(adapter: LinkAdapter())
      LinkAdapterView(adapter: LinkAdapter())
    }
    .padding()
    .frame(width: 650, height: .infinity, alignment: .center)
  
  
    
    
    
    //.fixedSize(horizontal: false, vertical: true)
  }
}
