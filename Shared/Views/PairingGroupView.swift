//
//  SwiftUIView.swift
//  edelkroneTest
//
//  Created by Carsten Müller on 15.03.22.
//

import SwiftUI

struct PairingGroupView: View {
  @ObservedObject var pairingGroup: PairingGroup
  var body: some View {
    VStack(alignment: .leading, spacing: 8){
      Text("Group: " + String(pairingGroup.groupID) )
        .font(.applicationFont(.title3))
      VStack(alignment: .leading, spacing: 8){
        ForEach(pairingGroup.groupedControlSystems){ mcs in
          VStack( alignment: .leading, spacing: 0){
            HStack{
              Text(String(mcs.deviceType))
                .font(.applicationFont(.largeTitle))
              if(mcs.deviceType == .headOne){
                Text(mcs.isTilted ? "(Tilt)" : "(Pan)")
                  .font(.applicationFont(.largeTitle))
                  .padding([.trailing],20)
              }
            }
            HStack{
              Text( (mcs == pairingGroup.groupMaster) ? "Master" : "Member")
                .font(.applicationFont(.body))

              Text(mcs.macAddress)
                .font(.applicationFont(.body))
            }
          }
        }
      }
    }
  }
}

struct PairingGroupView_Previews: PreviewProvider {
  static var previews: some View {
    PairingGroupView(pairingGroup: PairingGroup())
  }
}
