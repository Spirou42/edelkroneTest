/**
 Joystick.swift
 edelkroneTest
 
 Created by Carsten Müller on 16.05.2022
 Copyright © 2022 Carsten Müller. All rights reserved.
 */

import SwiftUI

struct JoystickThumb: View {
  var diameter: CGFloat
  var outerRing: CGFloat = 15
  var thumbInnerGradient: Gradient
  
  var body: some View {
    ZStack{
      Circle().fill(
        LinearGradient(gradient: thumbInnerGradient, startPoint: UnitPoint(x: 0.0, y: 1.0), endPoint: UnitPoint(x: 0.0, y: 0.0))
      )
      .frame(width: diameter, height: diameter)
      
      Circle().fill(
        LinearGradient(gradient: thumbInnerGradient, startPoint: UnitPoint(x: 0.0, y: 0.0), endPoint: UnitPoint(x: 0.0, y: 0.7))
      )
      .frame(width: diameter-outerRing, height: diameter-outerRing)
    }
  }
}

struct JoystickPad: View {
  @Environment(\.colorScheme) var colorScheme
  
  var backgroundGradient: Gradient
  var strokeColor: Color
  var diameter: CGFloat
  var outerRing: CGFloat = 5.0
  
  var gradient = Gradient(colors:[Color("JoystickBackgroundLight"),Color("JoystickBackgroundDark")])
  
  var body: some View {
    ZStack {
      Circle().stroke(strokeColor, lineWidth: 2)
        .frame(width: diameter, height: diameter)
      
      
      Circle().fill(
        LinearGradient(gradient: backgroundGradient, startPoint: UnitPoint(x: 0.0, y: 1.0), endPoint: UnitPoint(x: 0.0, y: 0.0))
      )
      .frame(width: diameter, height: diameter)
      
      Circle().fill(
        LinearGradient(gradient: backgroundGradient, startPoint: UnitPoint(x: 0.0, y: 0.0), endPoint: UnitPoint(x: 0.0, y: 1.0))
      )
      .frame(width: diameter-outerRing, height: diameter-outerRing)
      
    }
  }
}

public enum JoystickDirection: String {
  case up
  case down
  case left
  case right
  case center
}

public struct ColorStyle {
  var thumbGradient: Gradient
  var backgroundGradient: Gradient
  var strokeColor: Color
  var iconColor: Color
  
  public init(thumbGradient: Gradient = Gradient(colors: 	[.darkGray, .lightGray]),
              backgroundGradient: Gradient = Gradient(colors:[.gray, .gray]),
              strokeColor: Color = .accentColor,
              iconColor: Color = .primary) {
    
    self.thumbGradient = thumbGradient
    self.backgroundGradient = backgroundGradient
    self.strokeColor = strokeColor
    self.iconColor = iconColor
  }
}

public struct Joystick: View {
  var colorStyle: ColorStyle = ColorStyle()
  
  var isDebug = false
  
  var stickPosition: CGPoint {
    let stickPositionX = floor(locationX - padRadius)
    
    let stickPositionY = floor((locationY - padRadius) < 0 ? -1 * (locationY - padRadius) : locationY - padRadius)
    
    return CGPoint(x: stickPositionX, y: stickPositionY)
  }
  
  @State private var joystickDirection: JoystickDirection = .center
  
  public var completionHandler: ((_ joyStickState: JoystickDirection, _ stickPosition: CGPoint) -> Void)
  
  var origin: CGPoint {
    return CGPoint(x: self.padRadius, y: self.padRadius)
  }
  
  @State var locationX: CGFloat = 0
  @State var locationY: CGFloat = 0
  
  let iconPadding: CGFloat = 10
  
  var thumbDiameter: CGFloat {
    return thumbRadius*2
  }
  
  var padDiameter: CGFloat {
    return padRadius*2
  }
  
  var thumbRadius: CGFloat
  var padRadius: CGFloat
  
  var thumbLocationX: CGFloat {
    return locationX - padRadius
  }
  
  var thumbLocationY: CGFloat {
    return locationY - padRadius
  }
  
  private func calcJoystickState() -> JoystickDirection {
    var state: JoystickDirection = .center
    
    let xValue = locationX - padRadius
    let yValue = locationY - padRadius
    
    if (abs(xValue) > abs(yValue)) {
      state = xValue < 0 ? .left : .right
    } else if (abs(yValue) > abs(xValue)) {
      state = yValue < 0 ? .up : .down
    }
    
    return state
  }
  
  var dragGesture: some Gesture {
    DragGesture(minimumDistance: 0)
      .onChanged{ value in
        let distance = self.origin.getDistance(otherPoint: value.location)
        
        let smallRingLimitCenter: CGFloat = self.padRadius - self.thumbRadius
        
        if (distance <= smallRingLimitCenter) {
          self.locationX = value.location.x
          self.locationY = value.location.y
        } else {
          let radian = self.origin.getRadian(pointOnCircle: value.location)
          let pointOnCircle = self.origin.getPointOnCircle(radius: smallRingLimitCenter, radian: radian)
          
          self.locationX = pointOnCircle.x
          self.locationY = pointOnCircle.y
        }
        
        self.joystickDirection = self.calcJoystickState()
        self.completionHandler(self.joystickDirection,  self.stickPosition)
      }
      .onEnded{ value in
        self.locationX = self.padDiameter/2
        self.locationY = self.padDiameter/2
        
        self.locationX = self.padRadius
        self.locationY = self.padRadius
        
        self.joystickDirection = .center
        
        self.completionHandler(self.joystickDirection,  self.stickPosition)
      }
  }
  
  
  public init(isDebug: Bool = false, colorStyle: ColorStyle, thumbRadius: CGFloat = 50, padRadius: CGFloat = 140,
              completionHandler: @escaping ((_ joyStickState: JoystickDirection, _ stickPosition: CGPoint) -> Void)) {
    
    self.isDebug = isDebug
    self.colorStyle = colorStyle
    
    self.thumbRadius = thumbRadius
    self.padRadius = padRadius
    
    self.completionHandler = completionHandler
  }
  
  public var body: some View {
    
    VStack {
      if isDebug {
        VStack {
          HStack(spacing: 15) {
            Text(stickPosition.x.text()).font(.body)
            Text(":").font(.body)
            
            Text(stickPosition.y.text()).font(.body)
          }
          
        }.padding(10)
      }
      
      HStack() {
        ZStack {
          JoystickPad(
            backgroundGradient: self.colorStyle.backgroundGradient,
            strokeColor: self.colorStyle.strokeColor,
            diameter: padDiameter)
          .gesture(dragGesture)
          
          JoystickThumb(diameter: self.thumbDiameter,
                        thumbInnerGradient: self.colorStyle.thumbGradient)
          .offset(x: thumbLocationX, y: thumbLocationY)
          .allowsHitTesting(false)
        }
        
      }
      
      
      if isDebug {
        HStack(spacing: 15) {
          Text(joystickDirection.rawValue).font(.body)
        }
      }
    }.onAppear(){
      self.locationX = self.padRadius
      self.locationY = self.padRadius
    }.padding(10)
  }
}



struct Joystick_Previews: PreviewProvider {
  static var colorized = ColorStyle(thumbGradient: Gradient(colors:[Color("JoystickThumbDark"),
                                                                      Color("JoystickThumbLight")]
                                                             ),
                                      backgroundGradient: Gradient(colors:[Color("JoystickBackgroundDark"),
                                                                           Color("JoystickBackgroundLight")]
                                                                  ),
                                      strokeColor: Color("JoystickRing"),
                                      iconColor: .pink)
  
  static var previews: some View {
    GeometryReader { geometry in
      HStack(alignment: .center, spacing: 0) {
        Joystick(colorStyle: colorized )
        { (joyStickState, stickPosition) in
          
        }
        //.frame(width: geometry.size.width-40, height: geometry.size.width-40)
        
        Joystick(colorStyle: ColorStyle(iconColor: .orange),
                 thumbRadius: 70, padRadius: 120
        ) { (joyStickState, stickPosition)  in
          
        }
        //.frame(width: geometry.size.width-40, height: geometry.size.width-40)
      }
    }
  }
}
