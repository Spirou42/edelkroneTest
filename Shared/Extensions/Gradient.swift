//
//  Gradient.swift
//  edelkroneTest
//
//  Created by Carsten Müller on 21.03.22.
//

import SwiftUI

extension Gradient {
  init(withLight color: Color, offset:Double = 0.26){
    let hsva = color.hsva
    let darkColor = Color(hue: hsva.hue, saturation: hsva.saturation, brightness: hsva.value - offset)
    self.init(colors: [darkColor,color])
  }
  
  init(whithDark color: Color, offset:Double = 0.26){
    let hsva = color.hsva
    let highlightColor = Color(hue: hsva.hue, saturation: hsva.saturation, brightness: hsva.value + offset)
    self.init(colors: [color,highlightColor])
  }
}
