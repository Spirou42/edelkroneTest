//
//  TestView.swift
//  edelkroneTest
//
//  Created by Carsten Müller on 12.03.22.
//

import SwiftUI

struct TestView: View {
  
  var body: some View {
    
    VStack{
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
    }.padding()
  }
}

struct TestView_Previews: PreviewProvider {
  static var previews: some View {
    TestView()
  }
}
