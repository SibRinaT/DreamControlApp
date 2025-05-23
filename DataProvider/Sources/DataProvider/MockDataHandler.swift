//
//  MockDataHandler.swift
//  DataProvider
//
//  Created by Ainur on 06.05.2025.
//


//import Foundation
//import DataProvider
//import SwiftData
//
//final class MockDataHandler: DataHandlerProtocol {
//    var deleteCalled = false
//    var deletedDream: Dream?
//    
//    var archiveCalled = false
//    var archivedDream: Dream?
//    
//    var archiveAsMemoryCalled = false
//    
//    func delete(dream: Dream) {
//        deleteCalled = true
//        deletedDream = dream
//    }
//
//    func archive(dream: Dream) {
//        archiveCalled = true
//        archivedDream = dream
//    }
//
//    func archiveAsMemory(dream: Dream) -> PersistentIdentifier {
//        archiveAsMemoryCalled = true
//        return dream.persistentModelID
//    }
//}
