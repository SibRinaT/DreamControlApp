//
//  OnboardingView3.swift
//  DreamControlApp
//
//  Created by Ainur on 31.03.2024.
//

import SwiftUI

struct OnboardingView3: View {
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Circle()
                    .frame(width: 500, height: 500)
                    .offset(y: -170)
                    .blur(radius: 70)
                    .foregroundColor(Color("SecondaryColor"))
                VStack{
                    Image("onbImage3")
                        .frame(width: 354, height: 354)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                }
       
            }
            .edgesIgnoringSafeArea(.top)
            VStack {
                Image("pageImage3")
                    .offset(y: -40)
                Text("Создай свою историю успеха!")
                    .font(.title)
                    .font(.custom("MontserratAlternates", size: 14))
                    .foregroundColor(Color("TextColor"))
                    .multilineTextAlignment(.center)
                    .bold()
                NavigationLink(destination: MainOnboarding()) {
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
        OnboardingView3()
    }
}
