/**
 ButtonStyles.swift
 edelkroneTest
 
 Created by Carsten Müller on 12.03.22.
 Copyright © 2022 Carsten Müller. All rights reserved.
 */

import SwiftUI



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
    .background(RoundedRectangle(cornerRadius: cornerRadius).fill(buttonColor))
  }
}


struct GradientGlyphButtonStyle: ButtonStyle {
  var buttonColor: Color = .green
  var labelColor: Color = .white
  var cornerRadius: Double = 5
  var shadowRadius:Double = 3
  var glyph: Text = Text("")
  var glyphPadding:Double = 8
  var width:Double = 140
  var height:Double = 41
  var borderSize:Double = 5
  var useFaceGradient:Bool = false
  
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
    .background(){
      ZStack{
        RoundedRectangle(cornerRadius: cornerRadius).fill(LinearGradient(gradient: Gradient(withMid: buttonColor), startPoint: UnitPoint(x: 0.0, y: 1.0), endPoint: UnitPoint(x: 0.0, y: 0.0)))
        if useFaceGradient {
          RoundedRectangle(cornerRadius: cornerRadius-borderSize/2.0).fill(LinearGradient(gradient: Gradient(withMid: buttonColor,offset: 0.10), startPoint: UnitPoint(x: 0.0, y: -0.20), endPoint: UnitPoint(x: 0.0, y: 1.0)))
            .frame(width: width-borderSize, height: height-borderSize)
        }else{
          RoundedRectangle(cornerRadius: cornerRadius-borderSize/2.0).fill(buttonColor)
            .frame(width: width-borderSize, height: height-borderSize)
          
        }
      }
    }
    .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    
    
  }
}







