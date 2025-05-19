//
//  OnboardingView3.swift
//  DreamControlApp
//
//  Created by Ainur on 31.03.2024.
//
import SwiftUI

struct OnboardingView3: View {
    @State private var offset: CGSize = .zero
    @State private var isSwiped: Bool = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Circle()
                    .frame(width: 500, height: 500)
                    .offset(y: -170)
                    .blur(radius: 70)
                    .foregroundColor(Color("SecondaryColor"))
                VStack {
                    Image("onbImage3")
                        .frame(width: 354, height: 354)
                        .shadow(radius: 10)
                }
            }
            .edgesIgnoringSafeArea(.top)
            VStack {
                Image("pageImage3")
                    .offset(y: -40)
                Text("Создай свою историю успеха!")
                    .font(.custom("MontserratAlternates-Regular", size: 26))
                    .font(.custom("MontserratAlternates", size: 14))
                    .foregroundColor(Color("TextColor"))
                    .multilineTextAlignment(.center)
                    .bold()
                NavigationLink(destination: LastOnboarding()) {
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
            NavigationLink(destination: LastOnboarding(), isActive: $isSwiped) {
                EmptyView()
            }
        )
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationView {
        OnboardingView3()
    }
}
