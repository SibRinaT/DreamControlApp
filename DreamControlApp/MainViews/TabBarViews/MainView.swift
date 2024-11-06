//
//  MainView.swift
//  DreamControlApp
//
//  Created by Ainur on 18.04.2024.
//

import SwiftUI

@MainActor
struct MainView: View {
    @State private var currentHour: Int = Calendar.current.component(.hour, from: Date())
    @State private var randomQuote: DailyRectangle?

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    if currentHour >= 6 && currentHour < 12 {
                                      MorningRectangle(text: randomQuote?.text ?? "Доброе утро!", author: randomQuote?.authorText ?? "DC")
                                  } else if currentHour >= 12 && currentHour < 18 {
                                      DayRectangle(text: randomQuote?.text ?? "Добрый день!", author: randomQuote?.authorText ?? "DC")
                                  } else {
                                      EveningRectangle(text: randomQuote?.text ?? "Добрый вечер!", author: randomQuote?.authorText ?? "DC")
                                  }
                }
                .onAppear {
                    randomQuote = quotes.randomElement()
                    updateTime()
                }
                DreamsCountView()
                
                VStack {
                    HStack {
                        NavigationLink(destination: DreamView())
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
                                    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
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
        .navigationBarBackButtonHidden(true)
    }
    func updateTime() {
          let now = Date()
          currentHour = Calendar.current.component(.hour, from: now)
      }
}


#Preview {
    MainView()
}
