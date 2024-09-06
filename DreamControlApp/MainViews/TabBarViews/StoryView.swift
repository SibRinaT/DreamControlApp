//
//  StoryView.swift
//  DreamControlApp
//
//  Created by Ainur on 04.09.2024.
//

import SwiftUI
struct StoryView: View {
    let dreamName: String
    @State var stories = [DreamStory]()
    
    var body: some View {
        VStack {
            Text("Истории мечты \(dreamName)")
                .font(.largeTitle)
                .bold()
                .padding()
            
            List(stories) { story in
                Text(story.title)
                    .font(.headline)
                    .padding()
            }
        }
        .navigationTitle("Истории")
    }
}

#Preview {
    StoryView(dreamName: "Dream", stories: [DreamStory(id: UUID(), title: "long story", content: "content of the long story")])
}
