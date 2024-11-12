//
//  SettingsView.swift
//  DreamControlApp
//
//  Created by Ainur on 20.06.2024.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isAnimating") private var isAnimating: Bool = false

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
                BigYellowButton(title: "Виджеты", image: "StoryIcon")
                    .padding(.bottom)
                BigYellowButton(title: "Аккаунт", image: "StoryIcon")
                    .padding(.bottom)
                BigYellowButton(title: "Уведомления", image: "StoryIcon")
                    .padding(.bottom)
                BigYellowButton(title: "Тема", image: "StoryIcon")
                    .padding(.bottom)
                BigYellowButton(title: "Анимации", image: "StoryIcon")
                    .padding(.bottom)
                BigYellowButton(title: "Язык", image: "StoryIcon")
                    .padding(.bottom)
                Toggle("Enable Animation", isOn: $isAnimating)
                }
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
}

#Preview {
    SettingsView()
}
