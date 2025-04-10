//
//  AITextView.swift
//  DreamControlApp
//
//  Created by Ainur on 10.04.2025.
//


import SwiftUI

struct AITextView: View {
    @State private var responseText: String = ""
    @State private var isLoading: Bool = false
    
    private let authService = GigaChatAuthService()
    private let chatService = GigaChatService()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("GigaChat от Сбера")
                .font(.title)
                .bold()
            
            Button(action: generateText) {
                Text("Сгенерировать текст")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(isLoading)
            
            if isLoading {
                ProgressView("Загрузка...")
            } else {
                ScrollView {
                    Text(responseText.isEmpty ? "Здесь появится текст..." : responseText)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                }
            }
        }
        .padding()
    }
    
    private func generateText() {
        isLoading = true
        responseText = ""
        
        authService.fetchAccessToken { token in
            guard let token = token else {
                DispatchQueue.main.async {
                    self.responseText = "❌ Не удалось получить токен"
                    self.isLoading = false
                }
                return
            }
            
            chatService.generateText(prompt: "Напиши вдохновляющий рассказ о силе дружбы", accessToken: token) { text in
                DispatchQueue.main.async {
                    self.responseText = text ?? "⚠️ Ошибка генерации текста"
                    self.isLoading = false
                }
            }
        }
    }
}
