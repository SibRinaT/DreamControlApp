//
//  MainOnboarding.swift
//  DreamControlApp
//
//  Created by Ainur on 05.03.2024.
//

import SwiftUI

struct MainOnboarding: View {
    var body: some View {
        TabView {
            OnboardingView1()
            OnboardingView2()
            OnboardingView3()

        }
        .tabViewStyle(.page)
    
//        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

#Preview {
    MainOnboarding()
}
