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
                    .font(.custom("MontserratAlternates-Regular", size: 32))
                    .foregroundColor(Color("PrimaryColor"))
                    .bold()
                Spacer()
            }
            
            ScrollView {
                Toggle("Включить анимацию", isOn: $isAnimating)
                    .toggleStyle(YellowToggle())
                    .font(.custom("MontserratAlternates-Regular", size: 14))
            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
}

//#Preview {
//    SettingsView()
//}
