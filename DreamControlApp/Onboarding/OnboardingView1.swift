//
//  OnboardingView2.swift
//  DreamControlApp
//
//  Created by Ainur on 03.03.2024.
//

import SwiftUI

struct OnboardingView1: View {
    @State private var offset: CGSize = .zero
    @State private var isSwiped: Bool = false
    
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
                    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
            }
            VStack {
                Image("pageImage1")
                    .offset(y: -40)
                Text("Теряешь мотивацию? Получи её тут!")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("TextColor"))
                    .multilineTextAlignment(.center)
                NavigationLink(destination: OnboardingView2()) {
                                       Rectangle()
                                           .foregroundColor(Color("PrimaryColor"))
                                           .cornerRadius(100)
                                           .frame(height: 40)
                                           .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                                           .overlay(
                                               Text("Начать")
                                                   .font(.title2)
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
                    if offset.width < -100 { // Если свайп был влево
                        isSwiped = true
                    } else {
                        offset = .zero // Возвращаем обратно, если свайп слабый
                    }
                }
        )
        .background(
            NavigationLink(destination: OnboardingView2(), isActive: $isSwiped) {
                EmptyView()
            }
        )
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationView {
        OnboardingView1()
    }
}
