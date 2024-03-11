//
//  OnboardingView2.swift
//  DreamControlApp
//
//  Created by Ainur on 03.03.2024.
//

import SwiftUI

struct OnboardingView2: View {
    var body: some View {
        VStack {
            Image("onboardingImage2")
                .frame(width: 354, height: 354)
                .clipShape(Circle())
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            VStack {
                Text("Желания")
                    .font(.title)
                    .foregroundColor(Color("mainOrange"))
                    .bold()
                Text("Достигайте, всё что нужно - желание!")
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
    OnboardingView2()
}
