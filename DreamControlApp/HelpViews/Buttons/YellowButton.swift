//
//  YellowButton.swift
//  DreamControlApp
//
//  Created by Ainur on 02.04.2024.
//

import SwiftUI

struct YellowButton: View {
    @State var  isActive: Bool
    let text: String
    var body: some View {
        if isActive {
            Rectangle()
                .foregroundColor(Color("PrimaryColor"))
                .frame(width: 302 ,height: 40)
                .cornerRadius(25)
                .overlay(
                    Text(text)
                        .bold()
                        .foregroundColor(Color(.white))
                )
        } else {
            Rectangle()
                .foregroundColor(Color("InactiveColor"))
                .frame(width: 302 ,height: 40)
                .cornerRadius(25)
                .overlay(
                    Text(text)
                        .bold()
                        .foregroundColor(Color("InactiveColor2"))
                )
        }
        
    }
}

#Preview {
    YellowButton(isActive: false, text: "Войти")
}
