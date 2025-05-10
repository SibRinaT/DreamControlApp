//
//  CategoryRowView.swift
//  DreamControlApp
//
//  Created by Ainur on 06.05.2025.
//

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
                            .font(.custom("MontserratAlternates-Regular", size: 14))
                            .bold()
                        Spacer()
                        Image(isSelected ? "whiteLamp" : "unactiveLamp")
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
