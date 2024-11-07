//
//  HellpProfile.swift
//  DreamControlApp
//
//  Created by Ainur on 20.04.2024.
//

import SwiftUI

struct HelpProfileRectangleDay: View {
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color("PrimaryColor"))
                .frame(height: 200)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                .overlay (
                    ZStack {
                        Image("CloudSmallImage")
                            .offset(CGSize(width: -150, height: -75))
                        Image("CloudImage")
                            .offset(CGSize(width: -140, height: -30))
                        Image("CloudImage")
                            .offset(CGSize(width: -50, height: -45))
                        Image("CloudImage")
                            .offset(CGSize(width: -150, height: 65))
                        Image("CloudImage")
                            .offset(CGSize(width: -30, height: 60))
                        Image("StarSmallImage")
                            .offset(CGSize(width: -40, height: 30))
                        Image("StarSmallImage")
                            .offset(CGSize(width: -165, height: 10))
                        Image("StarSmallImage")
                            .offset(CGSize(width: -120, height: -60))
                        Image("StarSmallImage")
                            .offset(CGSize(width: -40, height: -80))
                        Image("StarImage")
                            .offset(CGSize(width: 140, height: -70))
                        Image("IllustrationHome")
                            .offset(CGSize(width: -100, height: 0))
                    }
                )
        }
        .padding(.horizontal)
    }
}

#Preview {
    HelpProfileRectangleDay()
}
