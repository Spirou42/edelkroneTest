/**
 SwiftUIView.swift
 edelkroneTest
 
 Created by Carsten Müller on 15.03.22.
 Copyright © 2022 Carsten Müller. All rights reserved.
 */

import SwiftUI
import edelkroneAPI
import Extensions


struct PairingGroupView: View {
  @ObservedObject var pairingGroup: PairingGroup
  let buttonSize:CGFloat = Font.applicationFontSize(.title)
  let buttonPadding:CGFloat = 5.0
  
  var body: some View {
    HStack(spacing:30){
      VStack(alignment: .leading, spacing: 8){ // Motion Group Information
        Text("Group: " + String(pairingGroup.groupID) )
          .font(.applicationFont(.title2).weight(.semibold))
          
        VStack(alignment: .leading, spacing: 8){
          ForEach(pairingGroup.groupedControlSystems){ mcs in
            VStack( alignment: .leading, spacing: 0){
              HStack{
                Text(String(mcs.deviceType.toString()))
                  .font(.applicationFont(.title).weight(.bold))
                if(mcs.deviceType == .headOne){
                  Text(mcs.isTilted ? "(Tilt)" : "(Pan)")
                    .font(.applicationFont(.title).weight(.light))
                    .padding([.trailing],20)
                }
              }
              HStack{
                Text( (mcs == pairingGroup.groupMaster) ? "Master" : "Member")
                  .font(.applicationFont(.body))
                
                Text(mcs.macAddress)
                  .font(.applicationFont(.body))
              } // HStack
            }// VStack
          }// ForEach
        }//VStack
      }// VStack
      .frame(minWidth: 100, idealWidth:200, maxWidth:300)
      .fixedSize(horizontal: true, vertical: false)
      .padding([.top,.bottom],5)
      Spacer()
      Button( action: {edelkroneAPI.shared.attachToBundle(self.pairingGroup)}){
        Text("Connect")
          .font(.applicationFont(.title))
          .frame(maxWidth:.infinity, alignment: .center)
      }
      .buttonStyle(GradientGlyphButtonStyle(buttonColor:   Color.Theme.Green,
                                            cornerRadius: 7,
                                            shadowRadius: 0,
                                            glyph:Text("\u{22f2}")
        .font(.custom("Symbols-Regular", size: buttonSize+10)),
                                            glyphPadding: 20,
                                            width: 160,
                                            height: 50	,
                                            bevelSize: 4.0
                                           ))
    }// HStack
    .fixedSize(horizontal: false, vertical: true)
    //    .frame(minWidth: 200, idealWidth: 200, maxWidth:500)
    .padding([.trailing],20)
    .background(Rectangle().fill(Color.lightWhite))
    //.border(Color("Outline"), width: 0.5)
  }
}

struct PairingGroupList:View{
  var pairedGroups: [PairingGroup]
  var body: some View{
    VStack(alignment: .leading, spacing: 8){
      Text("Grouped Motion Control Systems:")
        .font(.applicationFont(.title2))
      //.padding([.bottom],8)
      if(pairedGroups.isEmpty){
        VStack{
          Text("No Groups found")
            .font(.applicationFont(.largeTitle)).foregroundColor(Color("TextColor"))
        }
      }else{
        List{
          ForEach(pairedGroups) { group in
            PairingGroupView(pairingGroup: group)
            Divider()
          }
        }
        .background(Rectangle().fill(.red))
        .border(Color("Outline"))
        .listStyle(.bordered)
        .frame(minWidth: 600, idealWidth:780, maxWidth:800)
        .fixedSize(horizontal: true, vertical: false)
        .colorMultiply(.darkWhite)
        
      }
    }
    .padding([.top,.bottom],12)
    .padding([.trailing,.leading],8)
    .border(Color("Outline"), width: 2)
    .background(Rectangle().fill(Color.lightWhite))
  }
}

struct PairingGroupView_Previews: PreviewProvider {
  static var previews: some View {
    PairingGroupView(pairingGroup: PairingGroup())
  }
}

struct PairingGroupList_Previews: PreviewProvider{
  static var previews: some View {
    PairingGroupList(pairedGroups:[])
  }
  
}
