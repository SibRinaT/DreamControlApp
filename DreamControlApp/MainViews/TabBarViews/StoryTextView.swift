//
//  StoryTextView.swift
//  DreamControlApp
//
//  Created by Ainur on 18.09.2024.
//

import SwiftUI

struct StoryTextView: View {
    @State private var storyContent: String = ""

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
                        ScrollView {
                            VStack {
                                Text("История вашей мечты")
                                    .font(.title)
                                    .padding(.top, 30)
                                    .padding(.bottom)
                                ZStack {
                                    Group {
                                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                                            .stroke(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [Color("Prem1"), Color("Prem2"), Color("Prem3")]),
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                ),
                                                lineWidth: 3
                                            )
                                            .background(Color.clear) // Прозрачный фон
                                            .frame(width: 300, height: 400) // Размеры прямоугольник
                                        TextField("Напишите историю успеха", text: $storyContent, axis: .vertical)
                                            .padding(.horizontal)
                                    }
                                    .padding(.horizontal, 100)
                                }
                            }
                        }
                    )
                    .padding(.horizontal)
        }
    }
}

#Preview {
    StoryTextView()
}
