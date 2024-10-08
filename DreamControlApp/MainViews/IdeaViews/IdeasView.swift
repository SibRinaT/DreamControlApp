//
//  IdeasView.swift
//  DreamControlApp
//
//  Created by Ainur on 20.06.2024.
//

import SwiftUI

struct IdeasView: View {
    @State var idea: String
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 250)
                .foregroundColor(.white)
                .shadow(radius: 10)
                .overlay(
                    VStack {
                        Text(idea)
                            .bold()
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                    )
                .padding(.bottom, 30)
            Button(action: {}) {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 100)
                    .foregroundColor(Color("PrimaryColor"))
                    .shadow(radius: 10)
                    .overlay(
                        Text("Генерерировать")
                            .bold()
                            .font(.title2)
                            .foregroundColor(.black)
                    )
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    IdeasView(idea: "Выучить новый язык")
}
