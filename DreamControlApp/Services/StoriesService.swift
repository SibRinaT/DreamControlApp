//
//  StoriesService.swift
//  DreamControlApp
//
//  Created by Artem on 11.09.2024.
//

import Foundation

@MainActor
@Observable final class StoriesService {
    private let defaults = UserDefaults.standard
    private enum Keys {
        static let dreams = "dreams"
    }
    var dreams = [Dream]()
    
    init() {
        dreams = loadDreams()
    }
        
    func add(dream: Dream) {
        print("add dream:", dream)
        var allDreams = loadDreams()
        allDreams.append(dream)
        saveDreams(allDreams)
        dreams = allDreams
    }
    
    func delete(dream: Dream) {
        print("delete dream:", dream)
        var allDreams = loadDreams()
        allDreams.removeAll(where: { $0.id == dream.id })
        saveDreams(allDreams)
        dreams = allDreams
    }
    
    func deleteStory(from dream: Dream, story: DreamStory) {
            print("delete story:", story, "from dream:", dream)
            var allDreams = loadDreams()
            
            // Ищем нужную мечту и удаляем историю
            if let dreamIndex = allDreams.firstIndex(where: { $0.id == dream.id }) {
                allDreams[dreamIndex].stories.removeAll(where: { $0.id == story.id })
            }
            
            saveDreams(allDreams)
            dreams = allDreams
        }
    
    func update(dream: Dream) {
        print("update dream:", dream)
        var allDreams = loadDreams()
        allDreams.removeAll(where: { $0.id == dream.id })
        allDreams.append(dream)
        saveDreams(allDreams)
        dreams = allDreams
    }
    
    private func saveDreams(_ dreams: [Dream]) {
        print("save \(dreams.count) dreams")
        do {
            let encodedDreams = try JSONEncoder().encode(dreams)
            defaults.set(encodedDreams, forKey: Keys.dreams)
        } catch {
            print(error)
        }
    }
    
    private func loadDreams() -> [Dream] {
        guard let data = defaults.data(forKey: Keys.dreams) else {
            return []
        }
        do {
            return try JSONDecoder().decode([Dream].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}

