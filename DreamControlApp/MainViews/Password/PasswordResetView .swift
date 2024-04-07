//
//  PasswordResetView .swift
//  DreamControlApp
//
//  Created by Ainur on 04.04.2024.
//

import SwiftUI

struct PasswordResetView_: View {
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
                        Text("Сброс пароля")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color("TextColor"))
//                        Rectangle()
//                            .frame(height: 10)
                        
                        Text("Введите адрес электронной почты, связанный с вашей учетной записью, и мы вышлем по электронной почте код для сброса вашего пароля")
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("TextColor"))
                            .padding(.horizontal, 40)
                        
                        InputFieldView(title: "Email", placeholder: "DreamControl@gmail.com", text: "")
                        
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
    PasswordResetView_()
}
