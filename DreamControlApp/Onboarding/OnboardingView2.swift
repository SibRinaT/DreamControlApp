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
            Spacer()

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
                Image("pageImage2")
                    .offset(y: -40)
                Text("Совершенствуйся и достигай!")
                    .font(.title)
                    .foregroundColor(Color("TextColor"))
                    .bold()
                    .multilineTextAlignment(.center)
                NavigationLink(destination: OnboardingView3()) {
                    Rectangle()
                        .foregroundColor(Color("PrimaryColor"))
                        .cornerRadius(100)
                        .frame(height: 40)
                        .shadow(radius: 5)
                        .overlay(
                            Text("Начать")
                                .font(.title2)
                                .foregroundColor(.white)
                        )
                }
                    .navigationBarHidden(true) // Скрываем навигационную панель
            }
            Spacer()
        }
        .padding(.horizontal, 30)
    }
}

#Preview {
    NavigationView {
        OnboardingView2()
    }
}
