//
//  DreamsCountView.swift
//  DreamControlApp
//
//  Created by Ainur on 19.06.2024.
//

import SwiftUI

struct DreamsCountView: View {
    var body: some View {
        HStack {
            ZStack {
                Color.red
                Rectangle()
                    .frame(height: 60)
                    .foregroundColor(Color("PrimaryColor"))
                    .cornerRadius(10)
                    .overlay(
                        VStack {
                            Text("3") //mock
                                .bold()
                                .font(.title2)
                                .foregroundColor(.white)
                            Text("Мечты")
                                .bold()
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                            .padding(.vertical)
                    )
                    .padding(.vertical, 20)
                    .padding(.horizontal)
            }
            ZStack {
                Color.blue
                Rectangle()
                    .frame(height: 60)
                    .foregroundColor(Color("PrimaryColor"))
                    .cornerRadius(10)
                    .overlay(
                        VStack {
                            Text("3") //mock
                                .bold()
                                .font(.title2)
                                .foregroundColor(.white)
                            Text("Мечты")
                                .bold()
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                            .padding(.vertical)
                    )
                    .padding(.vertical, 20)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    DreamsCountView()
}
