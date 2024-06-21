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
                        HStack {
                            Image("PremIcon")
                            Spacer()
                            Text("Оформите подписку для добавления большего количества мечтаний")
                                .multilineTextAlignment(.leading)
                                .bold()
                                .foregroundColor(Color(.white))
                                .font(.callout)
                        }
                            .padding(.horizontal)
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
