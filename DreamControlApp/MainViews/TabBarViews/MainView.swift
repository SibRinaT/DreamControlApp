//
//  MainView.swift
//  DreamControlApp
//
//  Created by Ainur on 18.04.2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack {
                Rectangle()
                    .foregroundColor(Color("PrimaryColor"))
                    .frame(height: 200)
                    .cornerRadius(15)
                    .shadow(radius: 20)
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
                    .padding(.horizontal)
               DreamsCountView()
                
                VStack {
                    HStack {
                        NavigationLink(destination: DreamView()) {
                            OtherViewsRectangle(image: "StarIcon", title: "Ваши мечты", text: "Пусть ваша звезда всегда горит ярко")
                        }
                            .padding(.horizontal)
                        OtherViewsRectangle(image: "IdeaIcon", title: "Идеи", text: "Вдохновляйтесь и растите")
                            .padding(.horizontal)
                    }
                    HStack {
                        OtherViewsRectangle(image: "SubIcon", title: "Подписка", text: "Позвольте себе большее!")
                            .padding(.horizontal)
                        OtherViewsRectangle(image: "SettingIcon", title: "Настройки", text: "Настройся на нужный лад")
                            .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    MainView()
}
