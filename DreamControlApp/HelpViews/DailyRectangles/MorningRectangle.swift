//
//  MorningRectangle.swift
//  DreamControlApp
//
//  Created by Ainur on 01.10.2024.
//

import SwiftUI

struct MorningRectangle: View {
    @State var text: String
    @State var author: String
    @AppStorage("isAnimating") private var isAnimating: Bool = false
    @AppStorage("userName") private var savedName: String = ""

    var body: some View {
        VStack {
            VStack {
                HelpProfileRectangleMorning(isAnimating: $isAnimating)
                    .overlay (
                        HStack {
                            Spacer()
                            VStack {
                                Text("Привет, \(savedName)!")
                                    .font(.custom("MontserratAlternates-Regular", size: 22))                                    .foregroundColor(.white)
                                    .bold()
                                    .offset(CGSize(width: 70, height: 10))
                                Rectangle() // нужно придумать, чтобы белый расширялся в зависмости от размера текста
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                                    .frame(width: 200, height: 70)
                                    .offset(CGSize(width: 70, height: 10))
                                    .overlay(
                                        Text(text)
                                            .font(.custom("MontserratAlternates-Regular", size: 16))
                                            .gradientForeground(colors: [Color("Prem1"),Color("Prem2"),Color("Prem3")])
                                            .multilineTextAlignment(.center)
                                            .offset(CGSize(width: 70, height: 10))
                                    )
                                HStack {
                                    Spacer()
                                    Text(author)
                                        .font(.custom("MontserratAlternates-Regular", size: 22))                                        .foregroundColor(.white)
                                        .bold()
                                        .offset(CGSize(width: -25, height: 10))
                                }
                            }
                        }
                    )
            }
        }
    }
}

#Preview {
    MorningRectangle(text: "“Перед тем как мстить, вырой две могилы”", author: "")
}
