//
//  File.swift
//  DataProvider
//
//  Created by Artem on 20.11.2024.
//

import Foundation
import SwiftData

public typealias DreamStory = SchemaV1.DreamStory

extension SchemaV1 {
    @Model
    public final class DreamStory: Sendable {
        public let id: UUID = UUID()
        public var title = ""
        public var content = ""
        
        public init(id: UUID = UUID(), title: String, content: String) {
            self.id = id
            self.title = title
            self.content = content
        }
    }
}
