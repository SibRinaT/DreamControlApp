//
//  CreateNewPasswordView.swift
//  DreamControlApp
//
//  Created by Ainur on 05.04.2024.
//

import SwiftUI

struct CreateNewPasswordView: View {
    @State var password: String = ""
    @State var repeatPassword: String = ""
    var body: some View {
        ZStack {
            VStack {
                Image("registrImage")
                
                Image("registrImage")
                
                Image("registrImage")
            }
            Rectangle()
                .frame(height: 641)
                .cornerRadius(50)
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                .overlay(
                    VStack {
                        Text("Создайте новый пароль")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color("TextColor"))
                            .multilineTextAlignment(.center)
                        Rectangle()
                            .frame(height: 10)
                        InputFieldViewPassword(title: "Пароль", placeholder: "Пароль", text: $password)
                        InputFieldViewPassword(title: "Подтвердите пароль", placeholder: "Пароль", text: $repeatPassword)
                     
                        
                        NavigationLink(destination: LogInView()) {
                            YellowButton(isActive: false, text: "Подтвердить")
                        }
                        .navigationBarHidden(true) // Скрываем навигационную панель

                        Rectangle()
                            .frame(height: 20)
                        
//                        Rectangle()
//                            .frame(height: 250)
                        
                        Image("FullLogo")
                            .offset(y: 170)
                        Rectangle()
                            .frame(height: 30)
                    }
                        .offset(y: -80)
                )
                .foregroundColor(.white)
                .offset(y: 100)
        }
    }
}

#Preview {
    CreateNewPasswordView()
}
