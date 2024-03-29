/**
 Fonts.swift
 Extension to SwiftUIs Font class to support own font definitions from an AssetSet
 
 Created by Carsten Müller on 16.05.2020
 Copyright © 2020 Carsten Müller. All rights reserved.
 */

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


struct FontDefinition : Decodable {
  let face: String
  let size: Double
}

struct FontContainer : Decodable{
  var fonts: [String:FontDefinition]
}

extension String {
  init(_ style: Font.TextStyle){
    var result = ""
    switch(style){
    case .largeTitle:
      result="largeTitle"
    case .title:
      result = "title"
    case .title2:
      result = "title2"
    case .title3:
      result = "title3"
    case .headline:
      result = "headline"
    case .subheadline:
      result = "subheadline"
    case .body:
      result = "body"
    case .callout:
      result = "callout"
    case .caption:
      result = "caption"
    case .caption2:
      result = "caption2"
    case .footnote:
      result = "footnote"
    default:
      result = "body"
    }
    self.init(result)
  }
  
  init(_ style: Font.applicationTextStyle){
    var result = ""
    switch(style){
    case .poseTitle:
      result="poseTitle"
    case .poseTitle2:
      result = "poseTitle2"
 
    }
    self.init(result)
  }
  
}

extension Font {
  static var definitions:[String:FontDefinition]?
  
  static func loadDefinitions(){
    let dataAsset = NSDataAsset(name: "VisualData")
    let decoder = PropertyListDecoder()
    let wrapper = try? decoder.decode(FontContainer.self, from: dataAsset!.data)
    if(wrapper != nil){
//      print("got a decode")
      definitions = wrapper!.fonts
    }
  }
  fileprivate static func fontForName(_ styleKey: String) -> Font {
    let fontName = definitions![styleKey]!.face
    let fontSize = definitions![styleKey]!.size
    if fontName.starts(with: "System"){
      // extract
      guard var  index = fontName.firstIndex(of: " ") else { return Font.system(size: fontSize) }
      index = fontName.index(after:index)
      let weigthName = fontName[index...fontName.index(before: fontName.endIndex)]
      let lowerWeightName = weigthName.lowercased()
      var resultFontWeight:Font.Weight = .regular
      switch lowerWeightName{
      case "regular":
        resultFontWeight = .regular
      case "black":
        resultFontWeight = .black
      case "bold":
        resultFontWeight = .bold
      case "heavy":
        resultFontWeight = .heavy
      case "light":
        resultFontWeight = .light
      case "medium":
        resultFontWeight = .medium
      case "semibold":
        resultFontWeight = .semibold
      case "thin":
        resultFontWeight = .thin
      case "ultraLight":
        resultFontWeight = .ultraLight
      default:
        resultFontWeight = .regular
      }
      var returnFont = Font.system(size: fontSize)
      returnFont = returnFont.weight(resultFontWeight)
      return returnFont
    }else{
      return Font.custom(fontName, size: fontSize)
    }
  }
  
  static func applicationFont(_ style: Font.TextStyle)->Font{
    if(definitions == nil){
      loadDefinitions()
    }
    let styleKey = String(style)
    if(definitions!.keys.contains(styleKey)){
      return fontForName(styleKey)
    }
    return self.body
  }
  
  static func applicationFont(_ applicationStyle: Font.applicationTextStyle)->Font{
    if(definitions == nil){
      loadDefinitions()
    }
    let styleKey = String(applicationStyle)
    if(definitions!.keys.contains(styleKey)){
      return fontForName(styleKey)
    }
    return self.body
  }
  
  static func applicationFontName(_ style: Font.TextStyle)->String{
    if(definitions == nil){
      loadDefinitions()
    }
    let styleKey = String(style)
    if(definitions!.keys.contains(styleKey)){
      let fontName = definitions![styleKey]!.face
      return fontName
    }
    return "System"
  }
  
  static func applicationFontSize(_ style: Font.TextStyle)->Double{
    if(definitions == nil){
      loadDefinitions()
    }
    let styleKey = String(style)
    if(definitions!.keys.contains(styleKey)){
      let fontSize = definitions![styleKey]!.size
      return fontSize
    }
    return Double(13.0)
  }
  
  public enum applicationTextStyle : String, Decodable{
    case poseTitle = "poseTitle"
    case poseTitle2 = "poseTitle2"
  }
  
  
  
}
