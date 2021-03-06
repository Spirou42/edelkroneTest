/**
 CGPoint.swift
 Extension to CGPoint for the Joystick class
 
 Created by Carsten Müller on 16.05.2022
 Copyright © 2022 Carsten Müller. All rights reserved.
 */

import Foundation

extension CGPoint {
  
  func getPointOnCircle(radius: CGFloat, radian: CGFloat) -> CGPoint {
    let x = self.x + radius * cos(radian)
    let y = self.y + radius * sin(radian)
    
    return CGPoint(x: x, y: y)
  }
  
  func getRadian(pointOnCircle: CGPoint) -> CGFloat {
    
    let originX = pointOnCircle.x - self.x
    let originY = pointOnCircle.y - self.y
    var radian = atan2(originY, originX)
    
    while radian < 0 {
      radian += CGFloat(2 * Double.pi)
    }
    
    return radian
  }
  
  func getDistance(otherPoint: CGPoint) -> CGFloat {
    return sqrt(pow((otherPoint.x - x), 2) + pow((otherPoint.y - y), 2))
  }
}
