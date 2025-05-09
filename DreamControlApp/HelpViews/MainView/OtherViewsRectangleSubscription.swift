//
//  Щеору.swift
//  DreamControlApp
//
//  Created by Ainur on 20.04.2024.
//

import SwiftUI

struct OtherViewsRectangleSubscription: View {
    @State var image: String
    @State var title: String
    @State var text: String
    
    var body: some View {
        Rectangle()
            .foregroundColor(.white)
            .cornerRadius(15)
            .frame(width: 159, height: 130)
            .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
            .overlay(
                HStack {
                    VStack(alignment: .leading, spacing: 5){
                        Image("SubIcon")
                        Text("Подписка")
                            .bold()
                            .font(.custom("MontserratAlternates-Regular", size: 14))
                            .gradientForeground(colors: [Color("Prem1"),Color("Prem2"),Color("Prem3")])
                        Text("Позвольте себе больше")
                            .foregroundColor(Color("TextColor"))
                            .font(.custom("MontserratAlternates-Regular", size: 12))
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                }
                    .padding(.horizontal)
                    .padding(.vertical)
            )
    }
}

//#Preview {
//    OtherViewsRectangle(image: "IdeaIcon", title: "Ваши мечты", text: "Пусть ваша звезда всегда горит ярко")
//}
