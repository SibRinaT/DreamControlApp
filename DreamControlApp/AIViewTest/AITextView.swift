//
//  ContentView.swift
//  DreamControlApp
//
//  Created by Ainur on 17.03.2025.
//


import SwiftUI

struct AITextView: View {
    @State private var output = ""
    @State private var isLoading = false

    let authService = GigaChatAuthService()
    let chatService = GigaChatService()

    var body: some View {
        VStack(spacing: 20) {
            Button("Сгенерировать текст") {
                isLoading = true
                authService.fetchAccessToken { token in
                    guard let token = token else {
                        output = "Не удалось получить токен"
                        isLoading = false
                        return
                    }

                    chatService.generateText(prompt: "Напиши художественный рассказ про осенний лес", accessToken: token) { response in
                        DispatchQueue.main.async {
                            output = response ?? "Ошибка генерации"
                            isLoading = false
                        }
                    }
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            if isLoading {
                ProgressView()
            } else {
                ScrollView {
                    Text(output)
                        .padding()
                }
            }
        }
        .padding()
    }
}


#Preview {
    AITextView()
}
