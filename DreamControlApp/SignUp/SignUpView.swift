//
//  SignUpView.swift
//  DreamControlApp
//
//  Created by Ainur on 12.03.2024.
//

import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var repeatPassword: String = ""
    @State private var isAgreed: Bool = false
    
    @State private var isPasswordValid: Bool = false
    @State private var isUsernameValid: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Image("registrImage")
                Image("registrImage")
                Image("registrImage")
                Rectangle()
                    .frame(height: 800)
                    .cornerRadius(50)
                    .shadow(radius: 30, y: -4)
                    .overlay {
                        VStack {
                            Spacer()
                            Text("Регистрация")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(Color("TextColor"))
                            Spacer()
                            
                            VStack {
                                VStack {
                                    InputFieldView(title: "Email", placeholder: "DreamControl@gmail.com", text: email)
                                    InputFieldView(title: "Имя аккаунта", placeholder: "DreamControl", text: username)
                                    InputFieldViewPassword(title: "Пароль", placeholder: "****************", text: password)
                                        .onChange(of: password) { newValue in
                                            isPasswordValid = newValue.count >= 6 && newValue.rangeOfCharacter(from: .decimalDigits) != nil
                                        }
                                    VStack {
                                        if !isPasswordValid {
                                            Text("Пароль должен содержать минимум 6 символов и хотя бы одну цифру")
                                                .foregroundColor(.red)
                                                .font(.caption)
                                        }
                                    }
                                    .padding(.horizontal, 40)
                                    
                                }
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
                                VStack {
                                    InputFieldViewPassword(title: "Повторите пароль", placeholder: "****************", text: repeatPassword)
                                    // Проверка на совпадение паролей
                                    if repeatPassword != password {
                                        Text("Пароли не совпадают")
                                            .foregroundColor(.red)
                                            .font(.caption)
                                    }
                                }
                                HStack {
                                    CustomCheckBoxView(text: "")
                                    VStack (alignment: .leading) {
                                        HStack {
                                            Text("Cоглащаюсь с ")
                                                .foregroundColor(Color("TextColor"))
                                            
                                            Text("политикой ")
                                                .foregroundColor(Color("SecondaryColor"))
                                        }
                                        Text("конфиденциальности")
                                            .foregroundColor(Color("SecondaryColor"))
                                    }
                                }
                                
                                NavigationLink(destination: LogInView()) {
                                    YellowButton(isActive: isPasswordValid && repeatPassword == password && !email.isEmpty && !username.isEmpty && isAgreed, text: "Зарегистрироваться")
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
                            Spacer()
                            Spacer()
                            
                        }
                    }
                    .foregroundColor(.white)
                    .offset(y: -400)
            }
        }
    }
}

        #Preview {
            NavigationView {
                SignUpView()
            }
        }
