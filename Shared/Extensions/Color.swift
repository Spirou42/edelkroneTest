//
//  Color.swift
//  edelkroneTest
//
//  Created by Carsten Müller on 19.03.22.
//

import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif


extension Color {
	/// a light gray color (85% white)
  public static var lightGray:Color {
    get { return Color(white: 0.85) }
  }
  public static var lightLightGray:Color{
    get{ return Color(white: 0.92)}
  }
  /// a dark gray color ( 85% black)
  public static var darkGray:Color {
    return Color(white: 0.25)
  }
  
  /**
   a couple of usefull methods to get the rgba and hsva components form a SwiftUI Color
   */
#if canImport(UIKit)
  var asNative: UIColor { UIColor(self) }
#elseif canImport(AppKit)
  var asNative: NSColor { NSColor(self) }
#endif
  /// retrives the RGBA compnents from a SwiftUI color
  var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
    let color = asNative.usingColorSpace(.deviceRGB)!
    var t = (CGFloat(), CGFloat(), CGFloat(), CGFloat())
    color.getRed(&t.0, green: &t.1, blue: &t.2, alpha: &t.3)
    return t
  }
  
  var hsva: (hue: CGFloat, saturation: CGFloat, value: CGFloat, alpha: CGFloat) {
    let color = asNative.usingColorSpace(.deviceRGB)!
    var t = (CGFloat(), CGFloat(), CGFloat(), CGFloat())
    color.getHue(&t.0, saturation: &t.1, brightness: &t.2, alpha: &t.3)
    return t
  }
  
}
