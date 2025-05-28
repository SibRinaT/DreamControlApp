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
    @EnvironmentObject var userManager: UserManager
    @Query(filter: #Predicate<DreamMemory> { $0.dream.isArchived }) private var memories: [DreamMemory]
    @AppStorage("showConfirmations") private var showConfirmations: Bool = true
    @Binding var selectedTab: Int
    
    @Query private var allMemories: [DreamMemory]
    @State private var selectedMemory: DreamMemory?
    
    @State private var showCustomDialog = false
    @State private var memoryToDelete: DreamMemory?

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image("DCIcon")
                    Text("Воспоминания")
                        .font(.custom("MontserratAlternates-Regular", size: 30))
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
                        .font(.custom("MontserratAlternates-Regular", size: 14))
                    Spacer()
                } else {
                    List {
                        ForEach(memories) { memory in
                            HStack {
                                Image(memory.dream.image)
                                VStack(alignment: .leading) {
                                    Text("Воспоминание")
                                        .foregroundColor(Color("InactiveColor2"))
                                        .font(.custom("MontserratAlternates-Regular", size: 14))
                                    Text(memory.dream.name)
                                        .font(.custom("MontserratAlternates-Regular", size: 24))
                                        .foregroundColor(.white)
                                    Text("Дата: \(formattedDate(memory.convertedAt))")
                                          .font(.custom("MontserratAlternates-Regular", size: 12))
                                          .foregroundColor(.white.opacity(0.7))
                                }
                                .bold()
                                Spacer()
                            }
                            .padding()
                            .frame(height: 85)
                            .background(Color("PrimaryColor"))
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.15), radius: 10)
                            .contentShape(Rectangle()) // Обязательно, чтобы свайпы работали!
                            .onTapGesture {
                                selectedMemory = memory
                            }
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    requestDeleteConfirmation(memory: memory)
                                } label: {
                                    Label("Удалить", systemImage: "trash")
                                        .font(.custom("MontserratAlternates-Regular", size: 16))
                                }
                            }
                        }
                        .listRowSeparator(.hidden)
                        
                        if memories.count < (userManager.isSubscriptionEnabled ? 10 : 3) {
//                            Button(action: {
//                                // сюда можно вставить нужное действие, например показать форму создания воспоминания
//                            }, label: {
//                                Rectangle()
//                                    .foregroundColor(.clear)
//                                    .frame(height: 85)
//                                    .cornerRadius(20)
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 20)
//                                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [15]))
//                                            .foregroundColor(Color("PrimaryColor"))
//                                    )
//                                    .overlay(
//                                        Text("Добавить воспоминание")
//                                            .foregroundColor(Color("PrimaryColor"))
//                                            .font(.custom("MontserratAlternates-Regular", size: 24))
//                                            .bold()
//                                    )
//                            })
//                            .buttonStyle(.plain)
//                            .listRowSeparator(.hidden)
//                            .listRowBackground(Color.clear)
                        } else if !userManager.isSubscriptionEnabled {
                            SubscriptionButton(text: "воспоминаний")
                        }
                    }
                    
                    .listRowSeparator(.hidden)
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

            if showCustomDialog {
                CustomDialogView(
                    title: "Удалить воспоминание?",
                    message: "Вы уверены, что хотите удалить это воспоминание? Это действие необратимо.",
                    onConfirm: {
                        showCustomDialog = false
                        if let memory = memoryToDelete {
                            performDelete(memory: memory)
                        }
                    },
                    onCancel: {
                        showCustomDialog = false
                    },
                    onDisablePrompt: {
                        showConfirmations = false
                    }
                )
            }
        }
    }
    // для даты добавления воспоминания
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: date)
    }

    // Запрос подтверждения
    private func requestDeleteConfirmation(memory: DreamMemory) {
        if showConfirmations {
            memoryToDelete = memory
            showCustomDialog = true
        } else {
            performDelete(memory: memory)
        }
    }

    // Удаление воспоминания
    private func performDelete(memory: DreamMemory) {
        Task {
            await dataHandler?.delete(dreamMemory: memory)
        }
    }

    // функция если захочется добавить превращение воспоминания в мечту
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
