//
//  MainView.swift
//  DreamControlApp
//
//  Created by Ainur on 18.04.2024.
//

import SwiftUI

struct MainView: View {
    @State private var currentHour: Int = Calendar.current.component(.hour, from: Date())

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    if currentHour >= 6 && currentHour < 12 {
                        MorningRectangle(text: "”Все имеет свою красоту, но не каждый ее видит”")
                    } else if currentHour >= 12 && currentHour < 18 {
                        DayRectangle(text: "”Все имеет свою красоту, но не каждый ее видит”")
                    } else {
                        EveningRectangle(text: "”Все имеет свою красоту, но не каждый ее видит”")
                    }
                }
                .onAppear {
                        // Обновляем часы каждый раз, когда отображается ContentView
                        updateTime()
                    }
                DreamsCountView()
                
                VStack {
                    HStack {
                        NavigationLink(destination: DreamView().environment(StoriesService()))
                        {
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
    func updateTime() {
          let now = Date()
          currentHour = Calendar.current.component(.hour, from: now)
      }
}


#Preview {
    MainView()
}
