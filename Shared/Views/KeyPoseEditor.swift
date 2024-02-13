//
//  KeyPoseEditor.swift
//  edelkroneTest (macOS)
//
//  Created by Carsten Müller on 12.02.24.
//

import SwiftUI
import Extensions
import edelkroneAPI

struct KeyPoseAxelView: View {
  @ObservedObject var axel:KeyposeAxel
  
  var body: some View{
    let columns: [GridItem] = [GridItem(.fixed(100),alignment:.trailing),
                               GridItem(.fixed(130),alignment:.leading)]
    let k = axel.axelName.value() < 2 ? "°":"cm"
    let p = axel.axelName.value() < 2 ? RoundCornerStyle.position.top:RoundCornerStyle.position.baseLine
    
    VStack(alignment: .center, spacing:5){
      Text(axel.axelName.toString())
        .font(.title2)
//        .padding([.top],10)
      TextField("position", value: $axel.axelPosition, format:.number)
        .font(.largeTitle)
        .textFieldStyle(RoundCornerStyle(postFix:k,postFixPosition: p, borderColor: .darkGray, borderWidth: 1.5, cornerRadius: 19.0))
        .frame(height: 40)
      
//        .padding([.bottom],10)
//        .padding([.trailing,.leading],10)
        //.foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
    }.frame(width: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
  }
}


public struct KeyPoseEditor: View {
  @ObservedObject var slot:KeyposeSlot
  public var body: some View {
    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20.0){
      // Label
      Text("Set Position").font(.largeTitle)
      HStack(spacing: 10){
        ForEach(Array(slot.axels.keys).sorted(by: {return $0 < $1})){t in
          KeyPoseAxelView(axel: slot.axels[t]!!)
        }
      }
      HStack(spacing: 65.0){
        Button(action: {}){
          Text("Cancel").font(.title2)
        }.buttonStyle(ColoredButtonStyle(buttonColor: .Theme.RedLight, cornerRadius: 8.0, shadowRadius: 0.0, width: 100.0, height: 35.0))
        
        Button(action:{}){
          Text("Store").font(.title2)
        }.buttonStyle(ColoredButtonStyle(buttonColor: .Theme.GreenLight, cornerRadius: 8.0, shadowRadius: 0.0, width: 100.0, height: 35.0))
      }.padding([.top],30)
    }.padding([.top,.bottom],10)
      .padding([.trailing,.leading],20)
//      .frame(minWidth: 20, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 200, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
  }
  
}

struct KeyPoseAxelView_Preview: PreviewProvider {
  static let demoAxel:KeyposeAxel = KeyposeAxel(AxelID.headPan, 30.0, EdelkroneDevice.headOne)
  static var previews: some View {
    KeyPoseAxelView(axel:demoAxel)
  }
}


struct KeyPoseEditor_Preview: PreviewProvider{
  static var previews: some View{
    KeyPoseEditor(slot:KeyposeSlot(index: 0, axels: [AxelID.headPan : KeyposeAxel(AxelID.headPan, 30.0, EdelkroneDevice.headOne),
                                                     AxelID.slide : KeyposeAxel(AxelID.slide, 15.3, EdelkroneDevice.sliderOne),
                                                     AxelID.headTilt : KeyposeAxel(AxelID.headTilt, 22.5, EdelkroneDevice.headOne)
                                                    ], isFilled: true))
  }
}



