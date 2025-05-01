//
//  ContentView.swift
//  DreamControlApp
//
//  Created by Ainur on 10.04.2025.
//


import SwiftUI

struct GrokView: View {
    @StateObject private var viewModel = GigaChatViewModel()
    @State private var prompt: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Введите запрос для истории", text: $prompt)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    viewModel.fetchStory(prompt: prompt)
                }) {
                    Text("Получить историю")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(viewModel.isLoading || prompt.isEmpty)
                .padding(.horizontal)
                
                if viewModel.isLoading {
                    ProgressView()
                }
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
                
                ScrollView {
                    Text(viewModel.responseText)
                        .padding()
                }
            }
            .navigationTitle("GigaChat Stories")
        }
    }
}

#Preview {
    GrokView()
}
