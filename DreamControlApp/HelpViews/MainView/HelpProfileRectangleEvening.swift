//
//  HelpProfileRectangleEvening.swift
//  DreamControlApp
//
//  Created by Ainur on 01.10.2024.
//
import SwiftUI

struct HelpProfileRectangleEvening: View {
    @Binding var isAnimating: Bool // Управление анимацией извне
    @State private var rotateAmount: CGFloat = 5 // Угол поворота

    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color("SecondaryColor"))
                .frame(height: 200)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                .overlay(
                    ZStack {
                        cloudImage("CloudSmallImage", offset: CGSize(width: -150, height: -75))
                        cloudImage("CloudImage", offset: CGSize(width: -140, height: -30))
                        cloudImage("CloudImage", offset: CGSize(width: -50, height: -45))
                        cloudImage("CloudImage", offset: CGSize(width: -150, height: 65))
                        cloudImage("CloudImage", offset: CGSize(width: -50, height: 60))
                        starImage("StarSmallImage", offset: CGSize(width: -40, height: 30))
                        starImage("StarSmallImage", offset: CGSize(width: -165, height: 10))
                        starImage("StarSmallImage", offset: CGSize(width: -120, height: -60))
                        starImage("StarSmallImage", offset: CGSize(width: -40, height: -80))
                        starImage("StarImage", offset: CGSize(width: 140, height: -70))
                        cloudImage("EveningCloud", offset: CGSize(width: -100, height: 0))
                    }
                )
        }
        .padding(.horizontal)
        .onAppear {
            startAnimationIfNeeded()
        }
        .onChange(of: isAnimating) { _ in
            startAnimationIfNeeded()
        }
    }

    private func startAnimationIfNeeded() {
        if isAnimating {
            withAnimation(Animation.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
                rotateAmount = 5
            }
        } else {
            withAnimation(.default) {
                rotateAmount = 5
            }
        }
    }

    private func cloudImage(_ name: String, offset: CGSize) -> some View {
        Image(name)
            .offset(offset)
            .rotationEffect(.degrees(rotateAmount))
    }

    private func starImage(_ name: String, offset: CGSize) -> some View {
        Image(name)
            .offset(offset)
            .rotationEffect(.degrees(-rotateAmount))
    }
}
