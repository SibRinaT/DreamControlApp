//
//  ModelStory.swift
//  DreamControlApp
//
//  Created by Ainur on 10.04.2025.
//

import Foundation

struct MotivationalStory: Identifiable, Codable {
    let id = UUID() // Уникальный идентификатор
    let title: String
    let content: String
}
