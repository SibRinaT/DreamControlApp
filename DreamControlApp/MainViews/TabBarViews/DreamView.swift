//
//  DreamView.swift
//  DreamControlApp
//
//  Created by Ainur on 16.06.2024.
//
import SwiftUI

struct DreamView: View {
    @State private var buttons: [String] = []
    @State private var showingAlert = false
    @State private var newButtonName = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image("DCIcon")
                    Text("Мечтания")
                        .font(.largeTitle)
                        .foregroundColor(Color("PrimaryColor"))
                        .bold()
                    Spacer()
                }
                
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(buttons, id: \.self) { button in
                            Button(action: {}, label: {
                                HStack {
                                    Text(button)
                                    Image("")
                                        .font(.title)
                                        .frame(maxWidth: .infinity, minHeight: 85)
                                        .background(Color("PrimaryColor"))
                                        .foregroundColor(.white)
                                        .cornerRadius(20)
                                }
                            })
                        }
                        
                        Button(action: {
                            showingAlert = true
                        }, label: {
                            Rectangle()
                                .foregroundColor(.clear) // Прозрачный фон
                                .frame(height: 85)
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(
                                            style: StrokeStyle(
                                                lineWidth: 2,
                                                dash: [15] // Длина штрихов и пробелов в пунктирной линии
                                            )
                                        )
                                        .foregroundColor(Color("PrimaryColor")) // Цвет обводки
                                )
                                .overlay(
                                    Text("Добавить мечту")
                                        .foregroundColor(Color("PrimaryColor"))
                                        .font(.largeTitle)
                                        .bold()
                                )
                        })
                    }
                }
            }
            .padding(.horizontal)
            .alert("Новая мечта", isPresented: $showingAlert) {
                TextField("Введите название", text: $newButtonName)
                Button("Добавить") {
                    if !newButtonName.isEmpty {
                        buttons.append(newButtonName)
                        newButtonName = ""
                    }
                }
                Button("Отмена", role: .cancel) {}
            }
        }
    }
}

#Preview {
    DreamView()
}
