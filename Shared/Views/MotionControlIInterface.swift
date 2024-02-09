/**
 MotionControlView.swift
 edelkroneTest
 
 Created by Carsten Müller on 23.03.22.
 Copyright © 2022 Carsten Müller. All rights reserved.
 */

import SwiftUI
import edelkroneAPI
import Extensions



// MARK: - MotionControlInterface -

struct MotionControlInterface: View {
  @ObservedObject var motionControlStatus = edelkroneAPI.shared.motionControlStatus
  var colorized = ColorStyle(thumbGradient: Gradient(withDark: Color.Theme.GreenDarker),
                             backgroundGradient: Gradient(withDark: Color("JoystickBackgroundDark")),
                             strokeColor: Color.Theme.Orange,
                             labelColor: .white)
  
  @State var speed: Double = 0.0
  @State var accel: Double = 0.0
  
#if true
  var body: some View {
    HStack(alignment: .top, spacing: 1.0){
      
      VStack(alignment:.center, spacing: 2.0){
        
        // Joysticks
        ZStack(){
          //          RoundedRectangle(cornerRadius: 3.0, style: .circular)
          Rectangle()
            .fill(Color.lightLightGray)
            .padding([.top,.bottom,.leading,.trailing],2)
            .shadow(color: .lightGray, radius: 2.0, x: -2.0, y: -2.0)
            .shadow(color: .lightWhite, radius: 2.0, x: 2.0, y: 2.0)
          HStack(alignment: .top){
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
          .frame(minWidth: 0, idealWidth: 200, maxWidth: .infinity, minHeight: 0, idealHeight: 250, maxHeight: .infinity)
          .fixedSize(horizontal: false, vertical: true)
          
          
        }
        //.frame(width:650.0)
        //Spacer()
        //Divider()
        
        // Keypose List
        ZStack(){
          Rectangle()
            .fill(Color.lightLightGray)
            .padding([.top,.bottom,.leading,.trailing],2)
            .shadow(color: .lightGray, radius: 2.0, x: -2.0, y: -2.0)
            .shadow(color: .lightWhite, radius: 2.0, x: 2.0, y: 2.0)
          
          if ProcessInfo.processInfo.isSwiftUIPreview {
            KeyposeList(container: KeyposeContainer(MotionControlStatus()))
          }else{
            KeyposeList(container: edelkroneAPI.shared.keyposes)
          }
        }

        // Slider
        ZStack(){
          Rectangle()
            .fill(Color.lightLightGray)
            .padding([.top,.bottom,.leading,.trailing],2)
            .shadow(color: .lightGray, radius: 2.0, x: -2.0, y: -2.0)
            .shadow(color: .lightWhite, radius: 2.0, x: 2.0, y: 2.0)
          VStack(){

            Slider(value: $speed, in:0...1){
              Text("Speed:").frame(width: 45, alignment: .trailing)
            }
            minimumValueLabel:{
              Text("0")
            }
            maximumValueLabel:{
              Text("100")
            }

            Slider(value: $accel, in:0...1){
              Text("Accel:").frame(width: 45, alignment: .trailing)
            }
            minimumValueLabel:{
              Text("0")
            }
            maximumValueLabel:{
              Text("100")
            }

            
          }.padding([.leading,.trailing],15)
            .padding([.top,.bottom],10)
        }
      }
      .background(
        Rectangle()
          .fill(Color.lightLightGray)

      )
      //
      MCSStatus(mcsState:motionControlStatus)
      
    }.frame(maxWidth: .infinity, maxHeight: .infinity)
      .fixedSize(horizontal: false, vertical: true)
    
  }
  
#else
  var body: some View {
    VStack(alignment: .leading, spacing: 1.0){
      HStack(alignment:.center){
        HStack(alignment: .top){
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
        .frame(width:650.0)
        //Spacer()
        MCSStatus(mcsState:motionControlStatus)
        
      }
      .background(Rectangle().fill(Color.lightLightGray))
      //
      KeyposeList(container: edelkroneAPI.shared.keyposes)
    }.frame(maxWidth: .infinity, maxHeight: .infinity)
      .fixedSize(horizontal: false, vertical: true)
  }
#endif
  
}

struct MotionControlInterface_Previews: PreviewProvider {
  static var previews: some View {
    MotionControlInterface()
  }
}


