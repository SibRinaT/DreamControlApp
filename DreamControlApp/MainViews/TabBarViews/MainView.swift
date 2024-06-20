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
                HelpProfileRectangle()
                    .overlay (
                        HStack {
                            Spacer()
                            VStack {
                                Text("Привет Айнур")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .bold()
                                    .offset(CGSize(width: 70, height: 10))
                                Rectangle()
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                                    .frame(width: 200, height: 70)
                                    .offset(CGSize(width: 70, height: 10))
                                    .overlay(
                                        Text("”Все имеет свою красоту, но не каждый ее видит”")
                                            .gradientForeground(colors: [Color("Prem1"),Color("Prem2"),Color("Prem3")])
                                            .multilineTextAlignment(.center)
                                            .offset(CGSize(width: 70, height: 10))
                                    )
                                HStack {
                                    Spacer()
                                    Text("Гипократ")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                        .bold()
                                        .offset(CGSize(width: -25, height: 10))
                                }
                            }
                        }
                    )
               DreamsCountView()
                
                VStack {
                    HStack {
                        NavigationLink(destination: DreamView()) {
                            OtherViewsRectangle(image: "StarIcon", title: "Ваши мечты", text: "Пусть ваша звезда всегда горит ярко")
                        }
                            .padding(.horizontal)
                        NavigationLink(destination: IdeasView()) {
                            OtherViewsRectangle(image: "IdeaIcon", title: "Идеи", text: "Вдохновляйтесь и растите")
                        }
                            .padding(.horizontal)
                    }
                    HStack {
                        NavigationLink(destination: SubscriptionView()) {
                            OtherViewsRectangle(image: "SubIcon", title: "Подписка", text: "Позвольте себе большее!")
                        }
                        .padding(.horizontal)
                        NavigationLink(destination: SettingsView()) {
                            OtherViewsRectangle(image: "SettingIcon", title: "Настройки", text: "Настройся на нужный лад")
                        }
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
