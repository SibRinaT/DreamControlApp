//
//  ContentView.swift
//  DreamControlApp
//
//  Created by Ainur on 29.02.2024.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var opacity = 0.9
    @State private var size = 0.8
//    @Binding var onboardingCompleted: Bool  // Для проверки завершенности онбординга
    @Binding var user: User
    
    var body: some View {
        if isActive {
            OnboardingView1(user: $user)
        } else {
            VStack {
                ZStack {
                    Image("DImage")
                    Image("StarImage")
                        .scaleEffect(size)
                        .opacity(opacity)
                        .onAppear() {
                            withAnimation(.easeIn(duration: 0.7)) {
                                self.size = 10
                                self.opacity = 1.0
                            }
                        }
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear() {
                    withAnimation(.easeIn(duration: 2)) {
                        self.size = 1
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation() {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

//#Preview {
//    NavigationView {
//        SplashView(user: <#Binding<User>#>)
//    }
//}
