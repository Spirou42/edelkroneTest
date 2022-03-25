/**
 ButtonStyles.swift
 edelkroneTest
 
 Created by Carsten Müller on 12.03.22.
 */

import SwiftUI

struct ColoredToggleStyle: ToggleStyle {
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
      }.buttonStyle(.plain)
    }
    .font(.title)
    .padding([.leading,.trailing],5)
  }
}

struct ColoredButtonStyle: ButtonStyle {
  var buttonColor: Color = .green
  var labelColor: Color = .white
  var cornerRadius: Double = 5
  var shadowRadius:Double = 3

  public func makeBody(configuration: ColoredButtonStyle.Configuration) -> some View {

    configuration.label
      .frame(width: 120, height:41)
      .padding([.leading,.trailing],6)
      //.padding([.top,.bottom],5)
      .foregroundColor(labelColor)
      .background(RoundedRectangle(cornerRadius: 5).fill(buttonColor))

      .compositingGroup()
      .shadow(color: .black, radius: shadowRadius)
      .opacity(configuration.isPressed ? 0.5 : 1.0)

      .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
  }
}

struct ColoredGlyphButtonStyle: ButtonStyle {
  var buttonColor: Color = .green
  var labelColor: Color = .white
  var cornerRadius: Double = 5
  var shadowRadius:Double = 3
  var glyph: Text = Text("")
  var glyphPadding:Double = 8
  var width:Double = 140
  var height:Double = 41
  
  public func makeBody(configuration: ColoredGlyphButtonStyle.Configuration) -> some View {
    HStack(spacing:0) {
      glyph
        .foregroundColor(labelColor)
        .padding([.leading],glyphPadding)
      
      configuration.label
      
      //.padding([.leading,.trailing],2)
      //.padding([.top,.bottom],5)
        .foregroundColor(labelColor)
      
      
      /*
       .compositingGroup()
       .shadow(color: .black, radius: shadowRadius)
       .opacity(configuration.isPressed ? 0.5 : 1.0)
       
       .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
       */
    }
    .frame(width: width, height:height)
    .background(RoundedRectangle(cornerRadius: 5).fill(buttonColor))
  }
}





