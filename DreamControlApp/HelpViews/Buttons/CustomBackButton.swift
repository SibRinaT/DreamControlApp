//
//  CustomBackButton.swift
//  DreamControlApp
//
//  Created by Ainur on 19.11.2024.
//

import SwiftUI

struct CustomBackButton: View {
    var body: some View {
        @Environment(\.dismiss) var dismiss
        
        Button(action: {
            dismiss() // Возвращает на предыдущий экран
        }) {
            Rectangle()
                .cornerRadius(8)
                .foregroundColor(Color("PrimaryColor"))
                .frame(width: 100, height: 50)
                .overlay (
            HStack {
                Image(systemName: "chevron.left")
                    .font(.title)
                    .foregroundColor(.white)
                Text("Назад")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            )
            .padding()
        }
        .foregroundColor(.blue) // Настроить цвет кнопки
    }
}

struct CustomBackButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CustomBackButton()
                }
            }
    }
}

extension View {
    func customBackButton() -> some View {
        self.modifier(CustomBackButtonModifier())
    }
}

#Preview {
    CustomBackButton()
}
