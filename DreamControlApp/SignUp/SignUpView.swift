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
            Image("registrImage")
            Rectangle()
                .frame(height: 100) // Задаем размеры прямоугольника
                .cornerRadius(20)
                .overlay(
                    Text("Регистрация")
                )
                .foregroundColor(.white)
        }
    }
}

#Preview {
    SignUpView()
}
