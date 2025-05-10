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
    @AppStorage("showDeleteConfirmations") private var showDeleteConfirmations: Bool = true

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
                Toggle(isOn: $isAnimating) {
                    Text("Включить анимацию")
                        .font(.custom("MontserratAlternates-Regular", size: 14))
                }
                .toggleStyle(YellowToggle())

                Toggle(isOn: $showDeleteConfirmations) {
                    Text("Показывать окно подтверждения")
                        .font(.custom("MontserratAlternates-Regular", size: 14))
                }
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
