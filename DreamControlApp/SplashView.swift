//
//  ContentView.swift
//  DreamControlApp
//
//  Created by Ainur on 29.02.2024.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var opacity = 0.5
    @State private var size = 0.8
    
    
    var body: some View {
        if isActive {
            OnboardingView()
        } else {
            VStack {
                VStack {
                    Image("morningImg")
                    Text("Утро начинается не с кофе а с мечтаний...")
                        .font(.custom("MainFont", size: 40))
                        .multilineTextAlignment(.center)
                        .shadow(color: Color.black.opacity(0.25), radius: 1, x: 2, y: 4) // Добавьте тень
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear() {
                    withAnimation(.easeIn(duration: 1.5)) {
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

#Preview {
    SplashView()
}
