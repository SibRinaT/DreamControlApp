//
//  LogInView.swift
//  DreamControlApp
//
//  Created by Ainur on 12.03.2024.
//

import SwiftUI

struct LogInView: View {
    var body: some View {
        ZStack {
            VStack {
                Image("registrImage")
                
                Image("registrImage")
                
                Image("registrImage")
            }
            Rectangle()
                .frame(height: 590)
                .cornerRadius(50)
                .shadow(radius: 30, y: -4)
                .overlay(
                    VStack {
                        Text("С возвращением !")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color("TextColor"))
                        Rectangle()
                            .frame(height: 10) // spacer :)
                        InputFieldView(title: "Email", placeholder: "DreamControl@gmail.com")
                        
                        InputFieldViewPassword(title: "Пароль", placeholder: "Пароль", isSecured: false)
                        
                        YellowButton(isActive: false, text: "Войти")
                        
                        OrView()
                        
                        ClearYellowButton(text: "Зарегистрироваться")
                        Rectangle()
                            .frame(height: 10) // spacer :)
                        HStack {
                            Text("Забыли пароль?")
                                .foregroundColor(Color("TextColor"))
                            Text("Восстановить пароль")
                                .foregroundColor(Color("SecondaryColor"))
                        }
                        Rectangle()
                            .frame(height: 30) // spacer :)
                        
                        Image("FullLogo")
                    }
                )
                .foregroundColor(.white)
                .offset(y: 120)
        }
    }
}

#Preview {
    NavigationView {
        LogInView()
    }
}
