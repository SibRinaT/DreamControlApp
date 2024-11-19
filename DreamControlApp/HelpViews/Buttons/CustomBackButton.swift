//
//  CustomBackButton.swift
//  DreamControlApp
//
//  Created by Ainur on 19.11.2024.
//

import SwiftUI

struct CustomBackButton: View {
    var body: some View {
        Button(action: {
            // Возврат к предыдущему экрану
            // Используйте `presentationMode` для управления навигацией
            if let presentationMode = UIApplication.shared.windows.first?.rootViewController?.presentedViewController {
                presentationMode.dismiss(animated: true, completion: nil)
            }
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

#Preview {
    CustomBackButton()
}
