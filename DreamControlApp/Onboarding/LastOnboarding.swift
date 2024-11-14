//
//  LastOnboarding.swift
//  DreamControlApp
//
//  Created by Ainur on 10.11.2024.
//

import SwiftUI

struct LastOnboarding: View {
    @State private var email = ""
    @State private var name = ""
    @State private var navigateToTabBar = false  // состояние для навигации

    private var isButtonActive: Bool {
        !email.isEmpty && !name.isEmpty
    }
    
    var body: some View {
        ZStack {
            VStack {
                Image("registrImage")
                Image("registrImage")
                Image("registrImage")
                Image("registrImage")
                Image("registrImage")
                
            }
            Rectangle()
                .frame(height: 590)
                .cornerRadius(50)
                .shadow(radius: 30, y: -4)
                .overlay(
                    VStack {
                        Text("Регистрация")
                            .padding(.top, 30)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color("TextColor"))
                        Rectangle()
                            .frame(height: 10) // Spacer
                        
                        InputFieldView(title: "Email", placeholder: "DreamControl@gmail.com", text: $email)
                        InputFieldView(title: "Имя", placeholder: "Dream", text: $name)
                        
                        NavigationLink(destination: CustomTabBar(), isActive: $navigateToTabBar) {
                            EmptyView()
                        }
                        .navigationBarHidden(true) 
                        
                        YellowButtonLastOnboard(isActive: isButtonActive, text: "Войти") {
                            if isButtonActive {
                                // Обновляем флаг онбординга в UserDefaults
                                UserDefaults.standard.set(true, forKey: "onboardingCompleted")
                                navigateToTabBar = true // Активируем навигацию
                            }
                        }
                        
                        Rectangle()
                            .frame(height: 10) // Spacer
                        
                        Rectangle()
                            .frame(height: 30) // Spacer
                        
                        Spacer()
                        Image("FullLogo")
                            .padding(.bottom, 50)
                    }
                )
                .foregroundColor(.white)
                .offset(y: 120)
        }
    }
}


#Preview {
    NavigationView {
        LastOnboarding()
            .environment(StoriesService())
            .environment(IdeasViewModel())
    }
}