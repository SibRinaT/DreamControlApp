//
//  SettingsView.swift
//  DreamControlApp
//
//  Created by Ainur on 20.06.2024.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isAnimating") private var isAnimating: Bool = false
    @Binding var selectedTab: Int

    var body: some View {
        VStack {
            HStack {
                Image("DCIcon")
                Text("Настройки")
                    .font(.largeTitle)
                    .foregroundColor(Color("PrimaryColor"))
                    .bold()
                Spacer()
            }
            
            ScrollView {
                Toggle("Включить анимацию", isOn: $isAnimating)
                    .toggleStyle(YellowToggle())
            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
}

//#Preview {
//    SettingsView()
//}
