//
//  IdeasView.swift
//  DreamControlApp
//
//  Created by Ainur on 20.06.2024.
//

import SwiftUI
import DataProvider
import SwiftData

struct IdeasView: View {
    @State private var idea: String = "Выучить новый язык"
    @EnvironmentObject var ideasViewModel: IdeasViewModel  // Инициализируем и используем @StateObject
    @State private var dragOffset: CGSize = .zero
    @State private var rectangleColor: Color = .white
    @State private var showFavorites = false
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image("DCIcon")
                    Text("Идеи")
                        .font(.largeTitle)
                        .foregroundColor(Color("PrimaryColor"))
                        .bold()
                    Spacer()
                }
            }
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(rectangleColor)
                    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                    .frame(height: 300)
                    .padding(.horizontal)
                    .offset(x: dragOffset.width, y: dragOffset.height * 0.1) // небольшое смещение по y
                    .rotationEffect(.degrees(Double(dragOffset.width) / 15))
                    .animation(.easeInOut(duration: 0.6), value: rectangleColor) // Плавный переход цвета
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                dragOffset = value.translation
                                if dragOffset.width > 0 {
                                    rectangleColor = Color("SuccessColor")
                                } else if dragOffset.width < 0 {
                                    rectangleColor = Color(.red)
                                }
                            }
                            .onEnded { value in
                                if value.translation.width > 100 {
                                    ideasViewModel.saveIdea(idea, isRightSwipe: true)
                                } else if value.translation.width < -100 {
                                    ideasViewModel.saveIdea(idea, isRightSwipe: false)
                                }
                                dragOffset = .zero
                                generateIdea()
                                rectangleColor = .white
                            }
                    )
                    .overlay(
                        Text(idea)
                            .offset(x: dragOffset.width, y: dragOffset.height * 0.1) // небольшое смещение по y
                            .rotationEffect(.degrees(Double(dragOffset.width) / 15))
                            .bold()
                            .font(.title3)
                            .padding(.horizontal, 30)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                    )
                Spacer()
                
                VStack {
                    Button(action: {
                        showFavorites = true
                    }) {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 100)
                            .foregroundColor(Color("PrimaryColor"))
                            .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                            .overlay(
                                HStack {
                                    Text("Избранное")
                                        .bold()
                                        .font(.title2)
                                        .foregroundColor(.white)
                                }
                            )
                    }
                }
                .padding(.horizontal)
                .sheet(isPresented: $showFavorites) {
                    FavoritesView(ideasViewModel: ideasViewModel) // Открытие избранных идей
                }
            }
        }
        .padding(.horizontal)
        .onAppear {
            generateIdea() // При загрузке представления получаем случайную идею
        }
    }
    private func generateIdea() {
        idea = ideasViewModel.getRandomIdea()
    }
}

struct FavoritesView: View {
    @Environment(\.dataHandler) private var dataHandler
    @ObservedObject var ideasViewModel: IdeasViewModel
    
//    @Query(filter: #Predicate<Idea> {
//        $0.status == IdeaShowStatus.green.rawValue
//    })
//    private var favoriteIdeas: [Idea]
    
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color("PrimaryColor"))
                .frame(height: 100)
                .overlay(
                    HStack {
                        Image("CloudForDream")
                        VStack {
                            Text("Избранные идеи") // change need
                                .foregroundColor(.white)
                                .bold()
                                .font(.title)
                        }
                        .multilineTextAlignment(.leading)
                    }
                )
            
            List {
                ForEach(ideasViewModel.favoriteIdeas, id: \.self) { idea in
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 100)
                        .foregroundColor(Color("PrimaryColor"))
                        .overlay(
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Идея")
                                        .foregroundColor(Color("InactiveColor2"))
                                        .font(.subheadline)
                                        .bold()
                                    Text(idea)
                                        .bold()
                                        .font(.title3)
                                        .multilineTextAlignment(.leading)
                                        .foregroundColor(.white)
                                }
                                .padding(.leading)
                                Spacer()
                            }
                        )
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                deleteIdea(idea)
                            } label: {
                                Label("Удалить", systemImage: "trash")
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                createDreamFromIdea(idea: idea)
                            } label: {
                                Label("Создать мечту", systemImage: "plus")
                            }
                        }
                        .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
        }
    }
    private func deleteIdea(_ idea: String) {
        if let index = ideasViewModel.favoriteIdeas.firstIndex(of: idea) {
            ideasViewModel.favoriteIdeas.remove(at: index)
        }
    }
    
    private func createDreamFromIdea(idea: String) {
        Task {
            let dream = Dream(name: idea, image: "StarForDream", stories: [])
            await dataHandler?.new(dream: dream)
            deleteIdea(idea)
        }
    }
}

#Preview {
    IdeasView()
        .environmentObject(IdeasViewModel()) // Передаем viewModel для предварительного просмотра
}
