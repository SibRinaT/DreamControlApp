//
//  OnboardingView.swift
//  DreamControlApp
//
//  Created by Ainur on 29.02.2024.
//

import SwiftUI

struct OnboardingView2: View {
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .frame(width: 500, height: 500)
                    .offset(y: -160)
                    .blur(radius: 70)
                    .foregroundColor(Color("SuccessColor"))
                Image("onbImage1")
                    .frame(width: 354, height: 354)
                    .shadow(radius: 4, x: 0, y: 4)
            }
            VStack {
                Text("Совершенствуйся и достигай!")
                    .font(.title)
                    .foregroundColor(Color("TextColor"))
                    .bold()
                    .multilineTextAlignment(.center)
                Rectangle()
                    .cornerRadius(100)
                    .frame(height: 55)
                    .overlay(
                        Text("Next")
                            .font(.title2)
                            .foregroundColor(.white)
                    )
            }
        }
        .padding(.horizontal, 30)

    }
}

#Preview {
    OnboardingView2()
}
