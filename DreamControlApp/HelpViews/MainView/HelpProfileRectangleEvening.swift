//
//  HelpProfileRectangleEvening.swift
//  DreamControlApp
//
//  Created by Ainur on 01.10.2024.
//

import SwiftUI

struct HelpProfileRectangleEvening: View {
    @Binding var isAnimating: Bool // возможность контролировать анимацию извне
    @State private var rotateAmount: CGFloat = 5 // угол поворота

    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color("SecondaryColor"))
                .frame(height: 200)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                .overlay (
                    ZStack {
                        cloudImage("CloudSmallImage", offset: CGSize(width: -150, height: -25))
                        cloudImage("CloudImage", offset: CGSize(width: -140, height: 20))
                        cloudImage("CloudImage", offset: CGSize(width: -50, height: 5))
                        cloudImage("CloudImage", offset: CGSize(width: -150, height: 115))
                        cloudImage("CloudImage", offset: CGSize(width: -50, height: 110))
                        starImage("StarSmallImage", offset: CGSize(width: -40, height: 80))
                        starImage("StarSmallImage", offset: CGSize(width: -165, height: 60))
                        starImage("StarSmallImage", offset: CGSize(width: -120, height: -10))
                        starImage("StarSmallImage", offset: CGSize(width: -40, height: -30))
                        starImage("StarImage", offset: CGSize(width: 140, height: -20))
                        cloudImage("EveningCloud", offset: CGSize(width: -100, height: 50))
                    }
                )
        }
        .padding(.horizontal)
        .onAppear {
            animateWobble()
        }
    }

    // Создаем общие функции для облаков и звезд с анимацией
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

//#Preview {
//    HelpProfileRectangleEvening()
//}
