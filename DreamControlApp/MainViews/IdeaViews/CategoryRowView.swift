//
//  CategoryRowView.swift
//  DreamControlApp
//
//  Created by Ainur on 06.05.2025.
//

import SwiftUI

import SwiftUI

struct CategoryRowView: View {
    let title: String
    let isSelected: Bool

    var body: some View {
        VStack {
            Rectangle()
                .frame(height: 65)
                .foregroundColor(Color("PrimaryColor"))
                .cornerRadius(16)
                .overlay {
                    HStack {
                        Text(title)
                            .foregroundColor(.white)
                            .bold()
                        Spacer()
                        Image(isSelected ? "whiteLamp" : "grayLamp")
                    }
                    .padding(.horizontal)
                }
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

#Preview {
    CategoryRowView(title: "Образование", isSelected: true)
}
