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
                MainDayRectangle(text: "”Все имеет свою красоту, но не каждый ее видит”")
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
                        HStack {
                            NavigationLink(destination: SubscriptionView()) {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                                    .frame(width: 159, height: 130)
                                    .shadow(radius: 10, y: -4)
                                    .overlay(
                                        HStack {
                                            VStack(alignment: .leading, spacing: 5){
                                                Image("SubIcon")
                                                Text("Подписка")
                                                    .bold()
                                                //                                                .font(Font.custom("Название вашего шрифта", size: 14).bold())
                                                    .gradientForeground(colors: [Color("Prem1"),Color("Prem2"),Color("Prem3")])
                                                Text("Позвольте себе большее")
                                                    .foregroundColor(Color("TextColor"))
                                                    .font(.custom("", size: 12))
                                                    .multilineTextAlignment(.leading)
                                            }
                                            Spacer()
                                        }
                                            .padding(.horizontal)
                                            .padding(.vertical)
                                    )
                            }
                        }
                        .padding(.horizontal)
                        NavigationLink(destination: SettingsView()) {
                            OtherViewsRectangle(image: "SettingIcon", title: "Настройки", text: "Настройся на нужный лад")
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                    .padding(.horizontal)
                }
            }
        }
    }
}


#Preview {
    MainView()
}
