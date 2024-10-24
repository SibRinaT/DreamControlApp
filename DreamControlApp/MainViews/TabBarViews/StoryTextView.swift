//
//  StoryTextView.swift
//  DreamControlApp
//
//  Created by Ainur on 18.09.2024.
//

import SwiftUI

struct StoryTextView: View {
    @State var title = ""
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
                            Text("Мечта")
                                .foregroundColor(Color("InactiveColor2"))
                                .bold()
                                .font(.headline)
                            
                            Text(title) // change need
                                .foregroundColor(.white)
                                .bold()
                                .font(.title)
                        }
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                    }
                )
            RoundedRectangle(cornerRadius: 20)
                .shadow(radius: 10)
                .foregroundColor(.white)
                .ignoresSafeArea(.all)
                    .overlay(
                        ScrollView {
                            VStack {
                                Text("История вашей мечты")
                                    .font(.title)
                                    .padding(.top, 30)
//                                    .padding(.bottom)
                                
                                ZStack {
                                    Group {
                                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                                            .stroke(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [Color("Prem1"), Color("Prem2"), Color("Prem3")]),
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                ),
                                                lineWidth: 3
                                            )
                                            .background(Color.clear) // Прозрачный фон
                                            .frame(width: 300, height: 400) // Размеры прямоугольник
                                        ScrollView {
                                            TextField("Напишите историю успеха", text: $storyContent, axis: .vertical)
                                                .padding(.horizontal)
                                                .padding(.vertical)
                                                .onChange(of: storyContent) { newValue in
                                                    if newValue.count > characterLimit {
                                                        storyContent = String(newValue.prefix(characterLimit))
                                                    }
                                                }
                                        }
                                    }
                                    .padding(.horizontal, 100)
                                }
                                
                                Text("Количество символов: \(storyContent.count)/\(characterLimit)")
                                            .padding()
                    
                                .padding(.bottom)
                                HStack {
                                    Button(action: {
                                        // Логика для сохранения истории
                                        onSave(title, storyContent)
                                        isPresented.toggle()
                                    }, label: {
                                        Rectangle()
                                            .foregroundColor(Color("PrimaryColor"))
                                            .cornerRadius(100)
                                            .frame(height: 50)
                                            .shadow(radius: 1)
                                            .overlay(
                                                Text("Сохранить")
                                                    .font(.title2)
                                                    .foregroundColor(.white)
                                            )
                                    })
                                    .disabled(storyContent.isEmpty) // Отключить, если поля пустые
                                    Button(action: {
                                        // Закрытие окна без сохранения
                                        isPresented.toggle()
                                    }, label: {
                                        Rectangle()
                                            .foregroundColor(Color("PrimaryColor"))
                                            .cornerRadius(100)
                                            .frame(height: 50)
                                            .shadow(radius: 51)
                                            .overlay(
                                                Text("Отмена")
                                                    .font(.title2)
                                                    .foregroundColor(.white)
                                            )
                                    })
                                }
                                .padding(.horizontal, 100)
                            }
                        }
                    )
                    .padding(.horizontal)
        }
    }
}

#Preview {
    StoryTextView(isPresented: .constant(true)) {_, _ in}
}
