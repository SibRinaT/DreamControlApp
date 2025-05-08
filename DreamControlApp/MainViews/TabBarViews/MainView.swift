//
//  MainView.swift
//  DreamControlApp
//
//  Created by Ainur on 18.04.2024.
//

import SwiftUI

@MainActor
struct MainView: View {
    @Binding var selectedTab: Int // Передаем привязку состояния активной вкладки
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
            DreamsCountView(isAnimating: $isAnimating, selectedTab: $selectedTab)

            VStack {
                HStack {
                    OtherViewsRectangle(
                        image: "StarIcon",
                        title: "Ваши мечты",
                        text: "Пусть ваша звезда всегда горит ярко"
                    ) {
                        selectedTab = 1 // Переход на вкладку "Мечты"
                    }
                    .padding(.horizontal)

                    OtherViewsRectangle(
                        image: "IdeaIcon",
                        title: "Идеи",
                        text: "Вдохновляйтесь и растите"
                    ) {
                        selectedTab = 2 // Переход на вкладку "Идеи"
                    }
                    .padding(.horizontal)
                }
                HStack {
                    NavigationLink(destination: SubscriptionView()) {
                        OtherViewsRectangleSubscription(
                            image: "SubIcon",
                            title: "Подписка",
                            text: "Позвольте себе больше"
                        )
                    }
                    .padding(.horizontal)

                    OtherViewsRectangle(
                        image: "IconSettings",
                        title: "Воспоминания",
                        text: "Настройся на нужный лад"
                    ) {
                        selectedTab = 4 // Переход на вкладку "Воспоминания"
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


//#Preview {
//    MainView()
//        .environmentObject(IdeasViewModel()) 
//}
