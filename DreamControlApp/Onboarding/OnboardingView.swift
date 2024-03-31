//
//  OnboardingView.swift
//  DreamControlApp
//
//  Created by Ainur on 29.02.2024.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack {
            Image("onbImage1")
                .frame(width: 354, height: 354)
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            VStack {
                Text("Совершенствуйся и достигай!")
                    .font(.title)
                    .foregroundColor(Color(.black))
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
    OnboardingView()
}
