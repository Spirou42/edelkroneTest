//
//  SwiftUIView.swift
//  edelkroneTest
//
//  Created by Carsten Müller on 15.03.22.
//

import SwiftUI

struct PairingGroupView: View {
  @ObservedObject var pairingGroup: PairingGroup
  let buttonSize:CGFloat = Font.applicationFontSize(.title)
  let buttonPadding:CGFloat = 5.0

  var body: some View {
    HStack(spacing:30){
      VStack(alignment: .leading, spacing: 8){
        Text("Group: " + String(pairingGroup.groupID) )
          .font(.applicationFont(.title2))
        VStack(alignment: .leading, spacing: 8){
          ForEach(pairingGroup.groupedControlSystems){ mcs in
            VStack( alignment: .leading, spacing: 0){
              HStack{
                Text(String(mcs.deviceType.toString()))
                  .font(.applicationFont(.title))
                if(mcs.deviceType == .headOne){
                  Text(mcs.isTilted ? "(Tilt)" : "(Pan)")
                    .font(.applicationFont(.title))
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
      Button( action: {}){
        Text("Connect")
          .font(.applicationFont(.title))
          .frame(maxWidth:.infinity, alignment: .center)
      }
      .buttonStyle(ColoredGlyphButtonStyle(buttonColor:   Color.green,
                                           cornerRadius: 10,
                                           shadowRadius: 0,
                                           glyph:Text("\u{22f2}")
                                            .font(.custom("Symbols-Regular", size: buttonSize+10)),
                                           glyphPadding: 25,
                                           width: 200,
                                           height: 60
                                          ))
      Button( action: {edelkroneAPI.shared.disconnect()}){
        Text("Unpair")
          .font(.applicationFont(.title))
          .frame(maxWidth:.infinity, alignment: .center)
      }
      .buttonStyle(ColoredGlyphButtonStyle(buttonColor:   Color("ButtonRed"),
                                           cornerRadius: 10,
                                           shadowRadius: 0,
                                           glyph:Text("\u{22f4}")
                                            .font(.custom("Symbols-Regular", size: buttonSize+10)),
                                           glyphPadding: 25,
                                           width: 200,
                                           height: 60
                                          ))


    }// HStack
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
        }.listStyle(.bordered)
        .frame(minWidth: 600, idealWidth:680, maxWidth:700)
        .fixedSize(horizontal: true, vertical: false)

      }
    }
  }
}

struct PairingGroupView_Previews: PreviewProvider {
  static var previews: some View {
    PairingGroupView(pairingGroup: PairingGroup())
  }
}

struct PairingGroupList_Previews: PreviewProvider{
  static var previews: some View {
    PairingGroupList(pairedGroups:[PairingGroup(),PairingGroup()])
  }
  
}
