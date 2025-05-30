//
//  ClearYellowButton.swift
//  DreamControlApp
//
//  Created by Ainur on 02.04.2024.
//

import SwiftUI

struct ClearYellowButton: View {
    let text: String
    var body: some View {
        ZStack {
            Text(text)
                .foregroundColor(Color("PrimaryColor"))
                .bold()
            Capsule()
                .stroke(Color("PrimaryColor"), lineWidth: 2) // Цвет и толщина границы
                .background(Color.clear) // Прозрачный фон
                .frame(width: 302, height: 40)
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
        }
    }
}

#Preview {
    ClearYellowButton(text: "Зарегистрироваться")
}
