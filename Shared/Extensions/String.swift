/**
 String.swift
 edelkroneTest
 
 Created by Carsten Müller on 11.03.2022.
 Copyright © 2022 Carsten Müller. All rights reserved.
 */

import Foundation
import edelkroneAPI

extension String{
  init(_ device:EdelkroneDevice){
    var result = "unknown device"
    switch(device){
    case .slideModule:
      result = "Slide Module v2"
    case .slideModuleV3:
      result = "Slide Module v3"
    case .sliderOnePro:
      result = "SliderONE PRO v2"
    case .sliderOne:
      result = "SliderOne v2"
    case .dollyPlus:
      result = "Dolly Plus"
    case .dollyOne:
      result = "DollyONE"
    case .dollyPlusPro:
      result = "DollyPLUS PRO"
    case .panPro:
      result = "PanPRO"
    case .headOne:
      result = "HeadONE"
    case .headPlus:
      result = "HeadPLUS v1"
    case .headPlusPro:
      result = "HeadPLUS v1 PRO"
    case .headPlusV2:
      result = "HeadPLUS v2"
    case .headPlusProV2:
      result = "HeadPLUS v2 PRO"
    case .focusPlusPro:
      result = "FocusPLUS PRO"
    case .jibOne:
      result = "JibONE"
    case .unknown:
      result = "Unknown"
    }
    self.init(result)
  }
  
  init(_ point: CGPoint){
    let result = "(" + String(format:"%1.03f",point.x ) + "," + String(format:"%1.03f",point.y )+")"
    self.init(result)
  }
  
}
