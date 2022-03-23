//
//  MotionControlView.swift
//  edelkroneTest
//
//  Created by Carsten Müller on 23.03.22.
//

import SwiftUI

struct MotionControlView: View {
  @ObservedObject var motionControlStatus = edelkroneAPI.shared.pairedMotionControlSystemStatus
  var body: some View {
    VStack{
      ForEach(motionControlStatus.supportedAxes,id:\.self){ c in
        HStack{
        	Text("Axis :" + c.axis.rawValue)
          Text("On Device: " + c.device.rawValue)
        }
      }
    }
  }
}

struct MotionControlView_Previews: PreviewProvider {
    static var previews: some View {
        MotionControlView()
    }
}
