//
//  Memories.swift
//  DreamControlApp
//
//  Created by Ainur on 08.05.2025.
//

import SwiftUI
import SwiftData
import DataProvider

struct MemoriesView: View {
    @Environment(\.dataHandler) private var dataHandler
    @Query(filter: #Predicate<Dream> { $0.isArchived }) private var archivedDreams: [Dream]
    @Binding var selectedTab: Int

    var body: some View {
        VStack {
            HStack {
                Image("DCIcon")
                Text("Воспоминания")
                    .font(.custom("MontserratAlternates-Regular", size: 32))
                    .foregroundColor(Color("PrimaryColor"))
                    .bold()
                Spacer()
            }
            .padding()

            if archivedDreams.isEmpty {
                Spacer()
                Text("Вы пока не добавили воспоминания")
                    .foregroundColor(.gray)
                    .font(.custom("MontserratAlternates-Regular", size: 16))
                Spacer()
            } else {
                List {
                    ForEach(archivedDreams) { dream in
                        ZStack(alignment: .leading) {
                            HStack {
                                Image(dream.image)
                                VStack(alignment: .leading) {
                                    Text("Мечта")
                                        .foregroundColor(Color("InactiveColor2"))
                                        .font(.custom("MontserratAlternates-Regular", size: 14))
                                    Text(dream.name)
                                        .font(.custom("MontserratAlternates-Regular", size: 24))
                                }
                                .bold()
                                Spacer()
                            }
                            .padding()
                            .frame(height: 85)
                            .background(Color("PrimaryColor"))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .swipeActions(edge: .leading) {
                                Button {
                                    unarchive(dream: dream)
                                } label: {
                                    Label("Восстановить", systemImage: "arrow.uturn.left")
                                        .font(.custom("MontserratAlternates-Regular", size: 14))
                                }
                                .tint(.green)
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                    }
                }
                .listStyle(.plain)
            }
        }
        .padding(.horizontal)
    }

    // функция если захочется добавить прерващение воспоминания в мечту 
    private func unarchive(dream: Dream) {
        Task {
            await dataHandler?.unarchive(dream: dream)
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var selectedTab = 0

        var body: some View {
            MemoriesView(selectedTab: $selectedTab)
                .modelContainer(for: Dream.self, inMemory: true)
                .environment(\.dataHandler, DataHandler(modelContainer: try! ModelContainer(for: Dream.self)))
        }
    }

    return PreviewWrapper()
}
