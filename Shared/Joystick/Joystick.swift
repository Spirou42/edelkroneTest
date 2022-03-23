/**
 Joystick.swift
 edelkroneTest
 
 Created by Carsten Müller on 16.05.2022
 Copyright © 2022 Carsten Müller. All rights reserved.
 */

import SwiftUI

/**
 The JoystickThumb is the smal circle moved by the user
 */
struct JoystickThumb<Label>: View where Label : View{
  var diameter: CGFloat
  var outerRing: CGFloat = 15
  var thumbInnerGradient: Gradient
  let label:Label
  
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
      label
    }
  }

  init(diameter: CGFloat, outerRing: CGFloat = 15, thumbInnerGradient: Gradient, @ViewBuilder _ label: () ->Label){
    self.diameter = diameter
    self.outerRing = outerRing
    self.thumbInnerGradient = thumbInnerGradient
    self.label = label()
  }
  
}
/**
 The JoystickPad is the large pad, the thumb can move in.
 */
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

/**
 The "direction" the thumb is moved. also known as the dominat axis
 */
public enum JoystickDirection: String {
  case up
  case down
  case left
  case right
  case center
}

/**
 The color style used by the joystick
 */
public struct ColorStyle {
  /// the gradient used by the thumb
  var thumbGradient: Gradient
  
  /// the gradient used by the pad
  var backgroundGradient: Gradient
  
  /// the accent color used to draw a strok around the pad
  var strokeColor: Color
  
  /// an unused iconColor. Currently no icons ar suported
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

/**
 a simple arow shape used to draw the axel arrows inside the pad
 */
struct AxisArrow: Shape {
  func path(in rect: CGRect) -> Path {
    Path { path in
      let width = rect.width
      let height = rect.height
      
      path.addLines( [
        CGPoint(x: width * 0.3, y: height),
        CGPoint(x: width * 0.3, y: height * 0.4),
        CGPoint(x: width * 0.0, y: height * 0.4),
        CGPoint(x: width * 0.5, y: height * 0.1),
        CGPoint(x: width * 1.0, y: height * 0.4),
        CGPoint(x: width * 0.7, y: height * 0.4),
        CGPoint(x: width * 0.7, y: height)
        
      ])
      path.closeSubpath()
    }
  }
}

/**
 an collection of two arrow indicating  the axis movment
 */
struct AxisArrows : View {
  enum axisDirection {
    case horizontal,vertical,diagonalLeft,diagonalRight
  }
  let direction:axisDirection
  var outerRadius:Double
  var innerRadius:Double
  var colorStyle:ColorStyle
  
  var axisAngle:Angle{
    get{
      switch direction {
      case .vertical:
        return Angle(degrees:0)
      case .horizontal:
        return Angle(degrees:90)
      case .diagonalLeft:
        return Angle(degrees: -45)
      case .diagonalRight:
        return Angle(degrees: 45)
      }
    }
  }
  /// positioning the arrow around a circle. beware of the diagonals as they are multiplied by sin 45 deg
  var offset:CGPoint {
    get{
      switch direction {
      case .horizontal:
        return CGPoint(x: (innerRadius+(outerRadius-innerRadius)/2), y: 0)
      case .vertical:
        return CGPoint(x: 0, y: (innerRadius+(outerRadius-innerRadius)/2))
      case .diagonalLeft:
        return CGPoint(x: -(innerRadius+(outerRadius-innerRadius)/2) * 0.707 , y: (innerRadius+(outerRadius-innerRadius)/2) * 0.707)
      case .diagonalRight:
        return CGPoint(x: (innerRadius+(outerRadius-innerRadius)/2) * 0.707, y: (innerRadius+(outerRadius-innerRadius)/2) * 0.707)
      }
    }
  }
  
  var body: some View {
    Group{
      RotatedShape(shape: AxisArrow(), angle: axisAngle)
        .fill(LinearGradient(gradient: colorStyle.backgroundGradient, startPoint: UnitPoint(x: 0.0, y: 1.0), endPoint: UnitPoint(x: 0.0, y: 0.0)))
        .frame(width: (outerRadius-innerRadius)/3.236, height: (outerRadius-innerRadius)/1.618)
        .offset(x:offset.x, y:-offset.y)
      RotatedShape(shape: AxisArrow(), angle: axisAngle)
        .stroke()
        .frame(width: (outerRadius-innerRadius)/3.236, height: (outerRadius-innerRadius)/1.618)
        .offset(x:offset.x, y:-offset.y)
      
      RotatedShape(shape: AxisArrow(), angle: axisAngle+Angle(degrees: 180))
        .fill(LinearGradient(gradient: colorStyle.backgroundGradient, startPoint: UnitPoint(x: 0.0, y: 0.0), endPoint: UnitPoint(x: 0.0, y: 1.0)))
        .frame(width: (outerRadius-innerRadius)/3.236, height: (outerRadius-innerRadius)/1.618)
        .offset(x:-offset.x, y: offset.y)
      
      RotatedShape(shape: AxisArrow(), angle: axisAngle+Angle(degrees: 180))
        .stroke()
        .frame(width: (outerRadius-innerRadius)/3.236, height: (outerRadius-innerRadius)/1.618)
        .offset(x:-offset.x, y: offset.y)
      
    }
  }
}


public struct DegreeOfFreedom:OptionSet {
  public let rawValue: Int
  public static let none:DegreeOfFreedom = []
  public static let horizontal = DegreeOfFreedom(rawValue: 1)
  public static let vertical = DegreeOfFreedom(rawValue: 2)
  public static let all:DegreeOfFreedom = [.horizontal, .vertical]
  public init(rawValue:Int){
    self.rawValue = rawValue
  }
}

/**
 The joystick view together with a simple gesture handler for drag gestures.
 Putting all the foremter component together into one view
 */
public struct Joystick<Label>: View where Label : View{
  var colorStyle: ColorStyle = ColorStyle()
  var isDebug = false
  var label:Label

  var enabled:Bool = true
  @State private var joystickDirection: JoystickDirection = .center
  @State private var locationX: CGFloat = 0
  @State private var locationY: CGFloat = 0
  
  
  public var action: ((_ joyStickState: JoystickDirection, _ stickPosition: CGPoint) -> Void)
  
  var freedoms: DegreeOfFreedom = .none
  
  var stickPosition: CGPoint {
    let stickPositionX = (locationX - padRadius) / (padRadius - thumbRadius) // floor(
    
    let stickPositionY = (padRadius - locationY) / (padRadius - thumbRadius) // < 0 ? -1 * (locationY - padRadius) : locationY - padRadius)
    
    return CGPoint(x: stickPositionX, y: stickPositionY)
  }
  
  
  var origin: CGPoint {
    return CGPoint(x: self.padRadius, y: self.padRadius)
  }
  
  
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
          if freedoms.contains(.horizontal){
            self.locationX = value.location.x
          }
          if freedoms.contains(.vertical){
            self.locationY = value.location.y
          }
        } else {
          let radian = self.origin.getRadian(pointOnCircle: value.location)
          let pointOnCircle = self.origin.getPointOnCircle(radius: smallRingLimitCenter, radian: radian)
          if freedoms.contains(.horizontal){
            self.locationX = pointOnCircle.x
          }
          if freedoms.contains(.vertical){
            self.locationY = pointOnCircle.y
          }
        }
        
        self.joystickDirection = self.calcJoystickState()
        self.action(self.joystickDirection,  self.stickPosition)
      }
      .onEnded{ value in
        self.locationX = self.padDiameter/2
        self.locationY = self.padDiameter/2
        
        self.locationX = self.padRadius
        self.locationY = self.padRadius
        
        self.joystickDirection = .center
        
        self.action(self.joystickDirection,  self.stickPosition)
      }
  }
  
  
  public init( isDebug: Bool = false,
               enabled:Bool = true,
               freedoms: DegreeOfFreedom = .all,
               colorStyle: ColorStyle,
               thumbRadius: CGFloat = 50,
               padRadius: CGFloat = 140,
               action: @escaping ((_ joyStickState: JoystickDirection, _ stickPosition: CGPoint) -> Void),
               @ViewBuilder label:() -> Label) {
    
    self.isDebug = isDebug
    self.colorStyle = colorStyle
    
    self.thumbRadius = thumbRadius
    self.padRadius = padRadius
    
    self.action = action
    self.freedoms = freedoms
    self.label = label()
    self.enabled = enabled
  }
  
  
  public var body: some View {
    
    VStack {
      if isDebug {
        VStack {
          HStack(spacing: 3) {
            Text(stickPosition.x.text()).font(.body).monospacedDigit()
            Text(":").font(.body)
            Text(stickPosition.y.text()).font(.body).monospacedDigit()
          }
          
        }.padding(5)
      }
      
      HStack() {
        ZStack {
          JoystickPad(
            backgroundGradient: self.colorStyle.backgroundGradient,
            strokeColor: self.colorStyle.strokeColor,
            diameter: padDiameter)
          
          .overlay(
            ZStack{
              if freedoms.contains(.vertical) {
              	AxisArrows(direction: .vertical, outerRadius: self.padRadius, innerRadius: self.thumbRadius, colorStyle: self.colorStyle)
              }
              if freedoms.contains(.horizontal){
              	AxisArrows(direction: .horizontal, outerRadius: self.padRadius, innerRadius: self.thumbRadius, colorStyle: self.colorStyle)
              }
            }
          ).gesture(dragGesture, including: self.enabled ? .all : .none)
          

          JoystickThumb(diameter: self.thumbDiameter,
                        thumbInnerGradient: self.colorStyle.thumbGradient){
            self.label
          }
          .offset(x: thumbLocationX, y: thumbLocationY)
          .allowsHitTesting(false)
        }
        
      }.opacity(self.enabled ? 1.0 : 0.5)
      
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
  static var colorized = ColorStyle(thumbGradient: Gradient(whithDark: Color("JoystickThumbDark")),
                                    backgroundGradient: Gradient(whithDark: Color("JoystickBackgroundDark")),
                                    strokeColor: Color("JoystickRing"),
                                    iconColor: .pink)
  
  static var previews: some View {
    GeometryReader { geometry in
      HStack(alignment: .center, spacing: 0) {
        Joystick(isDebug: true, freedoms: [.horizontal], colorStyle: colorized, action: { (joyStickState, stickPosition) in})
        {
          Text("Pan")
        }
        
        //.frame(width: geometry.size.width-40, height: geometry.size.width-40)
        
        Joystick(enabled:false, colorStyle: ColorStyle(iconColor: .orange),
                 thumbRadius: 70, padRadius: 120, action: { (joyStickState, stickPosition)  in }){
          VStack{
          	Text("Dummy")
            Text("Dump")
          }.font(.applicationFont(.caption2).weight(.medium)).foregroundColor(.white)
          
        }
      
        //.frame(width: geometry.size.width-40, height: geometry.size.width-40)
      }
    }
  }
}
