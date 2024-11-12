//
//  SettingsView.swift
//  DreamControlApp
//
//  Created by Ainur on 20.06.2024.
//

import SwiftUI

struct SettingsView: View {
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
            
            VStack {
                Button(action: {
                }) {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color("PrimaryColor")) // Прозрачный фон
                        .frame(height: 85)
                        .overlay (
                            HStack {
                                Image("StoryIcon")
                                    .padding()
                                Text("Виджеты")
                                    .bold()
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .padding()
                            }
                        )
                }
            }
        }
        .padding(.horizontal )
    }
}

#Preview {
    SettingsView()
}
