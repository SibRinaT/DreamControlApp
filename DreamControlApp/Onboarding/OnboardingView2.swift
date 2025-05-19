//
//  OnboardingView.swift
//  DreamControlApp
//
//  Created by Ainur on 29.02.2024.
//

import SwiftUI

struct OnboardingView2: View {
    @State private var offset: CGSize = .zero
    @State private var isSwiped: Bool = false
    @Environment(\.dismiss) var dismiss

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
                    .font(.custom("MontserratAlternates-Regular", size: 26))
                    .foregroundColor(Color("TextColor"))
                    .bold()
                    .multilineTextAlignment(.center)
            }
            NavigationLink(destination: OnboardingView3()) {
                Rectangle()
                    .foregroundColor(Color("PrimaryColor"))
                    .cornerRadius(100)
                    .frame(height: 40)
                    .shadow(radius: 5)
                    .overlay(
                        Text("Начать")
                            .font(.custom("MontserratAlternates-Regular", size: 22))
                            .foregroundColor(.white)
                    )
            }
            Spacer()
        }
        .padding(.horizontal, 30)
        .offset(x: offset.width)
        .gesture(
              DragGesture()
                  .onChanged { gesture in
                      offset = gesture.translation
                  }
                  .onEnded { _ in
                      if offset.width < -100 {
                          isSwiped = true
                      } else if offset.width > 100 {
                          dismiss() // Вернуться на предыдущий экран
                      } else {
                          offset = .zero
                      }
                  }
          )
        .background(
            NavigationLink(destination: OnboardingView3(), isActive: $isSwiped) {
                EmptyView()
            }
        )
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationView {
        OnboardingView2()
    }
}
