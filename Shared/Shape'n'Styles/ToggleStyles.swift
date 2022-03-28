/**
 ToggleStyles.swift
 edelkroneTest
 
 Created by Carsten Müller on 27.03.22.
 Copyright © 2022 Carsten Müller. All rights reserved.
 */

import SwiftUI

struct ColoredToggleSwitch: ToggleStyle {
  var label = ""
  var onColor = Color(.green)
  var offColor = Color(.orange)
  var thumbColor = Color.white
  
  func makeBody(configuration: Self.Configuration) -> some View {
    HStack {
      Text(label)
      Button(action: { configuration.isOn.toggle() } )
      {
        RoundedRectangle(cornerRadius: 16, style: .circular)
          .fill(configuration.isOn ? onColor : offColor)
          .frame(width: 50, height: 29)
          .overlay(
            Circle()
              .fill(thumbColor)
              .shadow(radius: 1, x: 0, y: 1)
              .padding(1.5)
              .offset(x: configuration.isOn ? 10 : -10))
          .animation(Animation.easeInOut(duration: 0.1),value: 2)
      }.buttonStyle(.borderless)
    }
    .font(.title)
    //    .padding([.leading,.trailing],5)
  }
}



struct ColoredGlyphToggleButton:ToggleStyle{
  var onColor = Color.gray
  var offColor = Color(white:0.83)
  var onLabelColor = Color.white
  var offLabelColor = Color.darkGray
  var cornerRadius: Double = 5
  var offGlyph: Text = Text("")
  var onGlyph: Text? = nil

  var glyphLeadingPadding:Double = 8
  var glyphTopPadding:Double = 3
  var width:Double = 140
  var height:Double = 41
  var borderSize:Double = 5
  var useFaceGradient:Bool = false
  
  public func makeBody(configuration: ColoredGlyphToggleButton.Configuration) -> some View {
    Button(action: { configuration.isOn.toggle() } ){
      HStack(spacing:0) {
        if configuration.isOn{
          onGlyph
          .foregroundColor( onLabelColor)
          .padding([.leading],glyphLeadingPadding)
          .padding([.top], glyphTopPadding)
        }else{
          offGlyph
          .foregroundColor(offLabelColor)
          .padding([.leading],glyphLeadingPadding)
          .padding([.top], glyphTopPadding)
        }
        configuration.label
          .foregroundColor(configuration.isOn ? onLabelColor : offLabelColor)
      }
      
      .frame(width: width, height:height)
      .background(){
        ZStack{
          RoundedRectangle(cornerRadius: cornerRadius).fill(LinearGradient(gradient: Gradient(withMid: configuration.isOn ? onColor : offColor), startPoint: UnitPoint(x: 0.0, y: configuration.isOn ?0.0:1.0), endPoint: UnitPoint(x: 0.0, y: configuration.isOn ?1.0:0.0)))
          if useFaceGradient {
            RoundedRectangle(cornerRadius: cornerRadius-borderSize/2.0).fill(LinearGradient(gradient: Gradient(withMid: configuration.isOn ? onColor : offColor,offset: 0.10), startPoint: UnitPoint(x: 0.0, y: configuration.isOn ? 1.0:-0.20), endPoint: UnitPoint(x: 0.0, y: configuration.isOn ? 10.2:1.0)))
              .frame(width: width-borderSize, height: height-borderSize)
          }else{
            RoundedRectangle(cornerRadius: cornerRadius-borderSize/2.0).fill(configuration.isOn ? onColor : offColor)
              .frame(width: width-borderSize, height: height-borderSize)
            
          }
        }
      }
    }.buttonStyle(.borderless)
  }
}

struct ColoredCircleToggleButton:ToggleStyle{
  var onColor = Color.gray
  var offColor = Color.lightGray
  var onLabelColor = Color.white
  var offLabelColor = Color.darkGray
  var offGlyph: Text = Text("")
  var onGlyph: Text? = nil
  var glyphPadding:Double = 0
  var radius:Double = 20
  var borderSize:Double = 5
  var useFaceGradient:Bool = false
  
  public func makeBody(configuration: ColoredCircleToggleButton.Configuration) -> some View {
    Button(action: { configuration.isOn.toggle() } ){
      HStack(spacing:0) {
        if configuration.isOn{
          onGlyph
          .foregroundColor( onLabelColor)
          .padding([.leading],glyphPadding)
        }else{
          offGlyph
          .foregroundColor(offLabelColor)
          .padding([.leading],glyphPadding)
        }
      }
      
      .frame(width: radius*2, height:radius*2)
      .background(){
        ZStack{
          RoundedRectangle(cornerRadius: radius).fill(LinearGradient(gradient: Gradient(withMid: configuration.isOn ? onColor : offColor), startPoint: UnitPoint(x: 0.0, y: configuration.isOn ?0.0:1.0), endPoint: UnitPoint(x: 0.0, y: configuration.isOn ?1.0:0.0)))
          if useFaceGradient {
            RoundedRectangle(cornerRadius: radius-borderSize/2.0).fill(LinearGradient(gradient: Gradient(withMid: configuration.isOn ? onColor : offColor,offset: 0.10), startPoint: UnitPoint(x: 0.0, y: configuration.isOn ? 1.0:-0.20), endPoint: UnitPoint(x: 0.0, y: configuration.isOn ? 10.2:1.0)))
              .frame(width: radius*2-borderSize, height: radius*2-borderSize)
          }else{
            RoundedRectangle(cornerRadius: radius-borderSize/2.0).fill(configuration.isOn ? onColor : offColor)
              .frame(width: radius*2-borderSize, height: radius*2-borderSize)
            
          }
        }
      }
    }.buttonStyle(.borderless)
  }
}
