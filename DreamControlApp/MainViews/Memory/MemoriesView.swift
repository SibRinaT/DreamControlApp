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
    @Query(filter: #Predicate<DreamMemory> { $0.dream.isArchived }) private var memories: [DreamMemory]
    @Binding var selectedTab: Int
    
    @Query private var allMemories: [DreamMemory]
    @State private var selectedMemory: DreamMemory?

    var body: some View {
        NavigationStack {
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

                let memories = allMemories.filter { $0.dream.isArchived }

                if memories.isEmpty {
                    Spacer()
                    Text("Вы пока не добавили воспоминания")
                        .foregroundColor(.gray)
                        .font(.title3)
                    Spacer()
                } else {
                    List {
                        ForEach(memories) { memory in
                            Button {
                                selectedMemory = memory
                            } label: {
                                HStack {
                                    Image(memory.dream.image)
                                    VStack(alignment: .leading) {
                                        Text("Мечта")
                                            .foregroundColor(Color("InactiveColor2"))
                                            .font(.custom("MontserratAlternates-Regular", size: 14))
                                        Text(memory.dream.name)
                                            .font(.custom("MontserratAlternates-Regular", size: 24))
                                            .foregroundColor(.white)
                                    }
                                    .bold()
                                    Spacer()
                                }
                                .padding()
                                .frame(height: 85)
                                .background(Color("PrimaryColor"))
                                .cornerRadius(20)
                                .shadow(color: Color.black.opacity(0.15), radius: 10)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .padding(.horizontal)
            .sheet(item: $selectedMemory) { memory in
                MemoryDetailView(
                    onSave: { _, _ in },
                    memory: memory,
                    dismiss: {
                           selectedMemory = nil
                       }
                )
            }
        }
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
            MemoriesView(selectedTab: .constant(0))
                .modelContainer(for: Dream.self, inMemory: true)
                .environment(\.dataHandler, DataHandler(modelContainer: try! ModelContainer(for: Dream.self)))
        }
    }

    return PreviewWrapper()
}
