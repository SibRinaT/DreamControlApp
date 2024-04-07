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
    @State var text: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(Color("TextColor"))
                .font(.custom("MontserratAlternates", size: 20)) // need to fix a font
            ZStack {
                Group {
                    Capsule()
                        .stroke(Color("PrimaryColor"), lineWidth: 1)
                        .background(Color.clear)
                        .frame(width: 302, height: 40)
                    TextField(placeholder, text: $text)
                        .foregroundColor(Color("InactiveColor"))
                        .font(.custom("MontserratAlternates", size: 16)) // need to fix a font
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        .textFieldStyle(PlainTextFieldStyle())
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
                   placeholder: "DreamControl@gmail.com", text: ""
                )
}
