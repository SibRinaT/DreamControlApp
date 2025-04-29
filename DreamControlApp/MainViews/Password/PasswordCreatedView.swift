//
//  PasswordCreatedView.swift
//  DreamControlApp
//
//  Created by Ainur on 05.04.2024.
//

import SwiftUI

struct PasswordCreatedView: View {
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
                        Text("Новый пароль успешно создан!")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color("TextColor"))
                            .multilineTextAlignment(.center)
                        Rectangle()
                            .frame(height: 10)
                  
                        Image("AcceptImg")

                        
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
    PasswordCreatedView()
}
