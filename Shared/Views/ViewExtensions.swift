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
}
