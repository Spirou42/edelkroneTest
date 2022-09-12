//
//  TestView.swift
//  edelkroneTest
//
//  Created by Carsten Müller on 24.04.22.
//

import SwiftUI
enum MyFruit {
  case banana, apple, peach
}

struct TestView: View {
  @State var favoriteFruit: MyFruit = .apple
  
  var fruitName: String {
    switch favoriteFruit {
    case .banana:
      return "Banana 🍌🍌"
    case .apple:
      return "Apple 🍎🍎"
    case .peach:
      return "Peach 🍑🍑"
    }
  }
  
  var body: some View {
    VStack(alignment:.leading){
      Text("My Favorite Fruit: \(fruitName)").frame(alignment:.leading)
      
      Picker("My Picker", selection: $favoriteFruit) {
        Text("Banana 🍌🍌")
          .tag(MyFruit.banana)
        Text("Apple 🍎🍎")
          .tag(MyFruit.apple)
        Text("Peach 🍑🍑")
          .tag(MyFruit.peach)
      }
      .pickerStyle(SegmentedPickerStyle())
    }
  }
}

struct TestView_Previews: PreviewProvider {
  static var previews: some View {
    TestView()
  }
}
