//
//  DreamView.swift
//  DreamControlApp
//
//  Created by Ainur on 16.06.2024.
//
import SwiftUI

@MainActor
struct DreamView: View {
    @Environment(StoriesService.self) private var storiesService
    @State private var showingSheet = false
    @State private var newButtonName = ""
    @State private var selectedImage = "StarForDream"
    @State private var selectedDream: Dream? // Добавлено для хранения созданной мечты
    @State private var user = User(id: "123", name: "User", isAdmin: false) // Пример пользователя
    @State private var isSubscriptionViewPresented = false

    private var maxDreamsAllowed: Int {
            user.isSubscriptionEnabled ? 10 : 3 // Максимум 10 мечт для подписчиков и 3 для остальных
        }
    
    var body: some View {
        VStack {
            HStack {
                Image("DCIcon")
                Text("Мечтания")
                    .font(.largeTitle)
                    .foregroundColor(Color("PrimaryColor"))
                    .bold()
                Spacer()
            }
            
            List {
                ForEach(storiesService.dreams) { dream in
                    ZStack(alignment: .leading) {
                        HStack {
                            Image(dream.image)
                            VStack(alignment: .leading) {
                                Text("Мечта")
                                    .foregroundColor(Color("InactiveColor2"))
                                    .font(.subheadline)
                                Text(dream.name)
                                    .font(.title)
                            }
                            .bold()
                            Spacer()
                        }
                        .padding()
                        .frame(height: 85)
                        .background(Color("PrimaryColor"))
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                delete(dream: dream)
                            } label: {
                                Label("Удалить", systemImage: "trash")
                            }
                        }
                        
                        NavigationLink(destination: StoryView(dream: dream)) {
                            EmptyView()
                        }
                        .opacity(0.0)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                if storiesService.dreams.count < maxDreamsAllowed {
                    Button(action: {
                        showingSheet = true
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
                    .buttonStyle(.plain)
                    .listRowBackground(Color.clear)
                } else {
                    SubscriptionButton(text: "мечтаний")
                }
            }
            .listRowSeparator(.hidden)
            .listStyle(.plain)
        }
        .padding(.horizontal)
        .sheet(isPresented: $showingSheet) {
            NewDreamView(newButtonName: $newButtonName, selectedImage: $selectedImage, showingSheet: $showingSheet) { name, image in
                if !name.isEmpty && storiesService.dreams.count < maxDreamsAllowed {
                    let newDream = Dream(id: UUID(), name: name, image: image, stories: [])
                    storiesService.add(dream: newDream)
                    selectedDream = newDream
                }
            }
        }
        .background(
                    NavigationLink(
                        destination: selectedDream.map { StoryView(dream: $0) },
                        isActive: Binding(
                            get: { selectedDream != nil },
                            set: { if !$0 { selectedDream = nil } }
                        ),
                        label: { EmptyView() }
                    )
                    .hidden()
                )
    }
    
    private func delete(dream: Dream) {
        storiesService.delete(dream: dream)
    }
}

struct NewDreamView: View {
    @Binding var newButtonName: String
    @Binding var selectedImage: String
    @Binding var showingSheet: Bool
    @State private var selectedDream: Dream? // Добавлено для хранения созданной мечты
    var onSave: (String, String) -> Void
    
    var body: some View {
        VStack {
            InputFieldView(title: "Название мечты", placeholder: "Введите название", text: $newButtonName)
                .padding()
            HStack {
                if newButtonName.count == 0 || newButtonName.count > 12 {
                    Text("Символов: ")
                    Text("\(newButtonName.count)")
                        .foregroundColor(Color(.red))
                } else {
                    Text("Символов: ")
                    Text("\(newButtonName.count)")
                        .foregroundColor(Color("PrimaryColor"))
                }
            }
            Text("Выберите изображение")
                .font(.headline)
                .padding()
            
            HStack(spacing: 40) {
                VStack {
                    Image("StarForDream")
                    Text("Звезда")
                        .font(.caption2)
                        .foregroundColor(Color("TextColor"))
                        .bold()
                }
                .onTapGesture {
                    selectedImage = "StarForDream"
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(selectedImage == "StarForDream" ? Color("PrimaryColor") : Color.clear, lineWidth: 2)
                )
                
                VStack {
                    Image("CloudForDream")
                    Text("Облако")
                        .font(.caption2)
                        .foregroundColor(Color("TextColor"))
                        .bold()
                }
                .onTapGesture {
                    selectedImage = "CloudForDream"
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(selectedImage == "CloudForDream" ? Color("PrimaryColor") : Color.clear, lineWidth: 2)
                )
                VStack {
                    Image("Cloud2ForDream")
                    Text("2 облака")
                        .font(.caption2)
                        .foregroundColor(Color("TextColor"))
                        .bold()
                }
                .onTapGesture {
                    selectedImage = "Cloud2ForDream"
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(selectedImage == "Cloud2ForDream" ? Color("PrimaryColor") : Color.clear, lineWidth: 2)
                )
            }
            .padding()
            
            if newButtonName.count == 0 || newButtonName.count > 12 {
                Button("Сохранить") {
                    onSave(newButtonName, selectedImage)
                    newButtonName = ""
                    selectedImage = "StarForDream"
                    showingSheet = false
                }
                .disabled(true)
                .padding()
            } else {
                Button("Сохранить") {
                    onSave(newButtonName, selectedImage)
                    newButtonName = ""
                    selectedImage = "StarForDream"
                    showingSheet = false
                }
                .foregroundColor(Color("PrimaryColor"))
                .padding()
            }
            
            Button("Отмена") {
                showingSheet = false
            }
            .foregroundColor(Color("PrimaryColor"))
            .padding()
        }
        .navigationTitle("Новая мечта")
    }
}

#Preview {
    DreamView()
        .environment(StoriesService())
}
