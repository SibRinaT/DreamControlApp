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
            Image("onboardingImage1")
                .frame(width: 354, height: 354)
                .clipShape(Circle())
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            VStack {
                Text("Мечты")
                    .font(.title)
                    .foregroundColor(Color("mainOrange"))
                    .bold()
                Text("Отмечай свои самые желанные достижения и достигай высот вместе с нами!")
                    .font(.custom("mineFont", size: 20))
                    .multilineTextAlignment(.center)
                Rectangle()
                    .foregroundColor(Color("mainOrange"))
                    .cornerRadius(100)
                    .frame(height: 55)
                    .overlay(
                        Text("Next")
                            .font(.title2)
                            .foregroundColor(.white)
                    )
                Text("Skip")
                    .foregroundColor(Color("mainOrange"))
                    .font(.title2)
            }
        }
        .padding(.horizontal, 30)
    }
}

#Preview {
    OnboardingView()
}
