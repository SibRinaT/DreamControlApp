//
//  DreamMemory.swift
//  DataProvider
//
//  Created by Ainur on 09.05.2025.
//

import Foundation
import SwiftData

public typealias DreamMemory = SchemaV1.Dream

extension SchemaV1 {
    @Model
    public final class DreamMemory: Sendable {
        public let id: UUID
        public let createdAt: Date
        public var text: String
        public var photoNames: [String]?
        public var dream: Dream
        
        public init(
            id: UUID = UUID(),
            createdAt: Date = .now,
            text: String,
            photoNames: [String]? = nil,
            dream: Dream
        ) {
            self.id = id
            self.createdAt = createdAt
            self.text = text
            self.photoNames = photoNames
            self.dream = dream
        }
    }
}
