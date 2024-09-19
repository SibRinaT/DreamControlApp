//
//  StoryTextView.swift
//  DreamControlApp
//
//  Created by Ainur on 18.09.2024.
//

import SwiftUI

struct StoryTextView: View {
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color("PrimaryColor"))
                .frame(height: 100)
                .overlay(
                    HStack {
                        Image("CloudForDream")
                        VStack {
                            Text("Мечта")
                                .foregroundColor(Color("InactiveColor2"))
                                .bold()
                                .font(.headline)
                            
                            Text("dream.name") // change need
                                .foregroundColor(.white)
                                .bold()
                                .font(.title)
                        }
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                    }
                )
            RoundedRectangle(cornerRadius: 20)
                .shadow(radius: 10)
                .foregroundColor(.white)
                    .overlay(
                        Text("История вашей мечты")
                            .font(.title)
                            .bold()
                    )
                    .padding(.horizontal)
        }
    }
}

#Preview {
    StoryTextView()
}
