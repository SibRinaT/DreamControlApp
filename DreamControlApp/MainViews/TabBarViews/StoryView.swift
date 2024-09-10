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
                                .font(.title)
                        }
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                    }
                )
            
            List(stories) { story in
                HStack {
                    Image("StoryIcon")
                    Text(story.title)
                        .font(.headline)
                        .padding()
                }
                Button(action: {
    //                showingSheet = true
                }, label: {
                    Rectangle()
                        .foregroundColor(.clear) // Прозрачный фон
                        .frame(height: 85)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(
                                    style: StrokeStyle(
                                        lineWidth: 2,
                                        dash: [15] // Длина штрихов и пробелов в пунктирной линии
                                    )
                                )
                                .foregroundColor(Color("PrimaryColor")) // Цвет обводки
                        )
                        .overlay(
                            Text("Добавить историю")
                                .foregroundColor(Color("PrimaryColor"))
                                .font(.largeTitle)
                                .bold()
                        )
                })
            }
            .listStyle(.plain)
            
            
        
        }
    }
}

#Preview {
    StoryView(dreamName: "Dream", stories: [DreamStory(id: UUID(), title: "long story", content: "content of the long story")])
}
