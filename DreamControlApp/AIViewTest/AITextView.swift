//
//  ContentView.swift
//  DreamControlApp
//
//  Created by Ainur on 17.03.2025.
//


import SwiftUI

struct AITextView: View {
    @State private var generatedText = "Здесь появится текст..."
    @State private var isLoading = false  // Следим за состоянием загрузки
    var body: some View {
        VStack {
            Text(generatedText)
                .padding()
                .opacity(isLoading ? 0.5 : 1.0) // Полупрозрачный текст при загрузке
                .animation(.easeInOut, value: isLoading)
            
            if isLoading {
                ProgressView() // Спиннер
                    .padding()
            }
            
            Button("Сгенерировать текст") {
                generateTextFromKoboldAI(prompt: "Напиши сказку про волшебный лес") { result in
                    generatedText = result
                    isLoading = false  // Отключаем спиннер после получения ответа
                }
                isLoading = true // Включаем спиннер перед отправкой запроса
            }
            .padding()
            .disabled(isLoading) // Блокируем кнопку во время запроса
        }
    }
}

#Preview {
    AITextView()
}
