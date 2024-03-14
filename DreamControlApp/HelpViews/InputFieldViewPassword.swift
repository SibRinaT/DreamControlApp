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
    @State var isSecured = false
    @State private var isPasswordHidden = true
    @Binding var fieldValue: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(.gray)
                .font(.caption)
            ZStack(alignment: .trailing) {
                Group {
                    if isSecured && isPasswordHidden {
                        SecureField(placeholder, text: $fieldValue)
                    }
                    else {
                        TextField(placeholder, text: $fieldValue)
                    }
                }
                .font(.caption2)
                .textFieldStyle(.roundedBorder)
                                
                Button(action: {
                    isPasswordHidden.toggle()
                }) {
                    Image(systemName: self.isPasswordHidden ? "eye" : "eye.slash")
                        .accentColor(.gray)
                }
                .padding(.trailing, 5)
                .opacity(isSecured ? 1: 0)
            }
        }
        .padding(.bottom)
    }
}

#Preview {
    InputFieldViewPassword(title: "Full name",
                   placeholder: "Ivanov Ivan",
                   isSecured: true,
                   fieldValue:  Binding(
                    get: { "" },
                    set: { _ in }
                ))
}
