//
//  File.swift
//  DataProvider
//
//  Created by Artem on 03.12.2024.
//

import Foundation
import SwiftData

public typealias Idea = SchemaV1.Idea


public enum IdeaShowStatus: Int {
    case neutral = 0
    case green = 1
    case red = 2
}

extension SchemaV1 {
    @Model
    public final class Idea: Sendable {
        public let id: UUID = UUID()
        public var name = ""
        public var descriptions = ""
        public var status = 0
        
        public init(id: UUID = UUID(), name: String, descriptions: String, status: IdeaShowStatus) {
            self.id = id
            self.name = name
            self.descriptions = descriptions
            self.status = status.rawValue
        }
    }
}
