//
//  HelpProfileRectangleMorning.swift
//  DreamControlApp
//
//  Created by Ainur on 01.10.2024.
//

import SwiftUI

struct HelpProfileRectangleMorning: View {
    @Binding var isAnimating: Bool
    @State private var rotation: Double = 0

    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color("SuccessColor"))
                .frame(height: 200)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.15), radius: 10)
                .overlay(
                    ZStack {
                        animatedStar("StarSmallImage", offset: CGSize(width: -40, height: 30))
                        animatedCloud("CloudImage", offset: CGSize(width: -140, height: -30))
                        animatedCloud("CloudImage", offset: CGSize(width: -10, height: -80))
                        animatedCloud("CloudImage", offset: CGSize(width: -150, height: 65))
                        animatedStar("StarSmallImage", offset: CGSize(width: -150, height: -75))
                        animatedStar("StarSmallImage", offset: CGSize(width: -165, height: 10))
                        animatedCloud("CloudSmallImage", offset: CGSize(width: -120, height: -60))
                        animatedStar("StarSmallImage", offset: CGSize(width: -40, height: -80))
                        animatedStar("StarImage", offset: CGSize(width: 140, height: -70))
                        animatedStar("StarImage", offset: CGSize(width: -70, height: 75))
                        animatedCloud("MorningCloud", offset: CGSize(width: -100, height: 0))
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


//#Preview {
//    HelpProfileRectangleMorning()
//}
