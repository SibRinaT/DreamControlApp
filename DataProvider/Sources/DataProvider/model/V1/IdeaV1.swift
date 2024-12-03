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
        public var title = ""
        public var status = 0
        
        public init(id: UUID = UUID(), title: String, status: IdeaShowStatus) {
            self.id = id
            self.title = title
            self.status = status.rawValue
        }
    }
}
