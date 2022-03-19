/**
 MotionControlSystemViews.swift
 edelkroneTest
 collection of view dealing with the display of edelkrone motion control systems
 Created by Carsten Müller on 11.03.22.
 */

import SwiftUI


/**
 MCSScanView
 Used in a list to display the detected motion control systems
 
 */
struct MotionControlSystemScan_View: View, Identifiable {
  @ObservedObject var mcs:MotionControlSystem
  
  // this UUID stops the reuse of Views in the List
  // nessesary to correctely hande the visualization of comming and going devices
  var id = UUID()
  
  var body: some View {
    
    HStack{
      HStack(alignment:.top){
        VStack(alignment: .center, spacing: 1){
          
          Text(String(mcs.deviceType))
            .font(.applicationFont(.largeTitle))
          
          Text(mcs.macAddress)
            .font(.applicationFont(.body))
            .textSelection(.enabled)
          
          Text("Group:" +  (mcs.setup == "none"  ? "none" : String(mcs.groupID) ) )
          
        }
        if(mcs.deviceType == .headOne){
          Text(mcs.isTilted ? "(Tilt)" : "(Pan)")
            .font(.applicationFont(.largeTitle))
            .padding([.trailing],20)
        }
        
      }.frame(maxWidth: .infinity, alignment: .leading)
      
      Toggle(isOn: $mcs.useInPairing){ }
      .toggleStyle(ColoredToggleStyle(label: "",
                                      onColor: .green,
                                      offColor: .red,
                                      thumbColor: .white))
      .onChange(of: mcs.useInPairing, perform: { value in
        edelkroneAPI.shared.motionControlSystemsDict[mcs.macAddress]?.useInPairing = value
      })
      
      
    }.padding()
      .border(Color("Outline"), width: 2)
  }
}

struct MotionControlSystemScan_List:View{
  var ungroupedMotionSystems: [MotionControlSystem]
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8){
      Text("Unpaired Motion Control Systems:")
        .font(.applicationFont(.title2))
        //.padding([.bottom],8)
      
      VStack(alignment: .leading, spacing: 3){
        List{
          ForEach(ungroupedMotionSystems){ mcs in
            MotionControlSystemScan_View(mcs: mcs)
          }
          
        }.border(Color("Outline"))
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
          }.buttonStyle(ColoredButtonStyle(buttonColor: .blue))
            .padding([.leading,.trailing],10)
            .padding([.top,.bottom],8)
        }
      }
    }.padding([.top,.bottom],12)
      .padding([.trailing,.leading],8)
      .border(Color("Outline"), width: 2)
  }
  
}

struct MCSScanView_Previews: PreviewProvider {
  static var previews: some View {
    MotionControlSystemScan_View(mcs:MotionControlSystem())
  }
}

struct MCSScanListView_Previews: PreviewProvider {
  static var previews: some View{
    MotionControlSystemScan_List(ungroupedMotionSystems:[MotionControlSystem()])
  }
}

