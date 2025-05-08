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
                    .font(.largeTitle)
                    .foregroundColor(Color("PrimaryColor"))
                    .bold()
                Spacer()
            }
            .padding()

            if archivedDreams.isEmpty {
                Spacer()
                Text("Здесь пока нет воспоминаний")
                    .foregroundColor(.gray)
                    .font(.title3)
                Spacer()
            } else {
                List {
                    ForEach(archivedDreams) { dream in
                        HStack {
                            Image(systemName: "clock.arrow.circlepath")
                                .foregroundColor(.blue)
                            Text(dream.name)
                                .font(.title3)
                            Spacer()
                        }
                        .padding()
                        .background(Color("PrimaryColor").opacity(0.1))
                        .cornerRadius(10)
                        .swipeActions(edge: .leading) {
                            Button {
                                unarchive(dream: dream)
                            } label: {
                                Label("Восстановить", systemImage: "arrow.uturn.left")
                            }
                            .tint(.green)
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .padding(.horizontal)
    }

    private func unarchive(dream: Dream) {
        Task {
            await dataHandler?.unarchive(dream: dream)
        }
    }
}

//#Preview {
//    MemoriesView()
//}
