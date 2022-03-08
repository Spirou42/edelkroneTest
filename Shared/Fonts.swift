//
//  Fonts.swift
//  TTimer
//
//  Created by Carsten Müller on 16.05.20.
//  Copyright © 2020 Carsten Müller. All rights reserved.
//

import Foundation
import SwiftUI

enum Symbols: String {
    case bold = "Symbols.ttf0"
    case semiBold = "Symbols.ttf1"
    case extraBold = "Symbols.ttf2"
    case light = "Symbols.ttf3"
    case regular = "Symbols"
}


extension ContentSizeCategory {
    var size: CGFloat {
        switch self {
        case .small:
            return 14
        case .medium:
            return 16
        case .large:
            return 20
        default:
            return 14
        }
    }
}

extension View {
    func customFont(_ font: Symbols, category: ContentSizeCategory) -> some View {
        return self.customFont(font.rawValue, category: category)
    }

    func customFont(_ name: String, category: ContentSizeCategory) -> some View {
        return self.font(.custom(name, size: category.size))
    }
}
