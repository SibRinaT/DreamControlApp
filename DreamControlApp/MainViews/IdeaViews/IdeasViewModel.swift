//
//  IdeasData.swift
//  DreamControlApp
//
//  Created by Ainur on 26.10.2024.
//

import SwiftUI

class IdeasViewModel: ObservableObject {
    @Published var ideas = [
        "Выучить новый язык",
        "Прочитать книгу по бизнесу",
        "Научиться готовить новое блюдо",
        "Прокачать навыки программирования",
        "Заняться йогой",
        "Изучить основы фотографии"
    ]
    
    func getRandomIdea() -> String {
        return ideas.randomElement() ?? "Идея отсутствует"
    }
}
