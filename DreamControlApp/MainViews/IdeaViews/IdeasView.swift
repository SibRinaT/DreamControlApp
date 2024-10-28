//
//  IdeasView.swift
//  DreamControlApp
//
//  Created by Ainur on 20.06.2024.
//

import SwiftUI

struct IdeasView: View {
    @State private var idea: String = "Выучить новый язык"
    @ObservedObject private var viewModel = IdeasViewModel()
    
    var body: some View {
        VStack {
            Text("")
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .shadow(radius: 10)
                .ignoresSafeArea(.all)
            
                .overlay(
                    VStack {
                        Spacer()
                        Text(idea)
                            .bold()
                            .font(.title3)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                        Spacer()
                        
                        VStack {
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
                )
        }
        .padding(.horizontal)
    }
    
    private func generateIdea() {
        idea = viewModel.getRandomIdea()
    }
}

#Preview {
    IdeasView()
}
