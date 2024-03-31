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
            Image("onbImage2")
                .frame(width: 354, height: 354)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            VStack {
                Text("Создай свою историю успеха!")
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
    OnboardingView3()
}
