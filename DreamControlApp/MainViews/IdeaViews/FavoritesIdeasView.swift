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
    FavoritesIdeasView(ideasViewModel: IdeasViewModel())
        .environmentObject(IdeasViewModel())
}
