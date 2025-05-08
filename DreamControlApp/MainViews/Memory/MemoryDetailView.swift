//
//  MemoryDetailView.swift
//  DreamControlApp
//
//  Created by Ainur on 08.05.2025.
//

import SwiftUI

struct MemoryDetailView: View {
    @State var title = "Воспоминание"
    @State var storyContent = ""
    @Binding var isPresented: Bool
    var onSave: (String, String) -> Void

    private let characterLimit = 400
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color("PrimaryColor"))
                .frame(height: 100)
                .overlay(
                    HStack {
                        Image("CloudForDream")
                        VStack {
                            Text("Воспоминание")
                                .foregroundColor(Color("InactiveColor2"))
                                .bold()
                                .font(.headline)
                            
                            Text(title)
                                .foregroundColor(.white)
                                .bold()
                                .font(.title)
                        }
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                    }
                )
            
            RoundedRectangle(cornerRadius: 20)
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                .foregroundColor(.white)
                .ignoresSafeArea(.all)
                    .overlay(
            ScrollView {
                VStack {
                    VStack {
                        Text("Воспоминания о вашей мечте")
                            .foregroundColor(Color("TextColor"))
                            .bold()
                            .font(.title3)
                        ZStack {
                            // Контейнер с рамкой
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color("Prem1"), Color("Prem2"), Color("Prem3")]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 3
                                )
                            
                            // Контент внутри рамки
                            TextField("Напишите воспоминания о мечте...", text: $storyContent, axis: .vertical)
                                .padding(16) // внутренние отступы
                                .background(Color.clear) // убираем фон, чтобы не перекрывал рамку
                                .onChange(of: storyContent) { newValue in
                                    if newValue.count > characterLimit {
                                        storyContent = String(newValue.prefix(characterLimit))
                                    }
                                }
                        }
                        Text("Фото на память")
                            .foregroundColor(Color("TextColor"))
                            .bold()
                            .font(.title3)
                        VStack {
                            HStack {
                                ZStack {
                                    // Контейнер с рамкой
                                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                                        .stroke(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color("Prem1"), Color("Prem2"), Color("Prem3")]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            ),
                                            lineWidth: 3
                                        )
                                    Text("Фото 1")
                                        .foregroundColor(Color("TextColor"))
                                        .font(.title3)
                                }
                                
                                ZStack {
                                    // Контейнер с рамкой
                                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                                        .stroke(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color("Prem1"), Color("Prem2"), Color("Prem3")]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            ),
                                            lineWidth: 3
                                        )
                                    Text("Фото 2")
                                        .foregroundColor(Color("TextColor"))
                                        .font(.title3)
                                }
                            }
                            .frame(height: 150)
                            
                            HStack {
                                ZStack {
                                    // Контейнер с рамкой
                                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                                        .stroke(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color("Prem1"), Color("Prem2"), Color("Prem3")]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            ),
                                            lineWidth: 3
                                        )
                                    Text("Фото 3")
                                        .foregroundColor(Color("TextColor"))
                                        .font(.title3)
                                }
                                ZStack {
                                    // Контейнер с рамкой
                                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                                        .stroke(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color("Prem1"), Color("Prem2"), Color("Prem3")]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            ),
                                            lineWidth: 3
                                        )
                                    Text("Фото 4")
                                        .foregroundColor(Color("TextColor"))
                                        .font(.title3)
                                }
                            }
                            .frame(height: 150)
                        }
                        
                        
                    }
                    .padding(.horizontal, 40)
                }
                .padding(.vertical)
            })
                    .padding(.horizontal)
        }
    }
}

#Preview {
    MemoryDetailView(isPresented: .constant(true)) {_, _ in}
}
