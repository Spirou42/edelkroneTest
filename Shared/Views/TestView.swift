//
//  TestView.swift
//  edelkroneTest
//
//  Created by Carsten Müller on 24.04.22.
//

import SwiftUI
import Extensions
enum MyFruit {
  case banana, apple, peach
}

struct TestView: View {
  @State var favoriteFruit: MyFruit = .apple
  @State var bubu: Bool = false
  @State var sliderValue: Double = 0.0
  @State private var isEditing = false
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
      Spacer()
      Toggle(isOn: $bubu){

      }
      .toggleStyle(ColoredToggleSwitch(label: "Some Text",
                                       onColor: Color("Theme Orange"),
                                       offColor: Color("Theme Red"),
                                       thumbColor: .white))
      //.background(Rectangle().fill(.red))
      Spacer()
      Image(systemName: "square.and.arrow.up").frame(width: 50, height: 50)
      Spacer()
      HStack(){
        Text("\u{22f2}").font(.custom("Symbols-Regular", size: 60))
        Text("\u{22f3}").font(.custom("Symbols-Regular", size: 60))
      }
      HStack(){
        Text("\u{10020D}").font(.custom("Symbols-Regular", size: 60))
        Text("\u{10020E}").font(.custom("Symbols-Regular", size: 60))
        Text("\u{10020F}").font(.custom("Symbols-Regular", size: 60))
      }
      VStack{
        Slider(value: $sliderValue, in: 0...100){
          Text("Speed")
      } minimumValueLabel: {
          Text("0")
      } maximumValueLabel: {
          Text("100")
      } onEditingChanged: { editing in
          isEditing = editing
      }.tint(.orange)
        Text("\(sliderValue)")
          .foregroundColor( isEditing ? .red : .green)
        
//        CustomSlider(sliderValue: $sliderValue)
//          .frame(width: 200, height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//          .padding([.top],3).padding([.bottom],20)
        Spacer()
      }

      
    }
  }
}

struct TestView_Previews: PreviewProvider {
  static var previews: some View {
    TestView()
  }
}
