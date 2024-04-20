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
            .shadow(radius: 30, y: -4)
            .overlay(
                VStack(alignment: .leading, spacing: 10){
                    Image(image)
                    Text(title)
                        .bold()
                        .foregroundColor(Color("TextColor"))
                    Text(text)
                        .foregroundColor(Color("TextColor"))
                }
            )
    }
}

#Preview {
    OtherViewsRectangle(image: "", title: "Ваши мечты", text: "Пусть ваша звезда всегда горит ярко")
}
