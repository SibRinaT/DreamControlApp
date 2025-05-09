//
//  InputFieldView.swift
//  DreamControlApp
//
//  Created by Ainur on 14.03.2024.
//

import SwiftUI

struct InputFieldView: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(Color("TextColor"))
                .font(.custom("MontserratAlternates-Regular", size: 20))
            ZStack {
                Group {
                    Capsule()
                        .stroke(Color("PrimaryColor"), lineWidth: 1)
                        .background(Color.clear)
                        .frame(width: 302, height: 40)
                    TextField(placeholder, text: $text)
                        .foregroundColor(Color("TextColor"))
                        .font(.custom("MontserratAlternates-Regular", size: 16))
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        .textFieldStyle(PlainTextFieldStyle())
                        .autocapitalization(.none) // Отключить автоматическое изменение раскладки
                        .frame(width: 302, height: 40)
                }
            }
                .font(.caption2)
                .textFieldStyle(.roundedBorder)
        }
        .padding(.bottom)
    }
}

#Preview {
    InputFieldView(title: "Email",
                   placeholder: "DreamControl@gmail.com", text: .constant("")

                )
}
