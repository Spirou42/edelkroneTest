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
  
  
  
  
  var body: some View {
    VStack(alignment: .trailing, spacing: 1.0){
      HStack(alignment:.top){
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
        Spacer()
        MCSStatus(mcsState:motionControlStatus)
      }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .fixedSize(horizontal: false, vertical: true)
        .background(Rectangle().fill(Color.lightLightGray))
      KeyposeList(container: KeyposeContainer(edelkroneAPI.shared.motionControlStatus))
    }
  }
}

struct MotionControlInterface_Previews: PreviewProvider {
  static var previews: some View {
    MotionControlInterface().frame(width:800)
  }
}


