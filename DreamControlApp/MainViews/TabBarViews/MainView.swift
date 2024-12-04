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
    @State private var randomQuote: DailyRectangle = quotes.randomElement()!
    @AppStorage("isAnimating") private var isAnimating: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                if currentHour >= 6 && currentHour < 12 {
                    MorningRectangle(text: randomQuote.text, author: randomQuote.authorText)
                } else if currentHour >= 12 && currentHour < 17 {
                    DayRectangle(text: randomQuote.text, author: randomQuote.authorText)
                } else {
                    EveningRectangle(text: randomQuote.text, author: randomQuote.authorText)
                }
            }
            .onAppear {
                updateRandomQuote()
                updateTime()
            }
            DreamsCountView(isAnimating: $isAnimating)
            
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
                            OtherViewsRectangleSubscription(image: "SubIcon", title: "Подписка", text: "Позвольте себе больше")
                        }
                    }
                    .padding(.horizontal)
                    NavigationLink(destination: SettingsView()) {
                        OtherViewsRectangle(image: "IconSettings", title: "Настройки", text: "Настройся на нужный лад")
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    func updateTime() {
          let now = Date()
          currentHour = Calendar.current.component(.hour, from: now)
      }
    private func updateRandomQuote() {
        randomQuote = quotes.randomElement()!
    }
}


#Preview {
    MainView()
        .environmentObject(IdeasViewModel()) 
}
