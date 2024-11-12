//
//  TestPageView.swift
//  DreamControlApp
//
//  Created by Ainur on 01.04.2024.
//

import SwiftUI

struct CombinedView: View {
    @State var text: String
    @State var author: String
    @Binding var isAnimating: Bool
    @State private var rotateAmount: CGFloat = 5

    var body: some View {
        VStack {
            HelpProfileRectangleDay(isAnimating: $isAnimating)
                .overlay(
                    VStack {
                        Spacer()
                        Text("Привет Айнур")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .offset(CGSize(width: 70, height: 10))
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .frame(width: 200, height: 70)
                            .offset(CGSize(width: 70, height: 10))
                            .overlay(
                                Text(text)
                                    .gradientForeground(colors: [Color("Prem1"),Color("Prem2"),Color("Prem3")])
                                    .multilineTextAlignment(.center)
                                    .offset(CGSize(width: 70, height: 10))
                            )
                        HStack {
                            Spacer()
                            Text(author)
                                .font(.title2)
                                .foregroundColor(.white)
                                .bold()
                                .offset(CGSize(width: -25, height: 10))
                        }
                    }
                )
        }
        .padding(.horizontal)
        .onAppear {
            animateWobble()
        }
    }
    
    // Функция для облаков с анимацией
    private func cloudImage(_ name: String, offset: CGSize) -> some View {
        Image(name)
            .offset(offset)
            .rotationEffect(.degrees(isAnimating ? rotateAmount : 0))
            .animation(
                isAnimating
                    ? Animation.easeInOut(duration: 5).repeatForever(autoreverses: true)
                    : .default,
                value: isAnimating
            )
    }
    
    // Функция для звезд с анимацией
    private func starImage(_ name: String, offset: CGSize) -> some View {
        Image(name)
            .offset(offset)
            .rotationEffect(.degrees(isAnimating ? -rotateAmount : 0))
            .animation(
                isAnimating
                    ? Animation.easeInOut(duration: 5).repeatForever(autoreverses: true)
                    : .default,
                value: isAnimating
            )
    }

    // Функция для запуска анимации
    private func animateWobble() {
        isAnimating = true
    }
}

#Preview {
    CombinedView(text: "”Все имеет свою красоту, но не каждый ее видит”", author: "asdda", isAnimating: .constant(true))
}
