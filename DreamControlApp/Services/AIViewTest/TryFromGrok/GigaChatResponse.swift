//
//  GigaChatResponse.swift
//  DreamControlApp
//
//  Created by Ainur on 10.04.2025.
//

import Foundation

struct GigaChatResponse: Codable {
    let choices: [Choice]
    
    struct Choice: Codable {
        let message: Message
    }
    
    struct Message: Codable {
        let content: String
    }
}
