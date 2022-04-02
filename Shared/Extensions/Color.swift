/**
 Color.swift
 edelkroneTest
 
 Created by Carsten Müller on 19.03.22.
 Copyright © 2022 Carsten Müller. All rights reserved.
 
 */
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
  
  public static var lightWhite:Color{
    return Color(white:0.97)
  }
  
  public static var darkWhite:Color {
    return Color(white:0.95)
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
  
  public struct Theme {
    public static var Blue:Color {
      return Color("Theme Blue")
    }
    public static var BlueDark:Color {
      return Color("Theme BlueDark")
    }
    public static var BlueDarker:Color {
      return Color("Theme BlueDarker")
    }
    public static var BlueLight:Color {
      return Color("Theme BlueLight")
    }
    public static var BlueLighter:Color {
      return Color("Theme BlueLighter")
    }

    public static var Red:Color {
      return Color("Theme Red")
    }
    public static var RedDark:Color {
      return Color("Theme RedDark")
    }
    public static var RedDarker:Color {
      return Color("Theme RedDarker")
    }
    public static var RedLight:Color {
      return Color("Theme RedLight")
    }
    public static var redLighter:Color {
      return Color("Theme RedLighter")
    }
    
    public static var Green:Color {
      return Color("Theme Green")
    }
    public static var GreenDark:Color {
      return Color("Theme GreenDark")
    }
    public static var GreenDarker:Color {
      return Color("Theme GreenDarker")
    }
    public static var GreenLight:Color {
      return Color("Theme GreenLight")
    }
    public static var GreenLighter:Color {
      return Color("Theme GreenLighter")
    }
    
    public static var Orange:Color {
      return Color("Theme Orange")
    }
    public static var OrangeDark:Color {
      return Color("Theme OrangeDark")
    }
    public static var OrangeDarker:Color {
      return Color("Theme OrangeDarker")
    }
    public static var OrangeLight:Color {
      return Color("Theme OrangeLight")
    }
    public static var OrangeLighter:Color {
      return Color("Theme OrangeLighter")
    }

  }
  
}
