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
      VStack(alignment: .leading, spacing: 5){ // Motion Group Information
        Text("Group: " + String(pairingGroup.groupID) )
          .font(.applicationFont(.title2).weight(.regular))
          .padding([.leading],8)
        
        // MCS Group Stack
        VStack(alignment: .leading, spacing: 5){
          ForEach(pairingGroup.groupedControlSystems){ mcs in
            VStack( alignment: .leading, spacing: 0){ // mcs entry
              HStack{
                Text(String(mcs.deviceType.toString()))
                  .font(.applicationFont(.title).weight(.regular))
                if(mcs.deviceType == .headOne){
                  Text(mcs.isTilted ? "(Tilt)" : "(Pan)")
                    .font(.applicationFont(.title).weight(.regular))
                    .padding([.leading],20)
                }
              }
              HStack{
                Text( (mcs == pairingGroup.groupMaster) ? "Master" : "Member")
                  .font(.applicationFont(.body))
                
                Text(mcs.macAddress)
                  .font(.applicationFont(.body))
              } // HStack
            }// VStack mcs entry
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 5)
              .fill(Color.white)
              .shadow(color:.lightLightGray, radius: 1.5, x:-1.5, y:-1.5)
              .shadow(color:.white,          radius: 1.5, x: 1.5, y: 1.5)
                        
            )
          }// ForEach
        }//VStack MCS Group Stack
        .padding([.leading, .bottom],8)
      }// VStack
      //.frame(minWidth: 100, idealWidth:200, maxWidth:300)
      .fixedSize(horizontal: true, vertical: false)
      .padding([.top,.bottom],5)
      Spacer()
      VStack(){
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
          .font(.custom("Symbols-Regular", size: buttonSize+5)),
                                              glyphPadding: 10,
                                              width: 150,
                                              height: 40,
                                              bevelSize: 4.0
                                             ))
      }.padding([.bottom],12)
    }// HStack
    .fixedSize(horizontal: false, vertical: true)
    .frame(maxWidth: .infinity)
    //    .frame(minWidth: 200, idealWidth: 200, maxWidth:500)
    .padding([.trailing],20)
    .background(RoundedRectangle(cornerRadius: 10.0, style: .circular)
      .fill(Color.lightWhite)
      .shadow(color:.lightGray, radius:4,x:3,y:3)
      .shadow(color:.white, radius: 4,x: -3, y:-3)
    )
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
      
      List{
        if(pairedGroups.isEmpty){
          VStack{
            Text("No Groups found")
              .font(.applicationFont(.largeTitle))
              .foregroundColor(Color("TextColor"))
          }.frame(minWidth: 600, idealWidth:780, maxWidth:800,alignment: .leading)
        }else{
          ForEach(pairedGroups) { group in
            PairingGroupView(pairingGroup: group)
              .padding([.top, .bottom],10)
              .padding([.leading, .trailing],10)
            //Divider()
          }
        }
      }
      .background(Rectangle().fill(.red))
      .border(Color("Outline"))
      .listStyle(.bordered)
      
      .fixedSize(horizontal: false, vertical: false)
      .colorMultiply(.darkWhite)
      
    }
    .frame(minWidth: 796, idealWidth: 1194, maxWidth: .infinity, minHeight: 250, idealHeight:300, maxHeight: .infinity, alignment: .leading)
    .padding([.top,.bottom],12)
    .padding([.trailing,.leading],8)
    //    .border(Color("Outline"), width: 2)
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
    PairingGroupList(pairedGroups:[PairingGroup()])
  }
  
}
