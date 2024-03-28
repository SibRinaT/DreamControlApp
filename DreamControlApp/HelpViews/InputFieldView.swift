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
    @Binding var fieldValue: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(.gray)
                .font(.caption)
            ZStack(alignment: .trailing) {
                Group {
                            SecureField(placeholder, text: $fieldValue)
                    }
                }
                .font(.caption2)
                .textFieldStyle(.roundedBorder)
        }
        .padding(.bottom)
    }
}

#Preview {
    InputFieldView(title: "Full name",
                   placeholder: "Ivanov Ivan",
                   fieldValue:  Binding(
                    get: { "" },
                    set: { _ in }
                ))
}
