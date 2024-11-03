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
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                .ignoresSafeArea(.all)
            
                .overlay(
                    VStack {
                        Spacer()
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.white)
                            .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                            .frame(height: 300)
                            .padding(.horizontal)
                            .overlay(
                                Text(idea)
                                    .bold()
                                    .font(.title3)
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                            )
                        Spacer()
                        
                        VStack {
                            Button(action: generateIdea) {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(height: 100)
                                    .foregroundColor(Color("PrimaryColor"))
                                    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
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
