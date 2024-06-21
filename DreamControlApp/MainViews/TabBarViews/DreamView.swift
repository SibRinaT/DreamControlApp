//
//  DreamView.swift
//  DreamControlApp
//
//  Created by Ainur on 16.06.2024.
//

import SwiftUI

struct DreamView: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image("DCIcon")
                    Text("Мечтания")
                        .font(.largeTitle)
                        .foregroundColor(Color("PrimaryColor"))
                        .bold()
                    Spacer()
                }
                
                ScrollView {
                    Button(action: {}, label: {
                        Rectangle()
                            .foregroundColor(.clear) // Прозрачный фон
                            .frame(height: 85)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(
                                                      style: StrokeStyle(
                                                          lineWidth: 2,
                                                          dash: [15] // Длина штрихов и пробелов в пунктирной линии
                                                      )
                                                  )
                                    .foregroundColor(Color("PrimaryColor")) // Цвет обводки
                            )
                            .overlay(
                                Text("Добавить мечту")
                                    .foregroundColor(Color("PrimaryColor"))
                                    .font(.largeTitle)
                                    .bold()
                            )
                    })
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    DreamView()
}
