//
//  MainView.swift
//  DreamControlApp
//
//  Created by Ainur on 18.04.2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color("PrimaryColor"))
                .frame(height: 200)
                .cornerRadius(15)
                .overlay (
                    HStack {
                        Image("IllustrationHome")
                        VStack {
                            Text("Привет Айнур")
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
                            Text("Гипократ")
                                .font(.title2)
                                .foregroundColor(.white)
                                .bold()
                        }
                        .padding(.horizontal)
                    }
                    )
            HStack {
                Rectangle()
                    .frame(height: 60)
                    .foregroundColor(Color("PrimaryColor"))
                    .cornerRadius(10)
                    .overlay(
                        VStack {
                            Text("3") //mock
                                .bold()
                                .font(.title)
                                .foregroundColor(.white)
                            Text("Мечт")
                                .bold()
                                .font(.title)
                                .foregroundColor(.white)
                        }
                            .padding(.vertical)
                    )
                    .padding(.vertical, 20)
                Rectangle()
                    .frame(height: 60)
                    .foregroundColor(Color("SuccessColor"))
                    .cornerRadius(10)
                    .overlay(
                        VStack {
                            Text("14") //mock
                                .bold()
                                .font(.title)
                                .foregroundColor(.white)
                            Text("Идей")
                                .bold()
                                .font(.title)
                                .foregroundColor(.white)
                        }
                            .padding(.vertical)
                    )
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    MainView()
}
