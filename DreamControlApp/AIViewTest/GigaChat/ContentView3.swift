//
//  ContentView.swift
//  DreamControlApp
//
//  Created by Ainur on 10.04.2025.
//


import SwiftUI

struct ContentView3: View {
    @State private var prompt: String = ""
      @State private var responseText: String = ""
      @State private var isLoading: Bool = false

      let networkManager = GigaChatNetworkManager()

      var body: some View {
          NavigationView {
              VStack(spacing: 20) {
                  TextField("Введите запрос...", text: $prompt)
                      .textFieldStyle(RoundedBorderTextFieldStyle())
                      .padding()

                  Button(action: {
                      sendPrompt()
                  }) {
                      Text("Отправить")
                          .frame(maxWidth: .infinity)
                  }
                  .padding()
                  .buttonStyle(.borderedProminent)
                  .disabled(prompt.isEmpty || isLoading)

                  if isLoading {
                      ProgressView()
                          .padding()
                  } else {
                      ScrollView {
                          Text(responseText)
                              .padding()
                      }
                  }
              }
              .navigationTitle("GigaChat")
              .padding()
          }
      }

      func sendPrompt() {
          isLoading = true
          responseText = ""
          networkManager.sendPrompt(prompt: prompt) { result in
              DispatchQueue.main.async {
                  self.isLoading = false
                  switch result {
                  case .success(let answer):
                      self.responseText = answer
                  case .failure(let error):
                      self.responseText = "Ошибка: \(error.localizedDescription)"
                  }
              }
          }
      }
  }
