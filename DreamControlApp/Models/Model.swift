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

