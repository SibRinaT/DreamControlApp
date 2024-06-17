//
//  SubscriptionView.swift
//  DreamControlApp
//
//  Created by Ainur on 17.06.2024.
//

import SwiftUI

struct SubscriptionView: View {
    var body: some View {
        Text("Hello, World!")
            .gradientForeground(colors: [Color("Prem1"),Color("Prem2"),Color("Prem3")])
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
