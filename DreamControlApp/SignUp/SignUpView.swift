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
                            Text("Регистрация")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(Color("TextColor"))
                            
                            NavigationLink(destination: LogInView()) {
                                Rectangle()
                                    .foregroundColor(Color("PrimaryColor"))
                                    .frame(width: 302 ,height: 40)
                                    .cornerRadius(25)
                                    .overlay(
                                        Text("Зарегистрироваться")
                                            .bold()
                                    )
                            }
                            .navigationBarHidden(true)
                        }
                    )
                    .foregroundColor(.white)
                    .offset(y: 80)
                
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
            }
        }
    }
}

#Preview {
    SignUpView()
}
