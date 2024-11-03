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
    @State private var dragOffset: CGSize = .zero

    var body: some View {
        VStack {
            Text("")
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                .ignoresSafeArea(.all)
                .overlay(
                    VStack {
                        RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(.white)
                                        .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                                        .frame(height: 300)
                                        .padding(.horizontal)
                                        .offset(x: dragOffset.width)
                                        .gesture(
                                            DragGesture()
                                                .onChanged { value in
                                                    dragOffset = value.translation
                                                }
                                                .onEnded { value in
                                                    if value.translation.width > 100 {
                                                        viewModel.saveIdea(idea, isRightSwipe: true)
                                                    } else if value.translation.width < -100 {
                                                        viewModel.saveIdea(idea, isRightSwipe: false)
                                                    }
                                                    dragOffset = .zero
                                                    generateIdea()
                                                }
                                        )
                                        .overlay(
                                            Text(idea)
                                                .offset(x: dragOffset.width)
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
