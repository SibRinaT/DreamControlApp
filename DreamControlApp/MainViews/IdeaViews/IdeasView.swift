//
//  IdeasView.swift
//  DreamControlApp
//
//  Created by Ainur on 20.06.2024.
//

import SwiftUI

struct IdeasView: View {
    @State private var idea: String = "Выучить новый язык"
    private let ideas = [
        "Выучить новый язык",
        "Прочитать книгу по бизнесу",
        "Научиться готовить новое блюдо",
        "Прокачать навыки программирования",
        "Заняться йогой",
        "Изучить основы фотографии"
    ]
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 250)
                .foregroundColor(.white)
                .shadow(radius: 10)
                .overlay(
                    VStack {
                        Text(idea)
                            .bold()
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                )
                .padding(.bottom, 30)
            
            Button(action: generateIdea) {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 100)
                    .foregroundColor(Color("PrimaryColor"))
                    .shadow(radius: 10)
                    .overlay(
                        Text("Генерировать")
                            .bold()
                            .font(.title2)
                            .foregroundColor(.black)
                    )
            }
        }
        .padding(.horizontal)
    }
    
    private func generateIdea() {
        idea = ideas.randomElement() ?? "Идея отсутствует"
    }
}

#Preview {
    IdeasView()
}
