//
//  CGFloat.swift
//  edelkroneTest
//
//  Created by Carsten Müller on 19.03.22.
//

import Foundation
import SwiftUI

extension CGFloat {
    func text() -> String {
        return String(format: "%0.02f", Float(self))
    }
}
