//
//  LastOnboarding.swift
//  DreamControlApp
//
//  Created by Ainur on 10.11.2024.
//

import SwiftUI

struct LastOnboarding: View {
    @State private var email = ""
    @State private var name = ""
    
    // Computed property to check if both fields are filled
    private var isButtonActive: Bool {
        !email.isEmpty && !name.isEmpty
    }
    
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
                            .frame(height: 10) // Spacer
                        
                        InputFieldView(title: "Email", placeholder: "DreamControl@gmail.com", text: $email)
                        InputFieldView(title: "Имя", placeholder: "Dream", text: $name)
                        
                        NavigationLink(destination: CustomTabBar()) {
                            YellowButtonLastOnboard(isActive: isButtonActive, text: "Войти") {
                            }
                        }
                        
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
    NavigationView {
        LastOnboarding()
            .environment(StoriesService())
            .environment(IdeasViewModel())
    }
}
