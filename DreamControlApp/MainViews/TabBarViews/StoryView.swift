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
    
    @State private var storyToEdit: DreamStory?

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
            
            List {
                ForEach(dream.stories) { story in
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
            .listStyle(.plain)
        }
    }
    
    @MainActor private func delete(story: DreamStory) {
        if let index = dream.stories.firstIndex(where: { $0.id == story.id }) {
            dream.stories.remove(at: index)
            storiesService.deleteStory(from: dream, story: story) // Удаляем историю из сервиса
        }
    }
    
    @MainActor private func addNewStory(title: String, content: String) {
        let newStory = DreamStory(id: UUID(), title: title, content: content)
        dream.stories.append(newStory)
        storiesService.update(dream: dream)
    }
    
    @MainActor private func updateStory(newTitle: String, newContent: String) {
        guard let storyToEdit else { return }
        
        if let index = dream.stories.firstIndex(where: { $0.id == storyToEdit.id}) {
            let id = dream.stories[index].id
            dream.stories.remove(at: index)
            let newStory = DreamStory(id: id, title: newTitle, content: newContent)
            dream.stories.insert(newStory, at: index)
            storiesService.update(dream: dream)
        }
    }
}

#Preview {
    NavigationStack {
        StoryView(dream: Dream(id: UUID(), name: "test", image: "", stories: [DreamStory(id: UUID(), title: "Mystory", content: "super long story")]))
            .environment(StoriesService())
    }

}
