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
            // Ваш код
            
            VStack(alignment: .leading) {
                InputFieldView(title: "Email", placeholder: "DreamControl@gmail.com", text: email)
                
                InputFieldView(title: "Имя аккаунта", placeholder: "DreamControl", text: username)
                
                InputFieldViewPassword(title: "Пароль", placeholder: "****************", text: password)
                    .onChange(of: password) { newValue in
                        isPasswordValid = newValue.count >= 6 && newValue.rangeOfCharacter(from: .decimalDigits) != nil
                    }
                
                // Проверка на валидность пароля
                if !isPasswordValid {
                    Text("Пароль должен содержать минимум 6 символов и хотя бы одну цифру")
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                InputFieldViewPassword(title: "Повторите пароль", placeholder: "****************", text: repeatPassword)
                
                // Проверка на совпадение паролей
                if repeatPassword != password {
                    Text("Пароли не совпадают")
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                // Проверка на соглашение
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
                
                // Проверка на заполненность всех полей
                if email.isEmpty || username.isEmpty || password.isEmpty || repeatPassword.isEmpty || !isAgreed {
                    Text("Пожалуйста, заполните все поля")
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                NavigationLink(destination: LogInView()) {
                    YellowButton(isActive: isPasswordValid && repeatPassword == password && !email.isEmpty && !username.isEmpty && isAgreed, text: "Зарегистрироваться")
                }
            }
        }
    }
}


#Preview {
    NavigationView {
        SignUpView()
    }
}
