//
//  HelpProfileRectangleMorning.swift
//  DreamControlApp
//
//  Created by Ainur on 01.10.2024.
//

import SwiftUI

struct HelpProfileRectangleMorning: View {
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color("SuccessColor"))
                .frame(height: 200)
                .cornerRadius(15)
                .shadow(radius: 15)
                .overlay (
                    ZStack {
                        Image("StarSmallImage")
                            .offset(CGSize(width: -40, height: 30))
                        Image("CloudImage")
                            .offset(CGSize(width: -140, height: -30))
                        Image("CloudImage")
                            .offset(CGSize(width: -10, height: -80))
                        Image("CloudImage")
                            .offset(CGSize(width: -150, height: 65))
                        Image("CloudImage")
                            .offset(CGSize(width: 35, height: 80))
                        Image("StarSmallImage")
                            .offset(CGSize(width: -150, height: -75))
                        Image("StarSmallImage")
                            .offset(CGSize(width: -165, height: 10))
                        Image("CloudSmallImage")
                            .offset(CGSize(width: -120, height: -60))
                        Image("StarSmallImage")
                            .offset(CGSize(width: -40, height: -80))
                        Image("StarImage")
                            .offset(CGSize(width: 140, height: -70))
                        Image("StarImage")
                            .offset(CGSize(width: -70, height: 75))
                        Image("MorningCloud")
                            .offset(CGSize(width: -100, height: 0))
                    }
                )
        }
        .padding(.horizontal)
    }
}
#Preview {
    HelpProfileRectangleMorning()
}
