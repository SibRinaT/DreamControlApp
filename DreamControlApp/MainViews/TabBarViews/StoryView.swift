//
//  StoryView.swift
//  DreamControlApp
//
//  Created by Ainur on 04.09.2024.
//

import SwiftUI
struct StoryView: View {
    let dreamName: String
    @State private var stories = [DreamStory]()
    @State private var nextStoryId = UUID() // Для генерации уникальных идентификаторов историй
    @State private var showingNewStoryView = false // Стейт для отображения окна создания новой истории

    var body: some View {
        VStack {
            HStack {
                Image("DCIcon")
                Text("Истории")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color("PrimaryColor"))
                Spacer()
            }
            .padding(.horizontal)

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

                            Text("\(dreamName)")
                                .foregroundColor(.white)
                                .bold()
                                .font(.title)
                        }
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                    }
                )

            List {
                ForEach(stories) { story in
                    Button(action: {
                        // Действие при нажатии на историю
                        print("Story clicked: \(story.title)")
                    }) {
                        HStack {
                            Image("StoryIcon")
                            Text(story.title)
                                .font(.headline)
                                .padding()
                        }
                    }
                }

                Button(action: {
                    showingNewStoryView = true // Открытие окна создания новой истории
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
                            Text("Создать историю")
                                .foregroundColor(Color("PrimaryColor"))
                                .font(.largeTitle)
                                .bold()
                        )
                })
                .sheet(isPresented: $showingNewStoryView) {
                                    NewStoryView { title, content in
                                        // Добавляем новую историю после сохранения
                                        let newStory = DreamStory(id: UUID(), title: title, content: content)
                                        stories.append(newStory)
                                    }
                                }
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    StoryView(dreamName: "Dream")
}
