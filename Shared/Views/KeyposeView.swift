//
//  KeyposeView.swift
//  edelkroneTest
//
//  Created by Carsten Müller on 15.04.22.
//

import SwiftUI
import edelkroneAPI

struct KeyposeView: View {
  
  @ObservedObject var slot:KeyposeSlot
  var body: some View {
    VStack(alignment: .leading, spacing: 4){
      HStack(){
        Text("Index:").frame(width:80,alignment: .trailing)
        Text(String(slot.index))
      }
      
      ForEach(Array(slot.axels.keys).sorted(by: {return $0 < $1})){ t in
        HStack(){
          Text("Axel:").frame(width:80,alignment: .trailing)
          Text(slot.axels[t]!?.axelName.toString() ?? "").frame(width:40,alignment:.leading)
          Text(String(format:"%0.03f",slot.axels[t]!?.axelPosition ?? 0.0)).monospacedDigit().frame(width:60,alignment: .leading)
          Text((slot.axels[t]!?.calibrated ?? false) ? "X" : "O")
        }
      }
    }
  }
}

struct KeyposeView_Previews: PreviewProvider {
  static var previews: some View {
    KeyposeView(slot: KeyposeSlot(0 , status: MotionControlStatus() ) )
  }
}
