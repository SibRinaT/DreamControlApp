//
//  SubscriptionButton.swift
//  DreamControlApp
//
//  Created by Ainur on 21.06.2024.
//

import SwiftUI

struct SubscriptionButton: View {
    var body: some View {
        VStack {
            Button(action: {}, label: {
                Rectangle()
                    .gradientForeground(colors: [Color("Prem1"),Color("Prem2"),Color("Prem3")])
                    .frame(height: 85)
                    .cornerRadius(20)
                    .overlay(
                        ZStack {
                            Image("StarImage")
                                .offset(CGSize(width: -100, height: 20))
                            Image("StarSmallImage")
                                .offset(CGSize(width: -5, height: -30))
                            Image("StarSmallImage")
                                .offset(CGSize(width: 110, height: -28))
                            Image("StarSmallImage")
                                .offset(CGSize(width: 50, height: 30))
                            HStack {
                                Image("PremIcon")
                                Spacer()
                                Text("Оформите подписку для добавления большего количества мечтаний")
                                    .lineSpacing(-10) // Уменьшение расстояния между строками
                                    .multilineTextAlignment(.leading)
                                    .bold()
                                    .foregroundColor(Color(.white))
                                    .font(.subheadline)
                            }
                            .padding(.horizontal)
                        }
                    )
            }
                   )
        }
        .padding(.horizontal, 30)
    }
}

#Preview {
    SubscriptionButton()
}
