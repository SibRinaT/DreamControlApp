//
//  GigaChatView.swift
//  DreamControlApp
//
//  Created by Ainur on 11.04.2025.
//


import SwiftUI

struct GigaChatView: View {
    @State private var inputText: String = ""
    @State private var responseText: String = ""
    private let api = APIService()
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Введите запрос к ИИ", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Отправить") {
                Task {
                    do {
                        responseText = "⏳ Загружается..."
                        responseText = try await api.sendPrompt(inputText)                        
                    } catch {
                        responseText = "❌ Ошибка получения ответа"
                    }
                }
                responseText = "⏳ Загружается..."
                
            }
            .buttonStyle(.borderedProminent)
            
            ScrollView {
                Text(responseText)
                    .padding()
            }
        }
        .padding()
    }
}
