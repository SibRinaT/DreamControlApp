//
//  HelpProfileRectangleEvening.swift
//  DreamControlApp
//
//  Created by Ainur on 01.10.2024.
//

import SwiftUI

struct HelpProfileRectangleEvening: View {
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color("SecondaryColor"))
                .frame(height: 200)
                .cornerRadius(15)
                .shadow(radius: 15)
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
                            .offset(CGSize(width: -30, height: 55))
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
                        Image("StarImage")
                            .offset(CGSize(width: 50, height: 80))
                        Image("IllustrationHome")
                            .offset(CGSize(width: -100, height: 0))
                    }
                )
        }
        .padding(.horizontal)
    }
}

#Preview {
    HelpProfileRectangleEvening()
}
