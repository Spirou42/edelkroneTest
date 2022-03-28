/**
 EdgeShape.swift
 edelkroneTest
 
 Created by Carsten Müller on 08.03.22.
 Copyright © 2022 Carsten Müller. All rights reserved.
 */

import SwiftUI
/**
 a Simple Shape to draw borders single borders
 */
struct EdgeBorder: Shape {
  
  var width: CGFloat
  var edges: [Edge]
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    for edge in edges {
      var x: CGFloat {
        switch edge {
        case .top, .bottom, .leading: return rect.minX
        case .trailing: return rect.maxX - width
        }
      }
      
      var y: CGFloat {
        switch edge {
        case .top, .leading, .trailing: return rect.minY
        case .bottom: return rect.maxY - width
        }
      }
      
      var w: CGFloat {
        switch edge {
        case .top, .bottom: return rect.width
        case .leading, .trailing: return self.width
        }
      }
      
      var h: CGFloat {
        switch edge {
        case .top, .bottom: return self.width
        case .leading, .trailing: return rect.height
        }
      }
      path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
    }
    return path
  }
}



