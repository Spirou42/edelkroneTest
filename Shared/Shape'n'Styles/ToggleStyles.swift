/**
 ToggleStyles.swift
 edelkroneTest
 
 Created by Carsten Müller on 27.03.22.
 Copyright © 2022 Carsten Müller. All rights reserved.
 */

import SwiftUI
import Extensions

struct ColoredToggleSwitch: ToggleStyle {
  var label = ""
  var onColor = Color(.green)
  var offColor = Color(.orange)
  var thumbColor = Color.white
  let width = 55.0
  let height = 30.0


  func makeBody(configuration: Self.Configuration) -> some View {
    let offset = (width - height) / 2.0
    HStack {
      Text(label)
      Button(action: { configuration.isOn.toggle() } )
      {
        RoundedRectangle(cornerRadius: height / 2, style: .circular)
          .fill(configuration.isOn ? onColor : offColor)
          .frame(width: width, height: height)
          .shadow(color: .darkGray  , radius: 0.8, x: -0.5, y: -0.5)
          .shadow(color: .lightWhite, radius: 0.8, x:  0.5, y:  0.5)
          .overlay(
            Circle()
              .fill(thumbColor)
              .shadow(color: .darkGray  , radius: 0.8, x:  0.5, y:  0.5)
              .shadow(color: .lightWhite, radius: 0.8, x: -0.5, y: -0.5)
              .padding(2.5)
              .offset(x: configuration.isOn ? offset : -offset, y: 0.0)
              
          )
          .animation(Animation.easeInOut(duration: 0.1),value: 2)
          .padding(10)
          //.background(Rectangle().fill(.black))
          
      }
      
      .buttonStyle(.borderless)
        //.padding(20)
        
    }
    //.frame(width: width+20, height: height+20)
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
  var bevelSize:Double = 5
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
            RoundedRectangle(cornerRadius: cornerRadius-bevelSize/2.0).fill(LinearGradient(gradient: Gradient(withMid: configuration.isOn ? onColor : offColor,offset: 0.10), startPoint: UnitPoint(x: 0.0, y: configuration.isOn ? 1.0:-0.20), endPoint: UnitPoint(x: 0.0, y: configuration.isOn ? 10.2:1.0)))
              .frame(width: width-bevelSize, height: height-bevelSize)
          }else{
            RoundedRectangle(cornerRadius: cornerRadius-bevelSize/2.0).fill(configuration.isOn ? onColor : offColor)
              .frame(width: width-bevelSize, height: height-bevelSize)
            
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
  var bevelSize:Double = 5
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
            RoundedRectangle(cornerRadius: radius-bevelSize/2.0).fill(LinearGradient(gradient: Gradient(withMid: configuration.isOn ? onColor : offColor,offset: 0.10), startPoint: UnitPoint(x: 0.0, y: configuration.isOn ? 1.0:-0.20), endPoint: UnitPoint(x: 0.0, y: configuration.isOn ? 10.2:1.0)))
              .frame(width: radius*2-bevelSize, height: radius*2-bevelSize)
          }else{
            RoundedRectangle(cornerRadius: radius-bevelSize/2.0).fill(configuration.isOn ? onColor : offColor)
              .frame(width: radius*2-bevelSize, height: radius*2-bevelSize)
            
          }
        }
      }
    }.buttonStyle(.borderless)
  }
}
