//
//  AuthenticationView.swift
//  DreamControlApp
//
//  Created by Ainur on 03.04.2024.
//

import SwiftUI

struct AuthenticationView: View {
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
                        Text("Проверьте почту")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color("TextColor"))
//                        Rectangle()
//                            .frame(height: 10)
                        
                        Text("Поможем восстановить вашу мечту")
                            .foregroundColor(Color("TextColor"))
                        
                        AuthPasswordInputField()
                        
                        Rectangle()
                            .frame(height: 20)
                        
                        NavigationLink(destination: LogInView()) {
                            YellowButton(isActive: false, text: "Подтвердить")
                        }
                        .navigationBarHidden(true) // Скрываем навигационную панель

                        Rectangle()
                            .frame(height: 20)
                
                        NavigationLink(destination: LogInView()) {
                            YellowButton(isActive: false, text: "Отправить повторно")
                        }
                        .navigationBarHidden(true) // Скрываем навигационную панель

                        Text("Повторное письмо доступно \n через 59 секунд")
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("TextColor"))
                            .font(.custom("", size: 12))
                        
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
    AuthenticationView()
}
