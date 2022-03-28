/**
 Gradient.swift
 edelkroneTest
 
 Created by Carsten Müller on 21.03.22.
 Copyright © 2022 Carsten Müller. All rights reserved.
 */

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
  
  init(withMid color: Color, offset:Double = 0.26){
    let hsva = color.hsva
    let lighlighColor = Color.init(hue: hsva.hue, saturation: hsva.saturation, brightness: hsva.value+offset/2.0)
    let darkColor = Color.init(hue: hsva.hue, saturation: hsva.saturation, brightness: hsva.value-offset/2.0)
    self.init(colors: [darkColor,lighlighColor])
  }
}
