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
    @Binding var user: User
    
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
            }
            NavigationLink(destination: OnboardingView3(user: $user)) {
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
        .offset(x: offset.width)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if offset.width < -100 { // Если свайп был влево
                        isSwiped = true
                    } else {
                        offset = .zero // Возвращаем обратно, если свайп слабый
                    }
                }
        )
        .background(
            NavigationLink(destination: OnboardingView3(user: $user), isActive: $isSwiped) {
                EmptyView()
            }
        )
        .navigationBarHidden(true)
    }
}

//#Preview {
//    NavigationView {
//        OnboardingView2()
//    }
//}
