//
//  KeyposeView.swift
//  edelkroneTest
//
//  Created by Carsten Müller on 15.04.22.
//

import SwiftUI
import Extensions
import edelkroneAPI

struct KeyposeView: View {
  
  @ObservedObject var slot:KeyposeSlot
  var body: some View {
    ZStack(){
      //Rectangle().fill(Color.lightLightGray)
      //      Button( action: {}){
      //        Text("XXX")
      //          .font(.applicationFont(.title))
      //          .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .center)
      //      }
      //      .buttonStyle(ColoredButtonStyle(buttonColor:  Color.Theme.TransparentGray,
      //                                      labelColor: Color.orange,
      //                                      cornerRadius: 7,
      //                                      shadowRadius: 0
      //                                            ))
      
      
      VStack(alignment: .leading, spacing: 0){
        
        HStack(spacing: 6.0){
          Text("Pose ").frame(width:50,alignment: .trailing)
            .shadow(color:.white, radius: 0.15, x:0.7, y:0.7)
            .shadow(color:.lightGray, radius: 0.15, x:-0.7, y:-0.7)
          Text(String(slot.index))
            .shadow(color:.white, radius: 0.15, x:0.7, y:0.7)
            .shadow(color:.lightGray, radius: 0.15, x:-0.7, y:-0.7)
        }
        
        ForEach(Array(slot.axels.keys).sorted(by: {return $0 < $1})){ t in
          HStack(spacing: 6){
            Text("Axel:").frame(width:50,alignment: .trailing)
              .shadow(color:.white, radius: 0.15, x:0.7, y:0.7)
              .shadow(color:.lightGray, radius: 0.15, x:-0.7, y:-0.7)
            Text(slot.axels[t]!?.axelName.toString() ?? "").frame(width:40,alignment:.leading)
              .shadow(color:.white, radius: 0.15, x:0.7, y:0.7)
              .shadow(color:.lightGray, radius: 0.15, x:-0.7, y:-0.7)
            Text(String(format:"%0.03f",slot.axels[t]!?.axelPosition ?? 0.0)).monospacedDigit().frame(width:60,alignment: .leading)
              .shadow(color:.white, radius: 0.15, x:0.7, y:0.7)
              .shadow(color:.lightGray, radius: 0.15, x:-0.7, y:-0.7)
            Text((slot.axels[t]!?.calibrated ?? false) ? "X" : "O")
              .shadow(color:.white, radius: 0.15, x:0.7, y:0.7)
              .shadow(color:.lightGray, radius: 0.15, x:-0.7, y:-0.7)
          }
        }
      }
      
    }.frame(width: 200, height: 70, alignment: .leading)
      .background(
        RoundedRectangle(cornerRadius: 10)
          .fill(Color.lightWhite)
          .shadow(color:.lightGray, radius:2,x:3,y:3)
          .shadow(color:.white, radius: 2,x: -3, y:-3)
      )
      .padding([.top,.bottom],5)
      .padding([.leading,.trailing],5)
  }
}

struct KeyposeList: View {
  @ObservedObject var container:KeyposeContainer
  
  var columns: [GridItem] = [.init(.fixed(197), spacing: 10.0, alignment: .leading ),
                             .init(.fixed(197), spacing: 10.0, alignment: .leading ),
                             .init(.fixed(197), spacing: 10.0, alignment: .leading )
  ]
  
  var body: some View {
    ZStack(){
      HStack(alignment: .top, spacing: 1.0){}
      ScrollView(.horizontal, showsIndicators: false){
        LazyVGrid(columns: columns, alignment: .leading, spacing: 1.0){
          ForEach( Array(container.slots.keys).sorted(by: {return $0 < $1}) ){ index in
            KeyposeView(slot: container.slots[index]!!).padding([.leading], 10.0)
          }
        }
        .padding([.top,.bottom],1)
        .padding([.trailing,.leading],1)
      
      }
    }
    .frame(width: 638,height:170)
    .fixedSize(horizontal: false, vertical: true)
    
  }
}

struct KeyposeView_Previews: PreviewProvider {
  static var previews: some View {
    KeyposeView(slot: KeyposeSlot(3 , status: MotionControlStatus() ) )
  }
}

struct KeyposeList_Preview: PreviewProvider{
  static var previews: some View{
    KeyposeList(container: KeyposeContainer(MotionControlStatus()))
  }
}
