//
//  OnboardingView2.swift
//  DreamControlApp
//
//  Created by Ainur on 03.03.2024.
//

import SwiftUI

struct OnboardingView1: View {
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Circle()
                    .frame(width: 500, height: 500)
                    .offset(y: -160)
                    .blur(radius: 70)
                    .foregroundColor(Color("PrimaryColor"))
                Image("onbImage2")
                    .frame(width: 354, height: 354)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }
            
            VStack {
                Text("Теряешь мотивацию?Получи её тут!")
//                    .font(.custom("MontserratAlternates", size: 24))
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("TextColor"))
                    .multilineTextAlignment(.center)
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
            Spacer()
        }
        .padding(.horizontal, 30)
    }
}

#Preview {
    OnboardingView1()
}
