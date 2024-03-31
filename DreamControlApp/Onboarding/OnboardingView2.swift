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
            Image("onbImage2")
                .frame(width: 354, height: 354)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            VStack {
                Text("Теряешь мотивацию?Получи её тут!")
                    .font(.title)
                    .foregroundColor(Color("mainOrange"))
                    .multilineTextAlignment(.center)
                    .bold()

                Rectangle()
                    .foregroundColor(Color("mainOrange"))
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
