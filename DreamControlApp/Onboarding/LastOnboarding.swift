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
//    @State private var navigateToTabBar = false
    @EnvironmentObject var userManager: UserManager
    @Environment(AppRootManager.self) private var appRootManager
    
    @AppStorage("userName") private var savedName: String = ""

    private var isButtonActive: Bool {
        isInputValid
    }
    
    private var isInputValid: Bool {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines) // обрезка пробелов 
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // проверка email-формата
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return !trimmedEmail.isEmpty &&
               !trimmedName.isEmpty &&
               emailPredicate.evaluate(with: trimmedEmail)
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
                        Text("Вход")
                            .padding(.top, 30)
                            .font(.custom("MontserratAlternates-Regular", size: 32))
                            .bold()
                            .foregroundColor(Color("TextColor"))
                        Rectangle()
                            .frame(height: 10) // Spacer
                        
                        InputFieldView(title: "Email", placeholder: "DreamControl@gmail.com", text: $email)
                            .font(.custom("MontserratAlternates-Regular", size: 14))
                        InputFieldView(title: "Имя", placeholder: "Dream", text: Binding(
                            get: { name },
                            set: { newValue in
                                if newValue.count <= 10 {
                                    name = newValue
                                } else {
                                    name = String(newValue.prefix(10))
                                }
                            }
                        ))
                        
//                        NavigationLink(destination: CustomTabBar(), isActive: $navigateToTabBar) {
//                            EmptyView()
//                        }
//                        .navigationBarHidden(true)
                        
                        YellowButtonLastOnboard(isActive: isButtonActive, text: "Войти") {
                            if isButtonActive {
                                UserDefaults.standard.set(true, forKey: "onboardingCompleted")
                                savedName = name // Сохранение имени в UserDefaults через @AppStorage
                                appRootManager.currentRoot = .timeBasedSplashView
//                                navigateToTabBar = true // Активируем навигацию
                                let newUser = User(
                                    id: UUID().uuidString,
                                    name: name,
                                    isAdmin: false,
                                    email: email
                                )
                                userManager.saveUser(newUser)
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
