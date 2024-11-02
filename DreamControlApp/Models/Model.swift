//
//  Model.swift
//  DreamControlApp
//
//  Created by Ainur on 04.09.2024.
//

import SwiftUI
import UIKit


struct DreamStory: Codable, Identifiable {
    let id: UUID
    let title: String
    let content: String
}

struct Dream: Codable, Identifiable {
    let id: UUID
    let name: String
    let image: String
    var stories: [DreamStory]
}

struct DailyRectangle: Codable, Identifiable {
    let id: UUID
    let text: String
    let authorText: String
}

struct User: Codable {
    let id: String
    let name: String
    let isAdmin: Bool
    private(set) var isSubscriptionEnabled: Bool
    
    mutating func enableSubscription() {
        isSubscriptionEnabled = true
    }
    
    init(id: String, name: String, isAdmin: Bool) {
        self.id = id
        self.name = name
        self.isAdmin = isAdmin
        self.isSubscriptionEnabled = false
    }
}
