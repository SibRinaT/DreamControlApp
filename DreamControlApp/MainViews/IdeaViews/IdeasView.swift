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
    @State private var rectangleColor: Color = .white

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
                            .foregroundColor(rectangleColor)
                            .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                            .frame(height: 300)
                            .padding(.horizontal)
                            .offset(x: dragOffset.width, y: dragOffset.height * 0.1) // небольшое смещение по y
                            .rotationEffect(.degrees(Double(dragOffset.width) / 15))
                            .animation(.easeInOut(duration: 0.6), value: rectangleColor) // Плавный переход цвета
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        dragOffset = value.translation
                                        if dragOffset.width > 0 {
                                            rectangleColor = .green
                                        } else if dragOffset.width < 0 {
                                            rectangleColor = .red
                                        }
                                    }
                                
                                    .onEnded { value in
                                        if value.translation.width > 100 {
                                            viewModel.saveIdea(idea, isRightSwipe: true)
                                        } else if value.translation.width < -100 {
                                            viewModel.saveIdea(idea, isRightSwipe: false)
                                        }
                                        dragOffset = .zero
                                        generateIdea()
                                        rectangleColor = .white
                                        
                                    }
                            )
                            .overlay(
                                Text(idea)
                                    .offset(x: dragOffset.width, y: dragOffset.height * 0.1) // небольшое смещение по y
                                    .rotationEffect(.degrees(Double(dragOffset.width) / 15))
                                    .bold()
                                    .font(.title3)
                                    .padding(.horizontal, 30)
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
