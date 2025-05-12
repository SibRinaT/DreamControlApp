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

    private let characterLimit = 2000
    
    @State private var isRegeneratePresented = false
    @State private var tempTitle = ""
    @State private var tempDescription = ""


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
                                .font(.custom("MontserratAlternates-Regular", size: 16))

                            Text(title) // change need
                                .foregroundColor(.white)
                                .bold()
                                .font(.custom("MontserratAlternates-Regular", size: 28))
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
                                Text("История вашей мечты")
                                    .font(.custom("MontserratAlternates-Regular", size: 28))
                                    .padding(.top, 30)
                                    .foregroundColor(Color("TextColor"))
//                                    .padding(.bottom)
                                
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
                                    TextField("Напишите историю мечты...", text: $storyContent, axis: .vertical)                    .font(.custom("MontserratAlternates-Regular", size: 14))
                                        .padding(16) // внутренние отступы
                                        .background(Color.clear) // убираем фон, чтобы не перекрывал рамку
                                        .onChange(of: storyContent) { newValue in
                                            if newValue.count > characterLimit {
                                                storyContent = String(newValue.prefix(characterLimit))
                                            }
                                        }
                                }
                                .padding(.horizontal, 40)

                                Text("Количество символов: \(storyContent.count)/\(characterLimit)")
                                            .padding()
                                            .font(.custom("MontserratAlternates-Regular", size: 14))
                                            .foregroundColor(Color("TextColor"))

                                .padding(.bottom)
                                
                                Button(action: {
                                    tempTitle = title
                                    tempDescription = storyContent
                                    isRegeneratePresented = true
                                }, label: {
                                    Text("Регенерировать историю")
                                        .font(.custom("MontserratAlternates-Regular", size: 16))
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(LinearGradient(
                                            gradient: Gradient(colors: [Color("Prem1"), Color("Prem2"), Color("Prem3")]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing)
                                        )
                                        .cornerRadius(100)
                                        .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                                })
                                .padding(.horizontal)

                                VStack {
                                    Button(action: {
                                        // Логика для сохранения истории
                                        onSave(title, storyContent)
                                        isPresented.toggle()
                                    }, label: {
                                        Rectangle()
                                            .foregroundColor(Color("PrimaryColor"))
                                            .cornerRadius(100)
                                            .frame(height: 50)
                                            .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                                            .overlay(
                                                Text("Сохранить")
                                                    .font(.title2)
                                                    .bold()
                                                    .foregroundColor(.white)
                                            )
                                    })
                                    .disabled(storyContent.isEmpty) // Отключить, если поля пустые
                                }
                                .padding(.horizontal)
                            }
                        }
                    )
                    .padding(.horizontal)
                    .sheet(isPresented: $isRegeneratePresented) {
                        NewStoryView(
                            storyTitle: tempTitle,
                            storyDescription: tempDescription
                        ) { newTitle, newStory in
                            self.title = newTitle
                            self.storyContent = newStory
                            self.isRegeneratePresented = false
                        }
                    }
        }
    }
}

#Preview {
    StoryTextView(isPresented: .constant(true)) {_, _ in}
}
