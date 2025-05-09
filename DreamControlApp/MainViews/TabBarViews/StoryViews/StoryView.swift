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
    
    @State private var nextStoryId = UUID() // Для генерации уникальных идентификаторов историй
    @State private var showingNewStoryView = false // Стейт для отображения окна создания новой истории - используется
    @State private var storyToEdit: DreamStory?
//    @State private var user = User(id: "123", name: "User", isAdmin: false) // Пример пользователя
    @State private var isSubscriptionViewPresented = false
    @EnvironmentObject var userManager: UserManager

    private var maxStoriesAllowed: Int {
        userManager.isSubscriptionEnabled ? 10 : 3
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
                    .font(.custom("MontserratAlternates-Regular", size: 32))
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
                                    .font(.custom("MontserratAlternates-Regular", size: 14))

                                Text(dream.name)
                                    .foregroundColor(.white)
                                    .bold()
                                    .font(.custom("MontserratAlternates-Regular", size: 28))
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
                                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                                .foregroundColor(Color("PrimaryColor")) // Прозрачный фон
                                .frame(height: 85)
                                .overlay (
                                    HStack {
                                        Image("StoryIcon")
                                            .padding()
                                        Text(story.title)
                                            .bold()
                                            .foregroundColor(.white)
                                            .font(.custom("MontserratAlternates-Regular", size: 20))
                                            .padding()
                                    }
                                )
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                delete(story: story) // Удаляем выбранную историю
                            } label: {
                                Label("Удалить", systemImage: "trash")
                                    .font(.custom("MontserratAlternates-Regular", size: 16))
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .listRowBackground(Color.clear)
                    
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
                                        .font(.custom("MontserratAlternates-Regular", size: 24))
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
        // Начинаем анимацию удаления
        withAnimation {
            // Удаляем элемент с плавным исчезновением
            if let index = stories.firstIndex(where: { $0.id == story.id }) {
                stories.remove(at: index)
            }
        }

        // Асинхронное удаление с сервера/данных
        Task {
            await dataHandler?.delete(story: story)
        }
    }

    
    private func addNewStory(title: String, content: String) {
        Task {
            let newStory = DreamStory(title: title, content: content)
            await dataHandler?.new(story: newStory, for: dream)
            
            // Загружает обновлённый список историй
            if let updatedStories = await dataHandler?.stories(for: dream) {
                await MainActor.run {
                    self.stories = updatedStories
                }
            }
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
    
    private func loadStories() {
        Task {
            if let handler = dataHandler {
                let updatedStories = await handler.stories(for: dream)
                await MainActor.run {
                    self.stories = updatedStories
                }
            }
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
