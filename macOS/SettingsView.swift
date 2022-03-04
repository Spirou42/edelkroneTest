//
//  SettingsView.swift
//  edelkroneTest (macOS)
//
//  Created by Carsten Müller on 04.03.22.
//

import SwiftUI

struct SettingsView: View {
  private enum Tabs: Hashable {
    case general, advanced
  }
  var body: some View {
    TabView {

      GeneralSettingsView()
        .tabItem {
          Label("General", systemImage: "gear") //
        }
        .tag(Tabs.general)

      AdvancedSettingsView()
        .tabItem {
          Label("Advanced", systemImage: "star") //
        }
        .tag(Tabs.advanced)
    }
    .padding(20)
    .frame(width: 375, height: 150)
    .labelStyle(TitleAndIconLabelStyle())
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
