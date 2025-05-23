//
//  DataHandlerTests.swift
//  DataHandlerTests
//
//  Created by Ainur on 23.05.2025.
//

//import XCTest
//import SwiftData
//@testable import DataProvider
//
//final class DataHandlerTests: XCTestCase {
//
//    var container: ModelContainer!
//    var dataHandler: DataHandler!
//
//    override func setUp() async throws {
//        container = try await ModelContainer(
//            for: Dream.self, DreamMemory.self, DreamStory.self,
//            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
//        )
//        dataHandler = DataHandler(modelContainer: container, mainActor: true)
//    }
//
//
//    func testCreateDream() async throws {
//        let dream = Dream(name: "Test Dream", image: "StarForDream")
//        let count = await dataHandler.new(dream: dream)
//
//        XCTAssertEqual(count, 1)
//
//        let allDreams = try await dataHandler.getDreams()
//        XCTAssertEqual(allDreams.count, 1)
//        XCTAssertEqual(allDreams.first?.name, "Test Dream")
//    }
//}
