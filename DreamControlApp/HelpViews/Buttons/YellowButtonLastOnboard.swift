//
//  YellowButtonLastOnboard.swift
//  DreamControlApp
//
//  Created by Ainur on 10.11.2024.
//

import SwiftUI

struct YellowButtonLastOnboard: View {
    var isActive: Bool
    let text: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .bold()
                .frame(width: 302, height: 40)
                .background(isActive ? Color("PrimaryColor") : Color("InactiveColor"))
                .foregroundColor(isActive ? .white : Color("InactiveColor2"))
                .cornerRadius(25)
        }
        .disabled(!isActive) // Блокируем действие, если кнопка неактивна
    }
}

#Preview {
    YellowButtonLastOnboard(isActive: false, text: "Войти", action: {})
}
