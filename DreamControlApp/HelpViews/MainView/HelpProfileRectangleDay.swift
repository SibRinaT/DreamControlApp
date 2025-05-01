//
//  HellpProfile.swift
//  DreamControlApp
//
//  Created by Ainur on 20.04.2024.
//

import SwiftUI

struct HelpProfileRectangleDay: View {
    @Binding var isAnimating: Bool
    @State private var rotation: Double = 0

    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color("PrimaryColor"))
                .frame(height: 200)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.15), radius: 10)
                .overlay(
                    ZStack {
                        animatedCloud("CloudSmallImage", offset: CGSize(width: -150, height: -75))
                        animatedCloud("CloudImage", offset: CGSize(width: -140, height: -30))
                        animatedCloud("CloudImage", offset: CGSize(width: -50, height: -45))
                        animatedCloud("CloudImage", offset: CGSize(width: -150, height: 65))
                        animatedCloud("CloudImage", offset: CGSize(width: -50, height: 60))
                        animatedStar("StarSmallImage", offset: CGSize(width: -40, height: 30))
                        animatedStar("StarSmallImage", offset: CGSize(width: -165, height: 10))
                        animatedStar("StarSmallImage", offset: CGSize(width: -120, height: -60))
                        animatedStar("StarSmallImage", offset: CGSize(width: -40, height: -80))
                        animatedStar("StarImage", offset: CGSize(width: 140, height: -70))
                        animatedCloud("IllustrationHome", offset: CGSize(width: -100, height: 0))
                    }
                )
        }
        .padding(.horizontal)
        .onAppear(perform: startRotation)
    }

    private func startRotation() {
        guard isAnimating else { return }
        withAnimation(Animation.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
            rotation = 5
        }
    }

    private func animatedCloud(_ name: String, offset: CGSize) -> some View {
        Image(name)
            .offset(offset)
            .rotationEffect(.degrees(isAnimating ? rotation : 0))
    }

    private func animatedStar(_ name: String, offset: CGSize) -> some View {
        Image(name)
            .offset(offset)
            .rotationEffect(.degrees(isAnimating ? -rotation : 0))
    }
}
