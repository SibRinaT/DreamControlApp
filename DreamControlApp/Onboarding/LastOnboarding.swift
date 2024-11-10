//
//  LastOnboarding.swift
//  DreamControlApp
//
//  Created by Ainur on 10.11.2024.
//

import SwiftUI

struct LastOnboarding: View {
    @State var email = ""
    @State var name = ""

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
                        Text("Регистрация")
                            .padding(.top, 30)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color("TextColor"))
                        Rectangle()
                            .frame(height: 10) // spacer :)
                        
                        InputFieldView(title: "Email", placeholder: "DreamControl@gmail.com", text: $email)
                        InputFieldView(title: "Имя", placeholder: "Dream", text: $email)

                        YellowButton(isActive: false, text: "Войти")
                    
                        Rectangle()
                            .frame(height: 10) // spacer :)
                       
                        Rectangle()
                            .frame(height: 30) // spacer :)
                        
                        Spacer()
                        Image("FullLogo")
                            .padding(.bottom, 30)
                    }
                )
                .foregroundColor(.white)
                .offset(y: 120)
        }
    }
}


#Preview {
    LastOnboarding()
}
