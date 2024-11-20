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
        return dream.persistentModelID
    }
        
    public func getDreams() throws -> [Dream] {
        var desc = FetchDescriptor<Dream>()
        return try modelContext.fetch(desc)
    }

    public func getDreamsCount() throws -> Int {
        var desc = FetchDescriptor<Dream>()
        return try modelContext.fetchCount(desc)
    }
}
