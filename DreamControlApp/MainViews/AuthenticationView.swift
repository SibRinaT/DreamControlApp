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
                .shadow(radius: 30, y: -4)
                .overlay(
                    VStack {
                 
                        Text("Подтвердите почту")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color("TextColor"))
                            .offset(y: 40)
                        
                        HStack {
                            Image("AuthCircle")
                                .overlay(
                                    Text("asdsd")
                                )
                            Image("AuthCircle")
                                .overlay(
                                    Text("asdsd")
                                )
                            Image("AuthCircle")
                                .overlay(
                                    Text("asdsd")
                                )
                            Image("AuthCircle")
                                .overlay(
                                    Text("asdsd")
                                )
                        }
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
                        
                        Rectangle()
                            .frame(height: 250)
                        
                        Image("FullLogo")
                        Rectangle()
                            .frame(height: 30)
                    }
                )
                .foregroundColor(.white)
                .offset(y: 100)
        }
    }
}

#Preview {
    AuthenticationView()
}
