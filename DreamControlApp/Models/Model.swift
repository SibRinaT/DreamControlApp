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
    let authorText: String
}

let quotes: [DailyRectangle] = [
    DailyRectangle(text: "Все, что ты можешь представить, уже реально", authorText: "Пабло Пикассо"),
    DailyRectangle(text: "Следуй за мечтой, даже если путь тернист", authorText: "Бэн Стайн"),
    DailyRectangle(text: "Живи мечтой, каждый день делая шаг вперед", authorText: "Альберт Эйнштейн"),
    DailyRectangle(text: "Не мечтай о будущем, твори его каждый день", authorText: "Джеймс Дин"),
    DailyRectangle(text: "Твое вдохновение — это источник силы", authorText: "Стив Джобс"),
    DailyRectangle(text: "Мечты указывают направление твоего пути", authorText: "Опра Уинфри"),
    DailyRectangle(text: "Большие мечты требуют смелых решений", authorText: "Майкл Джордан"),
    DailyRectangle(text: "Смысл жизни — в движении к мечтам", authorText: "Эмили Дикинсон"),
    DailyRectangle(text: "Ты создаешь свой мир, следуя мечтам", authorText: "Аньес де Милль"),
    DailyRectangle(text: "Не жди чуда, начни создавать его сам", authorText: "Эллен Глассгоу"),
    DailyRectangle(text: "Каждая мечта — это начало нового пути", authorText: "Генри Форд"),
    DailyRectangle(text: "Границ для мечты не существует, дерзай", authorText: "Джонсон Сирлиф"),
    DailyRectangle(text: "Мечты дают силы жить и двигаться дальше", authorText: "Лев Толстой"),
    DailyRectangle(text: "Ты живешь, чтобы воплотить свои мечты", authorText: "Джон Леннон"),
    DailyRectangle(text: "Мечтать и действовать — одно целое", authorText: "Джоан Риверс"),
    DailyRectangle(text: "Жизнь теряет смысл без мечты", authorText: "Лоуренс Даррелл"),
    DailyRectangle(text: "Ты можешь все, если веришь в свои мечты", authorText: "Авраам Линкольн"),
    DailyRectangle(text: "Смело иди за своей мечтой и не сдавайся", authorText: "Кристиан Андерсен"),
    DailyRectangle(text: "Мечты могут привести к великой истине", authorText: "Фридрих Ницше"),
    DailyRectangle(text: "Полет мечты вдохновляет нас на свершения", authorText: "Стивен Кинг"),
    DailyRectangle(text: "Будь мечтой, живи ею и вдохновляй других", authorText: "Ф. М. Достоевский"),
    DailyRectangle(text: "Все начинается с мечты и упорного труда", authorText: "Брайан Трейси"),
    DailyRectangle(text: "Действуй так, как будто мечта уже с тобой", authorText: "Томас Эдисон"),
    DailyRectangle(text: "Мечта бесконечна, как вселенная", authorText: "Мартин Лютер Кинг"),
    DailyRectangle(text: "Живи своей мечтой, не бойся падений", authorText: "Уолдо Эмерсон"),
    DailyRectangle(text: "Мечта — движущая сила для духа", authorText: "Ганс Селье"),
    DailyRectangle(text: "Мечта жива, пока в ней веришь", authorText: "Махатма Ганди"),
    DailyRectangle(text: "Каждое великое дело начинается с мечты", authorText: "Наполеон Хилл"),
    DailyRectangle(text: "Ты можешь создать любую реальность", authorText: "Джоан Роулинг"),
    DailyRectangle(text: "Пусть твоя мечта станет твоим дороговказом", authorText: "Роберт Фрост"),
    DailyRectangle(text: "Мечты движут нами вперед", authorText: "Даниэль Дефо"),
    DailyRectangle(text: "Ты создатель своей судьбы и мечты", authorText: "Уильям Шекспир"),
    DailyRectangle(text: "Твоя мечта — твоя уникальная дорога", authorText: "Конфуций"),
    DailyRectangle(text: "Мечта окрыляет, она дает силы жить", authorText: "Хелен Келлер"),
    DailyRectangle(text: "Только ты знаешь истинный путь мечты", authorText: "Вирджиния Вулф"),
    DailyRectangle(text: "Будь тем, кем мечтаешь стать", authorText: "П. Б. Шелли"),
    DailyRectangle(text: "Мечтай смело, не боясь преград", authorText: "Альберт Камю"),
    DailyRectangle(text: "Свет мечты освещает твой путь", authorText: "Леонардо да Винчи"),
    DailyRectangle(text: "Будь мечтой, живи с этим светом", authorText: "Руми"),
    DailyRectangle(text: "Твори, как подсказывает мечта", authorText: "Уолт Дисней"),
    DailyRectangle(text: "Мечта вдохновляет на великие поступки", authorText: "Франц Кафка"),
    DailyRectangle(text: "Живи, вкладывая душу в мечты", authorText: "Пабло Неруда"),
    DailyRectangle(text: "Мечта — цель для твоей души", authorText: "Ницше"),
    DailyRectangle(text: "Смелее мечтай, не бойся ничего", authorText: "Оскар Уайльд"),
    DailyRectangle(text: "Жизнь — воплощение твоей мечты", authorText: "Уильям Блейк"),
    DailyRectangle(text: "Верь в свою мечту, как веришь в себя", authorText: "Хелен Келлер"),
    DailyRectangle(text: "Пусть твоя мечта светит другим", authorText: "Боб Дилан"),
    DailyRectangle(text: "Создавай мир своей мечты", authorText: "Владимир Маяковский"),
    DailyRectangle(text: "Ты воплощение своей мечты", authorText: "Харуки Мураками"),
    DailyRectangle(text: "Мечта движет нами и создает путь", authorText: "Марк Твен"),
    DailyRectangle(text: "Иди навстречу мечте, несмотря на страх", authorText: "Энн Брэдстрит"),
    DailyRectangle(text: "Твори свою мечту каждый день", authorText: "Уильям Шекспир"),
    DailyRectangle(text: "Начни с мечты и действуй уверенно", authorText: "Элеонор Рузвельт"),
    DailyRectangle(text: "Живи тем, что искренне любишь", authorText: "Сент-Экзюпери"),
    DailyRectangle(text: "Ищи вдохновение внутри себя", authorText: "Бетти Фридан"),
    DailyRectangle(text: "Мечты не знают границ, только ты", authorText: "Анна Ахматова"),
    DailyRectangle(text: "Позволь мечте вести тебя к счастью", authorText: "Генри Джеймс"),
    DailyRectangle(text: "Смелость воплощать мечту — в тебе", authorText: "Эрнест Хемингуэй"),
    DailyRectangle(text: "Будь мечтой своей жизни, живи ею", authorText: "Густав Юнг"),
    DailyRectangle(text: "Твори мечту с уверенностью в успехе", authorText: "Ван Гог"),
    DailyRectangle(text: "Не бойся мечтать и стремись к мечте", authorText: "Фрэнсис Фицджеральд"),
    DailyRectangle(text: "Верь в свою мечту — это твое будущее", authorText: "Фридрих Шиллер"),
    DailyRectangle(text: "Лети к своей мечте, не оглядываясь", authorText: "Лев Толстой"),
    DailyRectangle(text: "Твоя мечта — твой путь и твой выбор", authorText: "Платон"),
    DailyRectangle(text: "Живи для своей мечты, не сдавайся", authorText: "Джон Фаулз"),
    DailyRectangle(text: "Пусть мечта будет твоим вдохновением", authorText: "Борис Пастернак"),
    DailyRectangle(text: "Ты создатель своей мечты и жизни", authorText: "Жорж Санд"),
    DailyRectangle(text: "Мечтай с яркостью и уверенностью", authorText: "Сократ"),
    DailyRectangle(text: "Ты — свет своей мечты и её сила", authorText: "Овидий"),
    DailyRectangle(text: "Создавай мечту и воплощай её", authorText: "Рэй Брэдбери"),
    DailyRectangle(text: "Будь мечтой, которая вдохновляет других", authorText: "Фредерик Ницше")
    ]
