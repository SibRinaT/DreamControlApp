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
                           .font(.largeTitle)
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
                               NavigationLink(value: memory) {
                                   ZStack(alignment: .leading) {
                                       HStack {
                                           Image(memory.dream.image)
                                           VStack(alignment: .leading) {
                                               Text("Мечта")
                                                   .foregroundColor(Color("InactiveColor2"))
                                                   .font(.subheadline)
                                               Text(memory.dream.name)
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
                                   }
                                   .shadow(color: Color.black.opacity(0.15), radius: 10)
                               }
                           }
                       }
                       .listStyle(.plain)
                   }
               }
               .padding(.horizontal)
               .navigationDestination(for: DreamMemory.self) { memory in
                   MemoryDetailView(
                       isPresented: .constant(true),
                       onSave: { _, _ in },
                       memory: memory
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
