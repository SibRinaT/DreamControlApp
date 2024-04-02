//
//  SignUpView.swift
//  DreamControlApp
//
//  Created by Ainur on 12.03.2024.
//

import SwiftUI

struct SignUpView: View {
    var body: some View {
        ZStack {
            VStack {
                Image("registrImage")
                
                Image("registrImage")
                
                Image("registrImage")
            }
            VStack {
                Rectangle()
                    .frame(height: 700)
                    .cornerRadius(50)
                    .shadow(radius: 30, y: -4)
                    .overlay(
                        VStack {
                            Spacer()
                            Text("Регистрация")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(Color("TextColor"))
                            Spacer()

                            VStack(alignment: .leading) {
                                InputFieldView(title: "Email", placeholder: "DreamControl@gmail.com")
                                
                                InputFieldView(title: "Имя аккаунта", placeholder: "DreamControl")
                                
                                InputFieldViewPassword(title: "Пароль", placeholder: "****************")
                                HStack {
                                    Rectangle()
                                        .foregroundColor(Color("InactiveColor"))
                                        .frame(width: 70, height: 2)
                                    Rectangle()
                                        .foregroundColor(Color("InactiveColor"))
                                        .frame(width: 70, height: 2)
                                    Rectangle()
                                        .foregroundColor(Color("InactiveColor"))
                                        .frame(width: 70, height: 2)
                                    Rectangle()
                                        .foregroundColor(Color("InactiveColor"))
                                        .frame(width: 70, height: 2)
                                }
                                InputFieldViewPassword(title: "Повторите пароль", placeholder: "****************")
                                
                                
                                
                                NavigationLink(destination: LogInView()) {
                                    YellowButton(isActive: false, text: "Зарегистрироваться ")
                                }
                            }
                            .navigationBarHidden(true)
                            
                            OrView()
            
                            ClearYellowButton(text: "Войти")
                            
                            NavigationLink(destination: LogInView()) {
                                Text("Есть аккаунт? Войдите тут!")
                                    .foregroundColor(Color("SecondaryColor"))
                            }
                            Spacer()
                        }
                    )
                    .foregroundColor(.white)
                    .offset(y: 100)

            }
        }
    }
}

#Preview {
    NavigationView {
        SignUpView()
    }
}
