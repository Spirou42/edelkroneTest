/**
 ViewExtensions.swift
  edelkroneTest

  Created by Carsten Müller on 08.03.22.
 */


import SwiftUI

extension View {
  func border(_ color: Color, width: CGFloat, edges: [Edge]) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
  
  func inset() -> some View{
    overlay(EdgeBorder(width: 1, edges: [.top,.leading]).foregroundColor(Color("insetTop")))
      .overlay(EdgeBorder(width: 1, edges: [.bottom,.trailing]).foregroundColor(Color("insetBottom")))
  }
  func outset() -> some View{
    overlay(EdgeBorder(width: 1, edges: [.top,.leading]).foregroundColor(Color("insetBottom")))
      .overlay(EdgeBorder(width: 1, edges: [.bottom,.trailing]).foregroundColor(Color("insetTop")))

  }
}
