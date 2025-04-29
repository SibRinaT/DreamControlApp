//
//  StoryView.swift
//  DreamControlApp
//
//  Created by Ainur on 04.09.2024.
//

import SwiftUI
import DataProvider

struct StoryView: View {
    @Environment(\.dataHandler) private var dataHandler
    
    let dream: Dream
    @State var stories: [DreamStory]
    
    // Не используется?
    @State private var nextStoryId = UUID() // Для генерации уникальных идентификаторов историй
    @State private var showingNewStoryView = false // Стейт для отображения окна создания новой истории - используется
    @State private var storyToEdit: DreamStory?
    @State private var user = User(id: "123", name: "User", isAdmin: false) // Пример пользователя
    @State private var isSubscriptionViewPresented = false
    
    private var maxStoriesAllowed: Int {
            user.isSubscriptionEnabled ? 10 : 1 // Максимум 10 story для подписчиков и 1 для остальных
        }
    
    private var isEditingStoryView: Binding<Bool> {
        Binding(
            get: { storyToEdit != nil },
            set: { _ in storyToEdit = nil}
        )
    }
    
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
            VStack {
                List {
                    ForEach(stories) { story in
                        Button(action: {
                            storyToEdit = story
                        }) {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color("PrimaryColor")) // Прозрачный фон
                                .frame(height: 85)
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
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                delete(story: story) // Удаляем выбранную историю
                            } label: {
                                Label("Удалить", systemImage: "trash")
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .listRowBackground(Color.clear)
                    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                    
                    if (stories.count) < maxStoriesAllowed {
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
                    } else {
                        SubscriptionButton(text: "историй")
                    }
                }
                .listStyle(.plain)
            }
            .padding(.horizontal)
        }
        .sheet(isPresented: $showingNewStoryView) {
            // Добавляем новую историю после сохранения
            NewStoryView(onSave: addNewStory)
        }
        .sheet(isPresented: isEditingStoryView) {
            // Edit selected story
            StoryTextView(title: storyToEdit?.title ?? "",
                          storyContent: storyToEdit?.content ?? "",
                          isPresented: isEditingStoryView,
                          onSave: updateStory)
        }
    }
    
    private func delete(story: DreamStory) {
        Task {
            await dataHandler?.delete(story: story)
        }
    }
    
    private func addNewStory(title: String, content: String) {
        Task {
            let newStory = DreamStory(title: title, content: content)
            await dataHandler?.new(story: newStory, for: dream)
        }
    }
    
    private func updateStory(newTitle: String, newContent: String) {
        guard let storyToEdit else { return }
        if let index = stories.firstIndex(where: { $0.id == storyToEdit.id}) {
            let storyToUpdate = stories[index]
            storyToUpdate.title = newTitle
            storyToUpdate.content = newContent
        }
    }
}

//#Preview {
//    NavigationStack {
//        StoryView(dreamName: "test", stories: [DreamStory(id: UUID(), title: "Mystory", content: "super long story")])
//            .environment(\.dataHandler, DataHandler(modelContainer: DataProvider.shared.sharedModelContainer,
//                                                    mainActor: true))
//
//    }
//
//}
