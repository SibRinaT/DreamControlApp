//
//  OnboardingView3.swift
//  DreamControlApp
//
//  Created by Ainur on 05.03.2024.
//

import SwiftUI

struct OnboardingView3: View {
    var body: some View {
        VStack {
            Image("onboardingImage4")
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            Rectangle()
                .foregroundColor(Color("mainOrange"))
                .frame(height: 19)
                .offset(y: -8)
            VStack {
                Spacer()
                Text("Желания")
                    .font(.title)
                    .foregroundColor(Color("mainOrange"))
                    .bold()
                Spacer()
                Text("Начните идти к своей мечте уже сегодня вместе с Dream Control!")
                    .font(.custom("mineFont", size: 20))
                    .multilineTextAlignment(.center)
                Spacer()
                Rectangle()
                    .foregroundColor(Color("mainOrange"))
                    .cornerRadius(100)
                    .frame(height: 55)
                    .overlay(
                        Text("Start")
                            .font(.title2)
                            .foregroundColor(.white)
                    )
//                Text("Skip")
//                    .foregroundColor(Color("mainOrange"))
//                    .font(.title2)
                Spacer()
            }
            .padding(.horizontal, 30)
        }
    }
}

#Preview {
    OnboardingView3()
}
