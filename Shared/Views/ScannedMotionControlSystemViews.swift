/**
 MotionControlSystemViews.swift
 edelkroneTest
 collection of view dealing with the display of edelkrone motion control systems
 
 Created by Carsten Müller on 11.03.22.
 Copyright © 2022 Carsten Müller. All rights reserved.
 */

import SwiftUI
import edelkroneAPI
import Extensions

/**
 MCSScanView
 Used in a list to display the detected motion control systems
 
 */
struct ScannedMotionControlSystem_View: View, Identifiable {
  @ObservedObject var mcs:MotionControlSystem
  
  // this UUID stops the reuse of Views in the List
  // nessesary to correctely hande the visualization of comming and going devices
  var id = UUID()
  
  var body: some View {
    
    HStack(){
      HStack(alignment:.top){
        // Motion controll description
        VStack(alignment: .leading, spacing: 1){

          // Group
          HStack(){
            Text("Group:")
              .font(.applicationFont(.title2))
            Text((mcs.setup == "none"  ? "none" : String(mcs.groupID) ) )
              .font(.applicationFont((.title2)))
          }// Group
          
          // Device
          HStack(alignment: .top, spacing: 1){
            
            Text(String(mcs.deviceType))
              .font(.applicationFont(.title))
            
            if(mcs.deviceType == .headOne){
              Text(mcs.isTilted ? "(Tilt)" : "(Pan)")
                .font(.applicationFont(.title))
                .padding([.leading],20)
            }
          } // Device
          
          // MAC adress
          HStack(){
            Text("MAC address:")
              .font(.applicationFont(.caption))
            Text(mcs.macAddress)
              .font(.applicationFont(.caption))
              .textSelection(.enabled)
          } // MAC adress
        }// Motion controll description
      }.frame(maxWidth: .infinity, alignment: .leading)
      
      Toggle(isOn: $mcs.useInPairing){ }
        .toggleStyle(ColoredToggleSwitch(label: "",
                                         onColor: Color("Theme Orange"),
                                         offColor: Color("Theme Red"),
                                         thumbColor: .white))
      
        .onChange(of: mcs.useInPairing, perform: { value in
          edelkroneAPI.shared.motionControlSystemsDict[mcs.macAddress]?.useInPairing = value
        })
    }
    .padding(5)
    .background(
      RoundedRectangle(cornerRadius: 10)
        .fill(Color.lightWhite)
        .shadow(color:.lightGray, radius:4,x:6,y:6)
        .shadow(color:.white, radius: 4,x: -6, y:-6)
    )
  }
}

struct ScannedMotionControlSystem_List:View{
  var ungroupedMotionSystems: [MotionControlSystem]
  
  let buttonSize:CGFloat = Font.applicationFontSize(.title)
  let buttonPadding:CGFloat = 5.0
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8){
      Text("Unpaired Motion Control Systems:")
        .font(.applicationFont(.title2))
        .shadow(color:.white, radius: 0.2, x:-1, y:-1)
        .shadow(color:.lightGray, radius: 0.2, x:1, y:1)
      
      //.padding([.bottom],8)
      
      VStack(alignment: .leading, spacing: 3){
        List{
          ForEach(ungroupedMotionSystems){ mcs in
            ScannedMotionControlSystem_View(mcs: mcs)
              .padding([.top, .bottom],10)
              .padding([.leading, .trailing],10)
            
            //            Divider()
          }
          
        }
        .background(Rectangle().fill(.red))
        .border(Color("Outline"), width:1)
        .listStyle(.bordered)
        //        .frame(minWidth: 600, idealWidth:650, maxWidth:800)
        //        .fixedSize(horizontal: true, vertical: false)
        .colorMultiply(.darkWhite)
        
        HStack{
          Spacer()
          Button(action:{
            for k in edelkroneAPI.shared.scannedMotionControlSystems {
              print(k.macAddress+" "+String(k.useInPairing)+" ID:"+String(k.groupID))
            }
            edelkroneAPI.shared.wirelessPairingCreateBundle()
          }){
            Text("Pair")
              .font(.applicationFont(.title))
              .frame(maxWidth:.infinity, alignment: .center)
          }
          .buttonStyle(GradientGlyphButtonStyle(buttonColor:  Color.Theme.Green,
                                                cornerRadius: 7,
                                                shadowRadius: 0,
                                                glyph:Text("\u{22f4}")
            .font(.custom("Symbols-Regular", size: buttonSize+6)),
                                                glyphPadding: 10,
                                                width: 150,
                                                height: 40,
                                                bevelSize: 5.0
                                               ))
          .padding([.trailing],38)
        }
      }
      .background(Rectangle().fill(Color.lightWhite))
    }
    .frame(minWidth: 796, idealWidth: 1194, maxWidth: .infinity, minHeight: 250, idealHeight:300, maxHeight: .infinity, alignment: .leading)
    .padding([.top,.bottom],12)
    .padding([.trailing,.leading],8)
    .frame(maxWidth: .infinity, alignment: .leading)
//    .border(Color("Outline"), width: 2)
    .background(Rectangle().fill(Color.lightWhite))
    
  }
  
}

struct MCSScanView_Previews: PreviewProvider {
  static var previews: some View {
    ScannedMotionControlSystem_View(mcs:MotionControlSystem())
  }
}

struct MCSScanListView_Previews: PreviewProvider {
  static var previews: some View{
    ScannedMotionControlSystem_List(ungroupedMotionSystems:[MotionControlSystem()])
  }
}


