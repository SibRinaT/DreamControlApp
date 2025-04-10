//
//  StoryService.swift
//  DreamControlApp
//
//  Created by Ainur on 10.04.2025.
//

import Foundation

class StoryService {
    
    func fetchMotivationalStories(completion: @escaping ([MotivationalStory]?) -> Void) {
        guard let url = URL(string: "https://your-api-endpoint.com/stories") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching stories: $error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let stories = try decoder.decode([MotivationalStory].self, from: data)
                completion(stories)
            } catch {
                print("Error decoding stories: $error)")
                completion(nil)
            }
        }.resume()
    }
}
