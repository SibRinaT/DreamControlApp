//
//  HellpProfile.swift
//  DreamControlApp
//
//  Created by Ainur on 20.04.2024.
//

import SwiftUI

struct HelpProfileRectangle: View {
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color("PrimaryColor"))
                .frame(height: 200)
                .cornerRadius(15)
                .overlay (
                        HStack {
                            ZStack {
                                
                            }
                            Image("IllustrationHome")
                            VStack {
                                VStack {
                                    Text("Привет Айнур!")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .bold()
                                    Rectangle()
                                        .foregroundColor(.white)
                                        .cornerRadius(15)
                                        .frame(height: 70)
                                        .overlay(
                                            Text("”Все имеет свою красоту, но не каждый ее видит”")
                                        )
                                    Text("КонФуЦий")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                        .bold()
                                }
                            }
                            .padding(.horizontal)
                        }
                )
        }
        .padding(.horizontal)
    }
}

#Preview {
    HelpProfileRectangle()
}
