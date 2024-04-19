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
                                .font(.title2)
                                .foregroundColor(.white)
                                .bold()
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(15)
                                .frame(height: 70)
                                .overlay(
                                    Text("”Все имеет свою красоту, но не каждый ее видит”")
                                )
                            Text("sfgsfgsfg")
                        }
                        .padding(.horizontal)
                    }
                    )
        }
        .padding(.horizontal)
    }
}

#Preview {
    MainView()
}
