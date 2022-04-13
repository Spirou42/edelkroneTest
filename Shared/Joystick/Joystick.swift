/**
 Joystick.swift
 edelkroneTest
 
 Created by Carsten Müller on 16.05.2022
 Copyright © 2022 Carsten Müller. All rights reserved.
 */

import SwiftUI
import edelkroneAPI
import Extensions

/// Simple protocol to connect a Joystick to an external object. A Single Object can be attached to each axis of a JoyStick


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
  var labelColor: Color
  
  public init(thumbGradient: Gradient = Gradient(colors: 	[.darkGray, .lightGray]),
              backgroundGradient: Gradient = Gradient(colors:[.gray, .gray]),
              strokeColor: Color = .accentColor,
              iconColor: Color = .primary,
              labelColor:Color = .orange) {
    
    self.thumbGradient = thumbGradient
    self.backgroundGradient = backgroundGradient
    self.strokeColor = strokeColor
    self.iconColor = iconColor
    self.labelColor = labelColor
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



/**
 The joystick view together with a simple gesture handler for drag gestures.
 Putting all the foremter component together into one view
 */
public struct Joystick<Label>: View where Label : View {
  var colorStyle: ColorStyle = ColorStyle()
  var isDebug = false
  var label:Label
  
  var axelObjects:[DegreeOfFreedom:JoystickControlledAxel] = [:]
  
  var enabled:Bool = true
  @State private var joystickDirection: JoystickDirection = .center
  @State private var locationX: CGFloat = 0
  @State private var locationY: CGFloat = 0
  
  @State private var disableHorizontal:Bool = false
  @State private var disableVertical:Bool = false
  
  
  
  public var action: ((_ joyStickState: JoystickDirection, _ stickPosition: CGPoint) -> Void)? = nil
  
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
          if freedoms.contains(.horizontal) && (disableHorizontal == false){
            self.locationX = value.location.x
          }
          if freedoms.contains(.vertical) && (disableVertical == false){
            self.locationY = value.location.y
          }
        } else {
          let radian = self.origin.getRadian(pointOnCircle: value.location)
          let pointOnCircle = self.origin.getPointOnCircle(radius: smallRingLimitCenter, radian: radian)
          if freedoms.contains(.horizontal) && (disableHorizontal == false){
            self.locationX = pointOnCircle.x
          }
          if freedoms.contains(.vertical) && (disableVertical == false){
            self.locationY = pointOnCircle.y
          }
        }
        
        self.joystickDirection = self.calcJoystickState()
        (self.action ?? self.defaultAction)(self.joystickDirection,  self.stickPosition)
      }
      .onEnded{ value in
        self.locationX = self.padDiameter/2
        self.locationY = self.padDiameter/2
        
        self.locationX = self.padRadius
        self.locationY = self.padRadius
        
        self.joystickDirection = .center
        
        (self.action ?? self.defaultAction)(self.joystickDirection,  self.stickPosition)
        self.stopMovement()
      }
  }
  
  public func stopMovement() {
    var verticalObject = axelObjects[.vertical]
    var horizontalObject = axelObjects[.horizontal]
    verticalObject?.isLastMove = true
    horizontalObject?.isLastMove = true
    
  }
  public func defaultAction(_ joyStickState: JoystickDirection, _ stickPosition: CGPoint) -> Void {
    var verticalObject = axelObjects[.vertical]
    verticalObject?.shouldMove = true
    verticalObject?.moveValue = stickPosition.y
    verticalObject?.isLastMove = false
    
    var horizontalObject = axelObjects[.horizontal]
    horizontalObject?.shouldMove = true
    horizontalObject?.moveValue = stickPosition.x
    horizontalObject?.isLastMove = false
  }
  
  public init( isDebug: Bool = false,
               enabled:Bool = true,
               axelObjects:[DegreeOfFreedom:JoystickControlledAxel] = [:],
               freedoms: DegreeOfFreedom = .all,
               colorStyle: ColorStyle = ColorStyle(),
               thumbRadius: CGFloat = 42,
               padRadius: CGFloat = 100,
               action: ((_ joyStickState: JoystickDirection, _ stickPosition: CGPoint) -> Void)? = nil ,
               @ViewBuilder label:() -> Label) {
    
    self.isDebug = isDebug
    self.enabled = enabled
    
    self.axelObjects = axelObjects
    self.freedoms = freedoms
    
    self.colorStyle = colorStyle
    
    self.thumbRadius = thumbRadius
    self.padRadius = padRadius
    
    self.action = action
    self.label = label()
    
  }
  
  
  public var body: some View {
    
      VStack(){
        HStack(alignment: .center) {
          if freedoms.numberOfFreedoms() == 2 {
          Toggle(isOn: $disableVertical){
          }
          .toggleStyle(ColoredGlyphToggleButton(cornerRadius: 3,
                                                offGlyph:Text("\u{2196}").font(.custom("Symbols-Regular", size: 45) ),
                                                onGlyph: Text("\u{2197}").font(.custom("Symbols-Regular", size: 45) ),
                                                glyphLeadingPadding: 0,
                                                glyphTopPadding: 4,
                                                width: 24,
                                                height: 80
                                               ))
          }
          
          ZStack {
            JoystickPad(
              backgroundGradient: self.colorStyle.backgroundGradient,
              strokeColor: self.colorStyle.strokeColor,
              diameter: padDiameter)
            
            .overlay(
              ZStack{
                if freedoms.contains(.vertical) && (disableVertical == false) {
                  AxisArrows(direction: .vertical, outerRadius: self.padRadius, innerRadius: self.thumbRadius, colorStyle: self.colorStyle)
                }
                if freedoms.contains(.horizontal) && (disableHorizontal == false){
                  AxisArrows(direction: .horizontal, outerRadius: self.padRadius, innerRadius: self.thumbRadius, colorStyle: self.colorStyle)
                }
              }
            ).gesture(dragGesture, including: self.enabled ? .all : .none)
            
            
            JoystickThumb(diameter: self.thumbDiameter,
                          thumbInnerGradient: self.colorStyle.thumbGradient){
              self.label.foregroundColor(colorStyle.labelColor)
            }
                          .offset(x: thumbLocationX, y: thumbLocationY)
                          .allowsHitTesting(false)
          }
        }
        if freedoms.numberOfFreedoms() == 2 {
        Toggle(isOn: $disableHorizontal){
        }.padding([.leading],34)
        .toggleStyle(ColoredGlyphToggleButton(cornerRadius: 3,
                                              offGlyph:Text("\u{290F}").font(.custom("Symbols-Regular", size: 45) ),
                                              onGlyph: Text("\u{290E}").font(.custom("Symbols-Regular", size: 45) ),
                                              glyphLeadingPadding: 0,
                                              glyphTopPadding: 4,
                                              width: 80,
                                              height: 24
                                             ))
        }
        
        
      }.opacity(self.enabled ? 1.0 : 0.5)
      .onAppear(){
      self.locationX = self.padRadius
      self.locationY = self.padRadius
    }.padding(10)
  }
}



struct Joystick_Previews: PreviewProvider {
  static var colorized = ColorStyle(thumbGradient: Gradient(whithDark: Color("JoystickThumbDark")),
                                    backgroundGradient: Gradient(whithDark: Color("JoystickBackgroundDark")),
                                    strokeColor: Color("JoystickRing"),
                                    labelColor: .white
  )
  
  static var previews: some View {
    GeometryReader { geometry in
      HStack(alignment: .center, spacing: 0) {
        Joystick(isDebug: true, freedoms: [.all], colorStyle: colorized, action: { (joyStickState, stickPosition) in})
        {
          Text("Pan")
        }
        
        //.frame(width: geometry.size.width-40, height: geometry.size.width-40)
        
        Joystick(enabled:false, freedoms: .horizontal, colorStyle: ColorStyle(),
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
