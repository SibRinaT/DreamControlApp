//
//  DreamView.swift
//  DreamControlApp
//
//  Created by Ainur on 16.06.2024.
//
import SwiftUI
import DataProvider
import SwiftData

@MainActor
struct DreamView: View {
    @Environment(\.dataHandler) private var dataHandler
    @State private var showingSheet = false
    @State private var newButtonName = ""
    @State private var selectedImage = "StarForDream"
    @State private var selectedDream: Dream? // Добавлено для хранения созданной мечты
    @Binding var user: User // Используем привязку к состоянию пользователя
    @State private var isSubscriptionViewPresented = false
    @Binding var selectedTab: Int

    @Query private var dreams: [Dream]
    
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
                ForEach(dreams) { dream in
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
                        
                        NavigationLink(destination: StoryView(dream: dream,
                                                              stories: dream.stories ?? [])) {
                            EmptyView()
                        }
                        .opacity(0.0)
                    }
                    .listRowBackground(Color.clear)
                }
                .listRowSeparator(.hidden)
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                
                // Кнопка для добавления мечты или кнопка подписки, если мечт слишком много
                if dreams.count < maxDreamsAllowed {
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
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                } else {
                    SubscriptionButton(text: "мечтаний")
                        .onTapGesture {
                            // Открыть экран подписки, если мечт слишком много
                            isSubscriptionViewPresented = true
                        }
                }
            }
            .listStyle(.plain)
        }
        .padding(.horizontal)
        .sheet(isPresented: $showingSheet) {
            NewDreamView(newButtonName: $newButtonName,
                         selectedImage: $selectedImage,
                         showingSheet: $showingSheet) { newDream in
                selectedDream = newDream
            }
        }
        .sheet(isPresented: $isSubscriptionViewPresented) {
            SubscriptionView(user: $user) // Передаем привязку для обновления пользователя
        }
        .background(
            NavigationLink(
                destination: selectedDream.map { StoryView(dream: $0, stories: $0.stories ?? []) },
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
        Task {
            await dataHandler?.delete(dream: dream)
        }
    }
}

//
//#Preview {
//    let handler = DataHandler(modelContainer: DataProvider.shared.sharedModelContainer,
//                              mainActor: true)
//    DreamView()
//        .environment(\.dataHandler, handler)
//        .environment(\.modelContext, handler.modelContainer.mainContext)
//}
