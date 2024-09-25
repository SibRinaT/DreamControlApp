//
//  InputFieldView.swift
//  DreamControlApp
//
//  Created by Ainur on 13.03.2024.
//

import SwiftUI

struct InputFieldViewPassword: View {
    let title: String
    let placeholder: String
    @State private var isPasswordHidden = true
    @Binding var text: String

    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(Color("TextColor"))
                .font(.custom("", size: 20))
            ZStack(alignment: .trailing) {
                Group {
                    Capsule()
                        .stroke(Color("PrimaryColor"), lineWidth: 1)
                        .background(Color.clear)
                        .frame(width: 302, height: 40)
                    if  isPasswordHidden {
                        SecureField(placeholder, text: $text)
                            .foregroundColor(Color("InactiveColor"))
                            .font(.custom("MontserratAlternates", size: 16)) // need to fix a font
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                            .textFieldStyle(PlainTextFieldStyle())
                            .frame(width: 302, height: 40)
                    } else {
                        TextField(placeholder, text:  $text)
                            .foregroundColor(Color("InactiveColor"))
                            .font(.custom("MontserratAlternates", size: 16)) // need to fix a font
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                            .textFieldStyle(PlainTextFieldStyle())
                            .frame(width: 302, height: 40)
                    }
                }
                Button(action: {
                    isPasswordHidden.toggle()
                }) {
                    Image(self.isPasswordHidden ? "EyeSlashIcon" : "EyeIcon")
                        .accentColor(Color("PrimaryColor"))
                }
                .padding(.trailing, 5)
            }
        }
        .padding(.bottom)
    }
}

#Preview {
    InputFieldViewPassword(title: "Пароль",
                   placeholder: "*******",
                           text: .constant("")
                           )
}
