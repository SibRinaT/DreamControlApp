//
//  Model.swift
//  DreamControlApp
//
//  Created by Ainur on 04.09.2024.
//

import SwiftUI
import UIKit


struct DreamStory: Codable, Identifiable {
    let id: UUID
    let title: String
    let content: String
}

struct Dream: Codable, Identifiable {
    let id: UUID
    let name: String
    let image: String
    var stories: [DreamStory]
}

struct User: Codable {
    let id: String
    let name: String
    let isAdmin: Bool
    private(set) var isSubscriptionEnabled: Bool
    
    mutating func enableSubscription() {
        isSubscriptionEnabled = true
    }
    
    init(id: String, name: String, isAdmin: Bool) {
        self.id = id
        self.name = name
        self.isAdmin = isAdmin
        self.isSubscriptionEnabled = false
    }
}
struct DailyRectangle: Codable, Identifiable {
    let id: UUID = UUID()
    let text: String
    let authorText: String?
}

let quotes: [DailyRectangle] = [
    DailyRectangle(text: "Все, что ты можешь вообразить, реально.", authorText: "Пабло Пикассо"),
    DailyRectangle(text: "Следуй за мечтой — шаг за шагом.", authorText: "Бэн Стайн"),
    DailyRectangle(text: "Живи так, как мечтаешь.", authorText: "Альберт Эйнштейн"),
    DailyRectangle(text: "Не мечтай о жизни, живи мечтой.", authorText: "Джеймс Дин"),
    DailyRectangle(text: "Вдохновение всегда с тобой.", authorText: "Стив Джобс"),
    DailyRectangle(text: "Мечты — это карта твоего будущего.", authorText: "Опра Уинфри"),
    DailyRectangle(text: "Больше мечтай — дальше идешь.", authorText: "Майкл Джордан"),
    DailyRectangle(text: "Идти вперед — вот истинная мечта.", authorText: "Эмили Дикинсон"),
    DailyRectangle(text: "Ты создаешь свой мир.", authorText: "Аньес де Милль"),
    DailyRectangle(text: "Не жди чуда — создай его.", authorText: "Эллен Глассгоу"),
    DailyRectangle(text: "Мечта — это начало пути.", authorText: "Генри Форд"),
    DailyRectangle(text: "Нет границ для мечты.", authorText: "Эллен Джонсон Сирлиф"),
    DailyRectangle(text: "Мечта — это сила жизни.", authorText: "Лев Толстой"),
    DailyRectangle(text: "Ты живешь, чтобы мечтать.", authorText: "Джон Леннон"),
    DailyRectangle(text: "Не мечтай бездействовать.", authorText: "Джоан Риверс"),
    DailyRectangle(text: "Жизнь без мечты пуста.", authorText: "Лоуренс Даррелл"),
    DailyRectangle(text: "Ты можешь все, если веришь.", authorText: "Авраам Линкольн"),
    DailyRectangle(text: "Будь храбр, следуй за мечтой.", authorText: "Ханс Кристиан Андерсен"),
    DailyRectangle(text: "Мечты ведут к истине.", authorText: "Фридрих Ницше"),
    DailyRectangle(text: "Полет мечты вечен.", authorText: "Стивен Кинг"),
    DailyRectangle(text: "Будь мечтой своей жизни.", authorText: "Ф. М. Достоевский"),
    DailyRectangle(text: "Все начинается с мечты.", authorText: "Брайан Трейси"),
    DailyRectangle(text: "Действуй ради мечты.", authorText: "Томас Эдисон"),
    DailyRectangle(text: "Мечта не имеет границ.", authorText: "Мартин Лютер Кинг"),
    DailyRectangle(text: "Живи своей мечтой.", authorText: "Ральф Уолдо Эмерсон"),
    DailyRectangle(text: "Мечта — это сила духа.", authorText: "Ганс Селье"),
    DailyRectangle(text: "Верь в мечту, она вернется к тебе.", authorText: "Махатма Ганди"),
    DailyRectangle(text: "Начни с мечты.", authorText: "Наполеон Хилл"),
    DailyRectangle(text: "Ты можешь создать реальность.", authorText: "Джоан Роулинг"),
    DailyRectangle(text: "Твоя мечта — твой путь.", authorText: "Роберт Фрост"),
    DailyRectangle(text: "Мечты движут нами.", authorText: "Даниэль Дефо"),
    DailyRectangle(text: "Ты — создатель своей судьбы.", authorText: "Уильям Шекспир"),
    DailyRectangle(text: "Твоя мечта — твой шанс.", authorText: "Конфуций"),
    DailyRectangle(text: "Мечты дают крылья.", authorText: "Хелен Келлер"),
    DailyRectangle(text: "Только ты знаешь свой путь.", authorText: "Вирджиния Вулф"),
    DailyRectangle(text: "Будь тем, кем мечтаешь.", authorText: "П. Б. Шелли"),
    DailyRectangle(text: "Мечтай смело.", authorText: "Альберт Камю"),
    DailyRectangle(text: "Следуй за светом мечты.", authorText: "Леонардо да Винчи"),
    DailyRectangle(text: "Будь мечтой своей жизни.", authorText: "Руми"),
    DailyRectangle(text: "Создавай, как мечтаешь.", authorText: "Уолт Дисней"),
    DailyRectangle(text: "Мечты ведут к жизни.", authorText: "Франц Кафка"),
    DailyRectangle(text: "Живи вдохновенно.", authorText: "Пабло Неруда"),
    DailyRectangle(text: "Мечта — это цель души.", authorText: "Ницше"),
    DailyRectangle(text: "Дерзай мечтать!", authorText: "Оскар Уайльд"),
    DailyRectangle(text: "Реальность — это мечта.", authorText: "Уильям Блейк"),
    DailyRectangle(text: "Верь в свою мечту.", authorText: "Хелен Келлер"),
    DailyRectangle(text: "Будь светом мечты.", authorText: "Боб Дилан"),
    DailyRectangle(text: "Создавай мечту.", authorText: "Маяковский"),
    DailyRectangle(text: "Ты — твоя мечта.", authorText: "Харуки Мураками"),
    DailyRectangle(text: "Мечта движет нами.", authorText: "Марк Твен"),
    DailyRectangle(text: "Иди вперед за мечтой.", authorText: "Энн Брэдстрит"),
    DailyRectangle(text: "Твори, что мечтаешь.", authorText: "Уильям Шекспир"),
    DailyRectangle(text: "Начни с мечты.", authorText: "Элеонор Рузвельт"),
    DailyRectangle(text: "Живи тем, что любишь.", authorText: "Антуан де Сент-Экзюпери"),
    DailyRectangle(text: "Ищи свое вдохновение.", authorText: "Бетти Фридан"),
    DailyRectangle(text: "Мечты безграничны.", authorText: "Анна Ахматова"),
    DailyRectangle(text: "Пусть мечта ведет тебя.", authorText: "Генри Джеймс"),
    DailyRectangle(text: "Смелость — след мечты.", authorText: "Эрнест Хемингуэй"),
    DailyRectangle(text: "Будь мечтой.", authorText: "Карл Густав Юнг"),
    DailyRectangle(text: "Твори в мечте.", authorText: "Ван Гог"),
    DailyRectangle(text: "Мечтай, дерзай.", authorText: "Фрэнсис Фицджеральд"),
    DailyRectangle(text: "Верь в свое будущее.", authorText: "Фридрих Шиллер"),
    DailyRectangle(text: "Лети к мечте.", authorText: "Лев Толстой"),
    DailyRectangle(text: "Твоя мечта — твое будущее.", authorText: "Платон"),
    DailyRectangle(text: "Живи для мечты.", authorText: "Фаулз"),
    DailyRectangle(text: "Пусть мечта вдохновляет.", authorText: "Пастернак"),
    DailyRectangle(text: "Ты создатель мечты.", authorText: "Жорж Санд"),
    DailyRectangle(text: "Мечтай ярко.", authorText: "Сократ"),
    DailyRectangle(text: "Ты — свет своей мечты.", authorText: "Овидий"),
    DailyRectangle(text: "Твори мечту.", authorText: "Рэй Брэдбери"),
    DailyRectangle(text: "Мечта — это путь.", authorText: "Сервантес"),
    DailyRectangle(text: "Твоя жизнь — твоя мечта.", authorText: "Жан-Поль Сартр"),
    DailyRectangle(text: "Твой путь — твоя мечта.", authorText: "Пушкин"),
    DailyRectangle(text: "Живи для мечты.", authorText: "Камю"),
    DailyRectangle(text: "Свет мечты — в тебе.", authorText: "Уитмен"),
    DailyRectangle(text: "Иди за мечтой.", authorText: "Бенджамин Франклин"),
    DailyRectangle(text: "Ты — свет своей мечты.", authorText: "Конфуций"),
    DailyRectangle(text: "Твоя мечта — твой выбор.", authorText: "Руссо"),
    DailyRectangle(text: "Верь в свою силу.", authorText: "Лао-цзы"),
    DailyRectangle(text: "Ты — воплощение мечты.", authorText: "Торо"),
    DailyRectangle(text: "Живи ради мечты.", authorText: "Чарльз Диккенс"),
    DailyRectangle(text: "Свет мечты внутри тебя.", authorText: "Блейк"),
    DailyRectangle(text: "Будь собой и мечтай.", authorText: "Генри Джеймс"),
    DailyRectangle(text: "Дерзай жить.", authorText: "Руми"),
    DailyRectangle(text: "Мечты ведут к чудесам.", authorText: "Льюис Кэрролл"),
    DailyRectangle(text: "Будь своей мечтой.", authorText: "Роберт Браунинг"),
    DailyRectangle(text: "Твоя мечта — твоя жизнь.", authorText: "Гёте"),
    DailyRectangle(text: "Мечты рождают жизнь.", authorText: "Сэлинджер"),
    DailyRectangle(text: "Верь в мечту.", authorText: "Шопенгауэр"),
    DailyRectangle(text: "Ты — свет своей мечты.", authorText: "Милтон"),
    DailyRectangle(text: "Живи мечтой.", authorText: "Эмерсон"),
    DailyRectangle(text: "Твоя сила — твоя мечта.", authorText: "Торо"),
    DailyRectangle(text: "Мечты создают реальность.", authorText: "Диккенс"),
    DailyRectangle(text: "Ты — свет своей мечты.", authorText: "Гамсун"),
    DailyRectangle(text: "Твоя мечта ждет.", authorText: "Алан Уотс"),
    DailyRectangle(text: "Мечтай смело!", authorText: "Рэмбо"),
    DailyRectangle(text: "Ты — сила своей мечты.", authorText: "Тагор"),
    DailyRectangle(text: "Свет мечты — в тебе.", authorText: "Кафка"),
    DailyRectangle(text: "Живи мечтой.", authorText: "Флобер"),
    DailyRectangle(text: "Полет мечты безграничен.", authorText: "Стивен Кинг")
]
