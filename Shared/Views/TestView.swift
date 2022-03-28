/**
 TestView.swift
 edelkroneTest
 
 Created by Carsten Müller on 12.03.22.
 Copyright © 2022 Carsten Müller. All rights reserved.
 */

import SwiftUI

struct TestView: View {
  @State private var showGreeting = false
  var body: some View {
    
    VStack(spacing:10){
      Button( action: {}){
        Text("Connect")
          .font(.applicationFont(.title2))
          .frame(maxWidth:.infinity, alignment: .center)
      }
      .buttonStyle(ColoredGlyphButtonStyle(buttonColor:   Color.red,
                                           glyph: Text("\u{22f2}" )
        .font(.custom("Symbols-Regular", size: 27))
                                          )
      )
      
      Button( action: {}){
        
        Text("Detect")
          .font(.applicationFont(.title2))
          .frame(maxWidth:.infinity, alignment: .center)
      }
      .buttonStyle(ColoredGlyphButtonStyle(buttonColor: .mint,
                                           glyph: Text("\u{22f4}")
        .font(.custom("Symbols-Regular", size: 27))
                                          )
      )
      
      Button(action:{}){
        Text("Disconnect")
          .font(.applicationFont(.title2))
          .frame(maxWidth:.infinity, alignment: .center)
      }.buttonStyle(ColoredGlyphButtonStyle(buttonColor: .green,
                                            labelColor: .white,
                                            glyph: Text("\u{22f3}")
        .font(.custom("Symbols-Regular", size: 27))
                                           ))
      
      Button(action:{}){
        Text("Disconnect")
          .font(.applicationFont(.title2))
          .frame(maxWidth:.infinity, alignment: .center)
      }.buttonStyle(GradientGlyphButtonStyle(buttonColor: .green,
                                             labelColor: .white,
                                             glyph: Text("\u{22f3}")
        .font(.custom("Symbols-Regular", size: 27)),
                                             useFaceGradient: false
                                            ))
      
      Toggle("Babelfisch",isOn: $showGreeting).toggleStyle(ColoredToggleSwitch()).background(Rectangle().fill(Color.gray))
      //      if showGreeting {
      //        Text("Hello World!")
      //      }
      
      Toggle("Babelfisch",isOn: $showGreeting).toggleStyle(.switch)
      Toggle("Babelfisch",isOn: $showGreeting).toggleStyle(.automatic)
      Toggle(isOn: $showGreeting){
        Text("Babelfisch").font(.title2).padding()
      }.toggleStyle(ColoredGlyphToggleButton())

      Toggle(isOn: $showGreeting){
      }
      .toggleStyle(ColoredGlyphToggleButton(cornerRadius: 3, offGlyph:Text("\u{290F}").font(.custom("Symbols-Regular", size: 45) ), onGlyph: Text("\u{290E}").font(.custom("Symbols-Regular", size: 45) ),glyphLeadingPadding: 0, glyphTopPadding:1, width: 80, height:24 ))

      Toggle(isOn: $showGreeting){
      }
      .toggleStyle(ColoredGlyphToggleButton(cornerRadius: 3, offGlyph:Text("\u{2196}").font(.custom("Symbols-Regular", size: 45) ), onGlyph: Text("\u{2197}").font(.custom("Symbols-Regular", size: 45) ),glyphLeadingPadding: 0, glyphTopPadding:4, width:24, height:80 ))

      
    }.padding()
  }
}

struct TestView_Previews: PreviewProvider {
  static var previews: some View {
    TestView()
  }
}
