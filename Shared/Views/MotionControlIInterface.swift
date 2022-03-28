/**
 MotionControlView.swift
 edelkroneTest
 
 Created by Carsten Müller on 23.03.22.
 Copyright © 2022 Carsten Müller. All rights reserved.
 */

import SwiftUI

struct BatteryView: View{
  var level:Double
  var body: some View{
    Text(String(format:"%1.03f",level ))
  }
}

struct MCSStatus:View{
  @ObservedObject var mcsState:MotionControlStatus
  var columns: [GridItem] = Array(repeating: .init(.flexible(minimum: 20, maximum: 80),spacing:0.5,alignment:.leading ), count: 3)
  
  var body: some View {
    LazyVGrid(columns: columns, alignment:.trailing, spacing:0.5) {
      ZStack(alignment: .center){
        Rectangle().fill(Color.lightGray)
        Text("Axis").font(.applicationFont(.body).weight(.bold)).padding(2)
      }
      ZStack{
        Rectangle().fill(Color.lightGray)
        Text("Position").font(.applicationFont(.body).weight(.bold)).padding(2)
      }
      ZStack{
        Rectangle().fill(Color.lightGray)
        Text("Battery").font(.applicationFont(.body).weight(.bold)).padding(2)
      }
      
      ForEach( Array(mcsState.axelStatus.keys) ,id:\.self){ c in
        ZStack(alignment: .center){
          Rectangle().fill(Color.lightLightGray)
          Text( c.toString()).font(.applicationFont(.body)).padding(2)
        }
        ZStack(alignment: .center){
          Rectangle().fill(Color.lightLightGray)
          Text(String(format:"%03.03f",mcsState.axelStatus[c]!.position)).monospacedDigit()
            .padding(2)
        }
        ZStack(alignment: .center){
          Rectangle().fill(Color.lightLightGray)
          BatteryView(level: mcsState.axelStatus[c]!.batteryLevel).padding(2)
        }
      }
    }.frame(minWidth:200,idealWidth:240, maxWidth:300, maxHeight:.infinity)
      .fixedSize(horizontal: true, vertical: true)
      .border(.orange, width: 2, edges: Edge.allCases)
      .background(.gray)
    
  }
  
}

struct MotionControlInterface: View {
  @ObservedObject var motionControlStatus = edelkroneAPI.shared.motionControlStatus
  var colorized = ColorStyle(thumbGradient: Gradient(whithDark: Color("JoystickThumbDark")),
                             backgroundGradient: Gradient(whithDark: Color("JoystickBackgroundDark")),
                             strokeColor: Color("JoystickRing"),
                             labelColor: .white)
  
  
  
  
  var body: some View {
    HStack(alignment:.top){
      HStack{
        if motionControlStatus.hasPan || motionControlStatus.hasTilt{
          Joystick(axelObjects: motionControlStatus.panTiltObjects(),
                   freedoms:[ motionControlStatus.hasPan ? .horizontal : .none , motionControlStatus.hasTilt ? .vertical : .none,],
                   colorStyle:colorized,
                   thumbRadius:  42,
                   padRadius: 100,
                   action: nil){
            VStack{
              if motionControlStatus.hasPan{
                Text("Pan").font(.applicationFont(.title2)).foregroundColor(.white)
              }
              if motionControlStatus.hasTilt{
                Text("Tilt").font(.applicationFont(.title2)).foregroundColor(.white)
              }
            }
          }
        }
        if motionControlStatus.hasSlide {
          Joystick(axelObjects: motionControlStatus.slideObjects(),
                   freedoms:[.horizontal],
                   colorStyle:colorized,
                   thumbRadius:42,
                   padRadius: 100,
                   action: nil){
            Text("Slide").font(.applicationFont(.title2)).foregroundColor(.white)
          }
        }
        
        
      }
      Spacer()
      MCSStatus(mcsState:motionControlStatus)
      
    }
  }
}

struct MotionControlInterface_Previews: PreviewProvider {
  static var previews: some View {
    MotionControlInterface()
  }
  
  
}
