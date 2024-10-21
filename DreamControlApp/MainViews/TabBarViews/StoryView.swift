//
//  StoryView.swift
//  DreamControlApp
//
//  Created by Ainur on 04.09.2024.
//

import SwiftUI

struct StoryView: View {
    @Environment(StoriesService.self) private var storiesService
    @State var dream: Dream
    
    // Не используется?
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

                            Text(dream.name)
                                .foregroundColor(.white)
                                .bold()
                                .font(.title)
                        }
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                    }
                )

            List {
                ForEach(dream.stories) { story in
                    Button(action: {
                        print("Story clicked: \(story.title)")
                    }) {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color("PrimaryColor")) // Прозрачный фон
                            .frame(height: 75)
                            .overlay (
                                HStack {
                                    Image("StoryIcon")
                                        .padding()
                                    Text(story.title)
                                        .bold()
                                        .foregroundColor(.white)
                                        .font(.title2)
                                        .padding()
                                }
                            )
                    }
                }

                Button(action: {
                    showingNewStoryView = true // Открытие окна создания новой истории
                }, label: {
                    Rectangle()
                        .foregroundColor(.clear) // Прозрачный фон
                        .frame(height: 75)
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
                                        dream.stories.append(newStory)
                                        storiesService.update(dream: dream)
                                    }
                                }
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    StoryView(dream: Dream(id: UUID(), name: "test", image: "", stories: []))
        .environment(StoriesService())
}
