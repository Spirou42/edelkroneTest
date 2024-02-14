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
  public var speed:Double = 1.00
  public var accel:Double = 0.0

  var body: some View {
    ZStack(){

      Button( action: {
        print("Action for ",slot.index, speed,accel)
        edelkroneAPI.shared.keyposeMoveFixedSpeed(slot.index, speed:speed, acceleration: accel)
        }
      ){
        
        VStack(alignment: .leading, spacing: 1){
          // Pose Title
          HStack(alignment: .center, spacing: 6.0 ){
            Button(action: { print("Edit Action for ",slot.index)}){
              
            }.buttonStyle(ColoredGlyphButtonStyle(buttonColor: Color.clear,
                                                  labelColor: Color.black,
                                                  cornerRadius: 1,
                                                  shadowRadius: 1,
                                                  glyph: Text(
                                                    Image(systemName: "square.and.pencil").symbolRenderingMode(.hierarchical)
                                                  ).font(.applicationFont(.poseTitle)),
                                                    //Image(systemName: "square.and.pencil"),
                                                  glyphPadding: 0,
                                                  width: 22,
                                                  height: 22)
                          )

            Text("Pose ").frame(width:50,alignment: .leading)
              .shadow(color:.white, radius: 0.15, x:0.7, y:0.7)
              .shadow(color:.lightGray, radius: 0.15, x:-0.7, y:-0.7)
              .font(.applicationFont(.poseTitle))
            Text(String(slot.index))
              .shadow(color:.white, radius: 0.15, x:0.7, y:0.7)
              .shadow(color:.lightGray, radius: 0.15, x:-0.7, y:-0.7)
              .font(.applicationFont(.poseTitle))
            Spacer()

            // Edit button
            
            Button(action: { print("Clear Action for ",slot.index)}){
              
            }.buttonStyle(ColoredGlyphButtonStyle(buttonColor: Color.clear,
                                                  labelColor: Color.black,
                                                  cornerRadius: 1,
                                                  shadowRadius: 1,
                                                  glyph: Text(Image(systemName: "xmark.circle").symbolRenderingMode(.hierarchical)).font(.applicationFont(.poseTitle)),
                                                    //Image(systemName: "square.and.pencil"),
                                                  glyphPadding: 0,
                                                  width: 22,
                                                  height: 22)
            
            ).padding([.trailing],10)
          }.frame(maxWidth: .infinity, alignment: .topLeading)
            .padding([.top],4).padding([.leading],10)

          Spacer().frame(height: slot.isFilled ? 2 : 65)

          // Axels
          if(slot.isFilled){
            ForEach(Array(slot.axels.keys).sorted(by: {return $0 < $1})){ t in
              HStack(spacing: 0){
                Text(slot.axels[t]!?.axelName.toString() ?? "").frame(width:40,alignment:.leading)
                  .shadow(color:.white, radius: 0.15, x:0.7, y:0.7)
                  .shadow(color:.lightGray, radius: 0.15, x:-0.7, y:-0.7)
                  .padding([.leading], 0)
                  .font(.applicationFont(.poseTitle2))
                Text(" : ").fixedSize(horizontal: true, vertical: false)
                  .padding([.leading] ,2)
                  .padding([.trailing],2)
                  .shadow(color:.white, radius: 0.15, x:0.7, y:0.7)
                  .shadow(color:.lightGray, radius: 0.15, x:-0.7, y:-0.7)
                  .font(.applicationFont(.poseTitle2))
                
                Text(String(format:"%03.02f",slot.axels[t]!?.axelPosition ?? 0.0)).monospacedDigit().frame(width:60,alignment: .leading)
                  .shadow(color:.white, radius: 0.15, x:0.7, y:0.7)
                  .shadow(color:.lightGray, radius: 0.15, x:-0.7, y:-0.7)
                  .font(.applicationFont(.poseTitle2))
                
                Text((slot.axels[t]!?.calibrated ?? false) ? "X" : "O")
                  .shadow(color:.white, radius: 0.15, x:0.7, y:0.7)
                  .shadow(color:.lightGray, radius: 0.15, x:-0.7, y:-0.7)
                  .font(.applicationFont(.poseTitle2))
              }.frame(maxWidth: .infinity, alignment: .topLeading)
                .padding([.leading],18)
            }
            Spacer()
          }
        }

      }
      .frame(width: 180, height: 90, alignment: .center)
      .buttonStyle(ColoredButtonStyle( 
//        buttonColor: .white,
        buttonColor:  slot.isFilled ? Color.Theme.GreenLighter.withAlpha(0.3) : Color.Theme.TransparentGray,
                                      labelColor: Color.black,
                                      cornerRadius: 5,
                                      shadowRadius: 0,
                                      width: 180,
                                      height: 90
                                     ))
      


      
    }.frame(width: 180, height: 90, alignment: .center)
      .background(
        RoundedRectangle(cornerRadius: 5)
          .fill(.white)
//          .fill(slot.isFilled ? Color.Theme.GreenLighter.withAlpha(0.3) : Color.Theme.TransparentGray )
          .shadow(color:.lightGray, radius:2,x:3,y:3)
          .shadow(color:.white, radius: 2,x: -3, y:-3)
      )
      .padding([.top,.bottom],5)
      .padding([.leading,.trailing],5)
  }
}

struct KeyposeList: View {
  @ObservedObject var container:KeyposeContainer
  public var speed:Double = 0.5
  public var accel:Double = 0.5
  var columns: [GridItem] = [.init(.fixed(190), spacing: 0.0, alignment: .leading ),
                             .init(.fixed(190), spacing: 0.0, alignment: .leading ),
                             .init(.fixed(190), spacing: 0.0, alignment: .leading )
                             //
  ]
  
  var body: some View {
    ZStack(){
      HStack(alignment: .top, spacing: 1.0){}
//      ScrollView(.horizontal, showsIndicators: false){
        LazyVGrid(columns: columns, alignment: .leading, spacing: 0.0){
          ForEach( Array(container.slots.keys).sorted(by: {return $0 < $1}) ){ index in
            KeyposeView(slot: container.slots[index]!!, speed: speed, accel:accel).padding([.leading], 10.0)
          }
//        }
        .padding([.top,.bottom],1)
        .padding([.trailing,.leading],1)
        
      }
    }
    .frame(width: 590,height:210)
    .fixedSize(horizontal: false, vertical: true)
    
  }
}

struct KeyposeView_Previews: PreviewProvider {
  static var previews: some View {
    KeyposeView(slot: KeyposeSlot(1  , status: MotionControlStatus() ), speed: 1.5, accel: 3.0 )
  }
}

struct KeyposeList_Preview: PreviewProvider{
  static var previews: some View{
    KeyposeList(container: KeyposeContainer(MotionControlStatus()), speed: 1.3, accel: 4.5)
  }
}
