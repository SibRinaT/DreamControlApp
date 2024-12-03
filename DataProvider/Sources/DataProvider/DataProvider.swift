//
//  DataProvider.swift
//
//  Created by Yang Xu on 2024/3/16.
//

import Foundation
import SwiftData
import SwiftUI

public final class DataProvider: Sendable {
    public static let shared = DataProvider()
    
    deinit {
        print(">> DataProvider deinit >>")
    }
    
    public let sharedModelContainer: ModelContainer = {
        let schema = Schema(CurrentScheme.models)
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
//    public let previewContainer: ModelContainer = {
//        let schema = Schema(SchemaV1.models)
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
    
    public init() {}
}

public struct DataHandlerKey: EnvironmentKey {
    public static let defaultValue: DataHandler? = nil
}

extension EnvironmentValues {
    @MainActor public var dataHandler: DataHandler? {
        get { self[DataHandlerKey.self] }
        set { self[DataHandlerKey.self] = newValue }
    }
}
