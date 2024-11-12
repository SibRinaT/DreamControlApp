//
//  HelpProfileRectangleMorning.swift
//  DreamControlApp
//
//  Created by Ainur on 01.10.2024.
//

import SwiftUI

struct HelpProfileRectangleMorning: View {
    @Binding var isAnimating: Bool // состояние анимации
    @State private var rotateAmount: CGFloat = 5 // угол поворота

    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color("SuccessColor"))
                .frame(height: 200)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                .overlay(
                    ZStack {
                        starImage("StarSmallImage", offset: CGSize(width: -40, height: 30))
                        cloudImage("CloudImage", offset: CGSize(width: -140, height: -30))
                        cloudImage("CloudImage", offset: CGSize(width: -10, height: -80))
                        cloudImage("CloudImage", offset: CGSize(width: -150, height: 65))
                        starImage("StarSmallImage", offset: CGSize(width: -150, height: -75))
                        starImage("StarSmallImage", offset: CGSize(width: -165, height: 10))
                        cloudImage("CloudSmallImage", offset: CGSize(width: -120, height: -60))
                        starImage("StarSmallImage", offset: CGSize(width: -40, height: -80))
                        starImage("StarImage", offset: CGSize(width: 140, height: -70))
                        starImage("StarImage", offset: CGSize(width: -70, height: 75))
                        cloudImage("MorningCloud", offset: CGSize(width: -100, height: 0))
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

//#Preview {
//    HelpProfileRectangleMorning()
//}
