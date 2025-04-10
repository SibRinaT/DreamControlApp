//
//  TestGiga.swift
//  DreamControlApp
//
//  Created by Ainur on 10.04.2025.
//

import SwiftUI

struct TestGigaChat: View {
    
    @State private var stories: [MotivationalStory] = []
    
    var body: some View {
        NavigationView {
            List(stories) { story in
                VStack(alignment: .leading) {
                    Text(story.title)
                        .font(.headline)
                    Text(story.content)
                        .font(.body)
                }
            }
            .navigationTitle("Motivational Stories")
            .onAppear {
                // Вызываем функцию для получения историй
                StoryService().fetchMotivationalStories { result in
                    if let stories = result {
                        self.stories = stories
                    }
                }
            }
        }
    }
}

#Preview {
    TestGigaChat()
}
