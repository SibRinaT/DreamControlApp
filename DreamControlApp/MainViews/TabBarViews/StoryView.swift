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
            HStack {
                Image("DCIcon")
                Text("Истории")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color("PrimaryColor"))
                Spacer()
            }
            .padding(.horizontal)

            Rectangle()
//                .shadow(radius: 10)
                .foregroundColor(Color("PrimaryColor"))
                .frame(height: 100)
                .overlay(
                    HStack {
                        Image("CloudForDream")
                        VStack {
                            Text("Мечта")
                                .foregroundColor(Color("InactiveColor2"))
                                .bold()
                                .font(.headline)
                            
                            Text("\(dreamName)")
                                .foregroundColor(.white)
                                .bold()
                                .font(.title2)
                        }
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                    }
                )
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
