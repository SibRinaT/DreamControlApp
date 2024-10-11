//
//  MainDayRectangle.swift
//  DreamControlApp
//
//  Created by Ainur on 28.09.2024.
//

import SwiftUI

struct DayRectangle: View {
    @State var text: String

    var body: some View {
        VStack {
            VStack {
                HelpProfileRectangleDay()
                    .overlay (
                        HStack {
                            Spacer()
                            VStack {
                                Text("Привет Айнур")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .bold()
                                    .offset(CGSize(width: 70, height: 10))
                                Rectangle()
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                                    .frame(width: 200, height: 70)
                                    .offset(CGSize(width: 70, height: 10))
                                    .overlay(
                                        Text(text)
                                            .gradientForeground(colors: [Color("Prem1"),Color("Prem2"),Color("Prem3")])
                                            .multilineTextAlignment(.center)
                                            .offset(CGSize(width: 70, height: 10))
                                    )
                                HStack {
                                    Spacer()
                                    Text("Гипократ")
                                        .font(.title2)
                                        .foregroundColor(.white)
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
    DayRectangle(text: "”Все имеет свою красоту, но не каждый ее видит”")
}

// code for text autoSize 
//GeometryReader { geometry in
//                                  Rectangle()
//                                      .foregroundColor(.white)
//                                      .cornerRadius(15)
//                                      .frame(width: 200, height: geometry.size.height)
//                                      .offset(CGSize(width: 70, height: 10))
//                                      .overlay(
//                                          Text(text)
//                                              .gradientForeground(colors: [Color("Prem1"), Color("Prem2"), Color("Prem3")])
//                                              .multilineTextAlignment(.center)
//                                              .padding()
//                                      )
//                              }
//                              .frame(width: 200)
