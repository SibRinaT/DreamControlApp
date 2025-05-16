//
//  FavoritesIdeasView.swift
//  DreamControlApp
//
//  Created by Ainur on 03.12.2024.
//

import SwiftUI
import DataProvider


struct FavoritesIdeasView: View {
    @Environment(\.dataHandler) private var dataHandler
    @ObservedObject var ideasViewModel: IdeasViewModel
    
    @EnvironmentObject var userManager: UserManager
    @State private var showLimitAlert = false
    @State private var showSubscription = false
    
//    @Query(filter: #Predicate<Idea> {
//        $0.status == IdeaShowStatus.green.rawValue
//    })
//    private var favoriteIdeas: [Idea]
    
    
    var body: some View {
        NavigationStack {
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
                                    .font(.custom("MontserratAlternates-Regular", size: 32))
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
                                            .font(.custom("MontserratAlternates-Regular", size: 14))
                                            .bold()
                                        Text(idea)
                                            .bold()
                                            .font(.custom("MontserratAlternates-Regular", size: 18))
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
                
                NavigationLink(destination: SubscriptionView(), isActive: $showSubscription) {
                    EmptyView()
                }
                .hidden()
            }
            .alert("Лимит мечт исчерпан", isPresented: $showLimitAlert) {
                Button("ОК", role: .cancel) {}
                Button("Оформить подписку") {
                    showSubscription = true
                }
            } message: {
                Text("Чтобы добавить больше мечт, оформите подписку")
            }
        }
    }
    private func deleteIdea(_ idea: String) {
        if let index = ideasViewModel.favoriteIdeas.firstIndex(of: idea) {
            ideasViewModel.favoriteIdeas.remove(at: index)
        }
    }
    
    private func createDreamFromIdea(idea: String) {
        Task {
            let maxAllowed = userManager.isSubscriptionEnabled ? 10 : 3
            let currentCount = (try? await dataHandler?.getActiveDreamsCount()) ?? 0
            
            if currentCount >= maxAllowed {
                showLimitAlert = true
                return
            }

            let newCount = await dataHandler?.new(dream: Dream(name: idea, image: "StarForDream", stories: []))
            deleteIdea(idea)
        }
    }
}

#Preview {
    FavoritesIdeasView(ideasViewModel: IdeasViewModel())
        .environmentObject(IdeasViewModel())
}
