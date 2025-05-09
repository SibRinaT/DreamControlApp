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
    @State private var navigateToTabBar = false
    
    @AppStorage("userName") private var savedName: String = "" // Сохранение имени пользователя в UserDefaults

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
                .frame(height: 650)
                .cornerRadius(50)
                .shadow(radius: 30, y: -4)
                .overlay(
                    VStack {
                        Text("Регистрация")
                            .padding(.top, 30)
                            .font(.custom("MontserratAlternates-Regular", size: 32))
                            .bold()
                            .foregroundColor(Color("TextColor"))
                        Rectangle()
                            .frame(height: 10) // Spacer
                        
                        InputFieldView(title: "Email", placeholder: "DreamControl@gmail.com", text: $email)
                            .font(.custom("MontserratAlternates-Regular", size: 14))
                        InputFieldView(title: "Имя", placeholder: "Dream", text: $name)
                            .font(.custom("MontserratAlternates-Regular", size: 14))

                        
                        NavigationLink(destination: CustomTabBar(), isActive: $navigateToTabBar) {
                            EmptyView()
                        }
                        .navigationBarHidden(true)
                        
                        YellowButtonLastOnboard(isActive: isButtonActive, text: "Войти") {
                            if isButtonActive {
                                UserDefaults.standard.set(true, forKey: "onboardingCompleted")
                                savedName = name // Сохранение имени в UserDefaults через @AppStorage
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
            .environment(IdeasViewModel())
    }
}
