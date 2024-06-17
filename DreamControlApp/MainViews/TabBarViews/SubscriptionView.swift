//
//  SubscriptionView.swift
//  DreamControlApp
//
//  Created by Ainur on 17.06.2024.
//

import SwiftUI

struct SubscriptionView: View {
    var body: some View {
        VStack {
            Text("Подписка")
                .gradientForeground(colors: [Color("Prem1"),Color("Prem2"),Color("Prem3")])
                .font(.system(size: 63))
                .bold()
            
            Button(action: {}) {
                Rectangle()
                    .gradientForeground(colors: [Color("Prem1"),Color("Prem2"),Color("Prem3")])
                    .frame(height: 80)
                    .cornerRadius(100)
                    .overlay(
                        Text("Попробовать")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .bold()
                    )
            }
        }
        .padding(.horizontal, 33)
    }
}

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(
            LinearGradient(
                colors: colors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
        )
            .mask(self)
    }
}

#Preview {
    SubscriptionView()
}
