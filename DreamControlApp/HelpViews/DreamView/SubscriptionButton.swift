//
//  SubscriptionButton.swift
//  DreamControlApp
//
//  Created by Ainur on 21.06.2024.
//

import SwiftUI

struct SubscriptionButton: View {
    @State var text: String
    @State private var isSubscriptionViewPresented = false

    var body: some View {
        VStack {
            Button(action: {
                isSubscriptionViewPresented = true
            }, label: {
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
                                Text("Оформите подписку для добавления большего количества " + text)
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
            .sheet(isPresented: $isSubscriptionViewPresented) {
                SubscriptionView(user: .constant(User(id: "123", name: "John Doe", isAdmin: false)))
            }
        }
    }
}

#Preview {
    SubscriptionButton(text: "мечтаний")
}
