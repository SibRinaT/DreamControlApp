//
//  Model.swift
//  DreamControlApp
//
//  Created by Ainur on 04.09.2024.
//

import SwiftUI
import UIKit


struct DreamStory: Identifiable {
    let id = UUID()
    let title: String
    let content: String
}

struct Dream: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    var stories: [DreamStory]
}

