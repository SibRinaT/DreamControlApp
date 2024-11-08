//
//  MainOnboarding.swift
//  DreamControlApp
//
//  Created by Ainur on 05.03.2024.
//

import SwiftUI

struct MainOnboarding: View {
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Image("registrImage")
                    
                    Image("registrImage")
                    
                    Image("registrImage")
                }
                Rectangle()
                    .frame(height: 383)
                    .cornerRadius(50)
                    .shadow(radius: 30, y: -4)
                    .overlay(
                        VStack {
                            Text("Вход")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(Color("TextColor"))
                            
                            NavigationLink(destination: CustomTabBar()) {
                                YellowButton(isActive: true, text: "Войти")
                            }
                            .navigationBarHidden(true) // Скрываем навигационную панель
                            
                            Rectangle()
                                .frame(height: 5)
                            
                            HStack {
                                Rectangle()
                                    .frame(width: 133, height: 1)
                                    .foregroundColor(Color("PrimaryColor"))
                                    .shadow(radius: 15)
                                
                                Text("OR")
                                    .foregroundColor(Color("PrimaryColor"))
                                    .bold()
                                
                                Rectangle()
                                    .frame(width: 133, height: 1)
                                    .foregroundColor(Color("PrimaryColor"))
                            }
                            
                            Rectangle()
                                .frame(height: 5)
                            NavigationLink(destination: SignUpView()){
                                ClearYellowButton(text: "Зарегистрироваться")
                            }
                            .navigationBarHidden(true) // Скрываем навигационную панель
                            
                            Rectangle()
                                .frame(height: 50)
                            
                            Image("FullLogo")
                            Rectangle()
                                .frame(height: 30)
                        }
                    )
                    .foregroundColor(.white)
                    .offset(y: 250)
            }
        }
        .navigationBarHidden(true) // Скрываем навигационную панель
    }
}

#Preview {
        MainOnboarding()
}
