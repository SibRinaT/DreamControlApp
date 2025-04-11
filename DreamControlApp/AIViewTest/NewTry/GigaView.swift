//
//  ContentView.swift
//  DreamControlApp
//
//  Created by Ainur on 10.04.2025.
//


import SwiftUI

struct GigaView: View {
    @StateObject private var apiService = APIService()
    
    var body: some View {
        VStack {
            Text("Ответ от сервера:")
                .font(.headline)
                .padding()
            
            ScrollView {
                Text(apiService.responseText)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()

            Button(action: {
                apiService.fetchData() // Отправить запрос при нажатии кнопки
            }) {
                Text("Отправить запрос")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    GigaView()
}
