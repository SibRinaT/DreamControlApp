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
    @State private var selectedDream: Dream?
    
    @State private var isSubscriptionViewPresented = false
    @Binding var selectedTab: Int
    
    @Query(filter: #Predicate<Dream> { !$0.isArchived }) private var dreams: [Dream]
    @EnvironmentObject var userManager: UserManager
    
    @State private var showCustomDialog = false
    @AppStorage("showDeleteConfirmations") private var showDeleteConfirmations: Bool = true
    @State private var showArchiveConfirmation = true
    
    @State private var confirmationType: ConfirmationType? = nil
    @State private var dreamToDelete: Dream? = nil
    @State private var dreamToArchive: Dream? = nil
    
    enum ConfirmationType {
        case delete
        case archive
    }
    private var maxDreamsAllowed: Int {
        userManager.isSubscriptionEnabled ? 10 : 3
    }
    
    
    
    var body: some View {
        VStack {
            HStack {
                Image("DCIcon")
                Text("Мечтания")
                    .font(.custom("MontserratAlternates-Regular", size: 32))
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
                                    .font(.custom("MontserratAlternates-Regular", size: 14))
                                Text(dream.name)
                                    .font(.custom("MontserratAlternates-Regular", size: 22))
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
                                requestDeleteConfirmation(for: dream)
                            } label: {
                                Label("Удалить", systemImage: "trash")
                                    .font(.custom("MontserratAlternates-Regular", size: 14))
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                requestArchiveConfirmation(for: dream)
                            } label: {
                                Label("В воспоминанния", systemImage: "archivebox")
                                    .font(.custom("MontserratAlternates-Regular", size: 14))
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
                if dreams.count < maxDreamsAllowed {
                    Button(action: {
                        showingSheet = true
                    }, label: {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(height: 85)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [15]))
                                    .foregroundColor(Color("PrimaryColor"))
                            )
                            .overlay(
                                Text("Добавить мечту")
                                    .foregroundColor(Color("PrimaryColor"))
                                    .font(.custom("MontserratAlternates-Regular", size: 24))
                                    .bold()
                            )
                    })
                    .buttonStyle(.plain)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                } else if !userManager.isSubscriptionEnabled {
                    // Только если НЕТ подписки, показываем SubscriptionButton
                    SubscriptionButton(text: "мечтаний")
                }
            }
            .listStyle(.plain)
        }
        //        .toolbar {
        //            ToolbarItem(placement: .navigationBarLeading) {
        //                CustomBackButton()
        //            }
        //        }
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
        .padding(.horizontal)
        .sheet(isPresented: $showingSheet) {
            NewDreamView(newButtonName: $newButtonName,
                         selectedImage: $selectedImage,
                         showingSheet: $showingSheet) { newDream in
                selectedDream = newDream
            }
        }
        if showCustomDialog {
            CustomDialogView(
                title: "Вы уверены, что хотите продолжить?",
                message: "Все связанные с мечтой истории будут удалены.",
                confirmationType: confirmationType,
                onConfirm: {
                    showCustomDialog = false
                    switch confirmationType {
                    case .delete:
                        if let dream = dreamToDelete {
                            delete(dream: dream)
                        }
                    case .archive:
                        if let dream = dreamToArchive {
                            archive(dream: dream)
                        }
                    case .none:
                        break
                    }
                },
                onCancel: {
                    showCustomDialog = false
                },
                onDisablePrompt: {
                    if confirmationType == .delete {
                        showDeleteConfirmations = false
                    } else {
                        showArchiveConfirmation = false
                    }
                }
            )
        }
    }
    
    
    private func delete(dream: Dream) {
        Task {
            await dataHandler?.delete(dream: dream)
        }
    }
    
    private func archive(dream: Dream) {
        Task {
            // Архивируем мечту
            dream.isArchived = true

            // Создаём воспоминание на основе мечты
            let memory = DreamMemory(
                text: "",
                photoNames: [],
                dream: dream,
                convertedAt: Date()
            )
            
            // Сохраняем изменения
            await dataHandler?.archiveAsMemory(dream: dream)
        }
    }
    
    private func requestDeleteConfirmation(for dream: Dream) {
        if showDeleteConfirmations {
            dreamToDelete = dream
            confirmationType = .delete
            showCustomDialog = true
        } else {
            delete(dream: dream)
        }
    }

    private func requestArchiveConfirmation(for dream: Dream) {
        if showArchiveConfirmation {
            dreamToArchive = dream
            confirmationType = .archive
            showCustomDialog = true
        } else {
            archive(dream: dream)
        }
    }
}

//#Preview {
//    let handler = DataHandler(modelContainer: DataProvider.shared.sharedModelContainer,
//                              mainActor: true)
//    DreamView(selectedTab: .constant(0))
//        .environment(\.dataHandler, handler)
//        .environment(\.modelContext, handler.modelContainer.mainContext)
//}
