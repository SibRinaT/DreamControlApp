import Foundation
import SwiftData

@ModelActor
public actor DataHandler {
    
    deinit {
        print(">> DataHandler deinit >>")
    }
    
    @MainActor
    public init(modelContainer: ModelContainer, mainActor _: Bool) {
        let modelContext = modelContainer.mainContext
        modelExecutor = DefaultSerialModelExecutor(modelContext: modelContext)
        self.modelContainer = modelContainer
    }
    
    @discardableResult
    public func new(dream: Dream) -> PersistentIdentifier {
        modelContext.insert(dream)
        try! modelContext.save()
        return dream.persistentModelID
    }
    
    public func delete(dream: Dream) {
        modelContext.delete(dream)
        try! modelContext.save()
    }
    public func delete(dreamMemory: DreamMemory) {
        modelContext.delete(dreamMemory)
        try! modelContext.save()
    }
    public func archive(dream: Dream) {
        dream.isArchived = true
        try? modelContext.save()
    }
    
    @discardableResult
    public func archiveAsMemory(dream: Dream) -> PersistentIdentifier {
        // Архивируем мечту
        dream.isArchived = true

        // Создаем воспоминание
        let memory = DreamMemory(
            text: "",
            photoNames: [],
            dream: dream,
            convertedAt: Date()
        )

        modelContext.insert(memory)
        try? modelContext.save()

        return memory.persistentModelID
    }
    
    public func save() {
        try? modelContext.save()
    }

    
    public func unarchive(dream: Dream) {
        dream.isArchived = false
        try? modelContext.save()
    }
        
    public func getDreams() throws -> [Dream] {
        var desc = FetchDescriptor<Dream>()
        return try modelContext.fetch(desc)
    }

    public func getDreamsCount() throws -> Int {
        var desc = FetchDescriptor<Dream>()
        return try modelContext.fetchCount(desc)
    }
    
    @discardableResult
    public func new(story: DreamStory, for dream: Dream) -> PersistentIdentifier {
        dream.stories?.append(story)
        try? modelContext.save()
        return story.persistentModelID
    }
    
    public func delete(story: DreamStory) {
        modelContext.delete(story)
        try? modelContext.save()
    }
    
    public func stories(for dream: Dream) -> [DreamStory] {
        return dream.stories ?? []
    }
    
//    @discardableResult
//    public func new(idea: Idea) -> PersistentIdentifier {
//        modelContext.insert(idea)
//        return idea.persistentModelID
//    }
}
