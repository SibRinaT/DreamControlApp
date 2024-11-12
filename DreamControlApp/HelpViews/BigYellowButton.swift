//
//  BigYellowButton.swift
//  DreamControlApp
//
//  Created by Ainur on 12.11.2024.
//

import SwiftUI

struct BigYellowButton: View {
    @State var title: String
    @State var image: String

    var body: some View {
        Button(action: {
        }) {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color("PrimaryColor")) // Прозрачный фон
                .frame(height: 85)
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
                .overlay (
                    HStack {
                        Image(image)
                            .padding()
                        Text(title)
                            .bold()
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding()
                    }
                )
        }
    }
}

#Preview {
    BigYellowButton(title: "Виджеты", image: "StoryIcon")
}
