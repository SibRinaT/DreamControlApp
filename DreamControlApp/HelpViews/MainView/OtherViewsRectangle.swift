//
//  Щеору.swift
//  DreamControlApp
//
//  Created by Ainur on 20.04.2024.
//

import SwiftUI

struct OtherViewsRectangle: View {
    @State var image: String
    @State var title: String
    @State var text: String

    var body: some View {
        Rectangle()
            .foregroundColor(.white)
            .cornerRadius(15)
            .frame(width: 159, height: 130)
            .shadow(radius: 10, y: -4)
            .overlay(
                HStack {
                    VStack(alignment: .leading, spacing: 5){
                        Image(image)
                        Text(title)
                            .font(Font.custom("Название вашего шрифта", size: 14).bold())
                            .foregroundColor(Color("TextColor"))
                            .bold()
                        Text(text)
                            .foregroundColor(Color("TextColor"))
                            .font(.custom("", size: 12))
                            .multilineTextAlignment(.leading)
                    }
                   Spacer()
                }
                    .padding(.horizontal)
                    .padding(.vertical)
            )
    }
}

#Preview {
    OtherViewsRectangle(image: "IdeaIcon", title: "Ваши мечты", text: "Пусть ваша звезда всегда горит ярко")
}
