//
//  AppleId.swift
//  DreamControlApp
//
//  Created by Ainur on 08.11.2024.
//

import SwiftUI
import AuthenticationServices

struct AppleId: View {
    var body: some View {
        VStack {
            Text("Sign in to Your App")
                .font(.largeTitle)
                .padding()

            SignInWithAppleButton(.signIn) { request in
                // Конфигурируем запрос на аутентификацию
                request.requestedScopes = [.fullName, .email]
            } onCompletion: { result in
                // Обрабатываем результат аутентификации
                switch result {
                case .success(let authResults):
                    handleSignIn(result: authResults)
                case .failure(let error):
                    print("Authorization failed: \(error.localizedDescription)")
                }
            }
            .signInWithAppleButtonStyle(.black)
            .frame(width: 280, height: 60)
            .cornerRadius(10)
        }
    }
    
    func handleSignIn(result: ASAuthorization) {
        // Извлекаем данные пользователя после успешного входа
        if let appleIDCredential = result.credential as? ASAuthorizationAppleIDCredential {
            let userId = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email

            // Здесь можно сохранить данные пользователя в хранилище или выполнить другие действия
            print("User ID: \(userId)")
            print("Full Name: \(String(describing: fullName))")
            print("Email: \(String(describing: email))")
        }
    }
}


#Preview {
    AppleId()
}
