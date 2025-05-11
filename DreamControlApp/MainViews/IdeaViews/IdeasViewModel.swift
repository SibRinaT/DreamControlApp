//
//  IdeasData.swift
//  DreamControlApp
//
//  Created by Ainur on 26.10.2024.
//
import Foundation

@MainActor
@Observable final class IdeasViewModel: ObservableObject {
    private let defaults = UserDefaults.standard
    private enum Keys {
        static let favoriteIdeas = "favoriteIdeas"
    }
    
    struct IdeaItem: Identifiable, Hashable {
        let id = UUID()
        let text: String
        let category: String
    }
    
    var favoriteIdeas: [String] = [] {
        didSet {
            saveFavoriteIdeas() // Сохраняем избранные идеи в UserDefaults
        }
    }
    
    var rightSwipedIdeas: [String] = []
    var leftSwipedIdeas: [String] = []
    
    var ideas: [IdeaItem] = [
        IdeaItem(text: "Новый язык", category: "Образование"),
        IdeaItem(text: "Книга бизнес", category: "Бизнес"),
        IdeaItem(text: "Новое блюдо", category: "Кулинария"),
        IdeaItem(text: "Навыки кодинга", category: "Образование"),
        IdeaItem(text: "Занятия йогой", category: "Здоровье"),
        IdeaItem(text: "Основы фото", category: "Творчество"),
        IdeaItem(text: "Свой бизнес", category: "Бизнес"),
        IdeaItem(text: "Сальса-танец", category: "Активность"),
        IdeaItem(text: "100 книг/год", category: "Образование"),
        IdeaItem(text: "Пробежать мараф", category: "Спорт"),
        IdeaItem(text: "Публичные речи", category: "Навыки"),
        IdeaItem(text: "Короткий фильм", category: "Творчество"),
        IdeaItem(text: "Изучить звёзды", category: "Наука"),
        IdeaItem(text: "Жизнь за рубеж", category: "Путешествия"),
        IdeaItem(text: "Освоить гитару", category: "Музыка"),
        IdeaItem(text: "Блог/Youtube", category: "Медиа"),
        IdeaItem(text: "Северное сиян", category: "Путешествия"),
        IdeaItem(text: "Своя книга", category: "Творчество"),
        IdeaItem(text: "Пассивный дох", category: "Финансы"),
        IdeaItem(text: "Шахматы про", category: "Интеллект"),
        IdeaItem(text: "Дайвинг", category: "Активность"),
        IdeaItem(text: "ИИ-курс", category: "Технологии"),
        IdeaItem(text: "Триатлон", category: "Спорт"),
        IdeaItem(text: "Сноуборд", category: "Активность"),
        IdeaItem(text: "Пробежки AM", category: "Здоровье"),
        IdeaItem(text: "Благотворит.", category: "Общество"),
        IdeaItem(text: "Рисование", category: "Творчество"),
        IdeaItem(text: "Генеалогия", category: "Личное"),
        IdeaItem(text: "Языковой экз", category: "Образование"),
        IdeaItem(text: "Курс кодинга", category: "Технологии"),
        IdeaItem(text: "Ночь с звезда", category: "Природа"),
        IdeaItem(text: "Медитация", category: "Здоровье"),
        IdeaItem(text: "Йога", category: "Здоровье"),
        IdeaItem(text: "Веб-портфолио", category: "Технологии"),
        IdeaItem(text: "Курс оратора", category: "Навыки"),
        IdeaItem(text: "Каллиграфия", category: "Творчество"),
        IdeaItem(text: "Керамика", category: "Творчество"),
        IdeaItem(text: "Сесть шпагат", category: "Спорт"),
        IdeaItem(text: "Обуч. гиду", category: "Путешествия"),
        IdeaItem(text: "Возд. шар", category: "Приключения"),
        IdeaItem(text: "Поставить пьес", category: "Творчество"),
        IdeaItem(text: "Питомец", category: "Личное"),
        IdeaItem(text: "Музыкал. конц", category: "Музыка"),
        IdeaItem(text: "Фриланс", category: "Карьера"),
        IdeaItem(text: "Эксперт", category: "Карьера"),
        IdeaItem(text: "Винтаж", category: "Хобби"),
        IdeaItem(text: "Философия", category: "Образование"),
        IdeaItem(text: "Смена карьеры", category: "Карьера"),
        IdeaItem(text: "Барабаны", category: "Музыка"),
        IdeaItem(text: "Мир кухни", category: "Кулинария"),
        IdeaItem(text: "Свой комикс", category: "Творчество"),
        IdeaItem(text: "Мюзикл", category: "Творчество"),
        IdeaItem(text: "Психология", category: "Образование"),
        IdeaItem(text: "Крипто основ", category: "Финансы"),
        IdeaItem(text: "Чудеса света", category: "Путешествия"),
        IdeaItem(text: "Язык жестов", category: "Образование"),
        IdeaItem(text: "Финансы курс", category: "Финансы"),
        IdeaItem(text: "Археология", category: "Наука"),
        IdeaItem(text: "Кулин. вечер", category: "Кулинария"),
        IdeaItem(text: "Водолаз курс", category: "Активность"),
        IdeaItem(text: "Плавать про", category: "Спорт"),
        IdeaItem(text: "Наставничество", category: "Образование"),
        IdeaItem(text: "Курс бизнес", category: "Бизнес"),
        IdeaItem(text: "Мебель DIY", category: "Навыки"),
        IdeaItem(text: "Автостоп", category: "Приключения"),
        IdeaItem(text: "Поход", category: "Природа"),
        IdeaItem(text: "Дружба культур", category: "Общество"),
        IdeaItem(text: "Флешмоб", category: "Общество"),
        IdeaItem(text: "Защита экологии", category: "Экология"),
        IdeaItem(text: "Жить в экодоме", category: "Экология"),
        IdeaItem(text: "История", category: "Образование"),
        IdeaItem(text: "Все книги", category: "Образование"),
        IdeaItem(text: "Скорочтение", category: "Навыки"),
        IdeaItem(text: "Готовить суши", category: "Кулинария"),
        IdeaItem(text: "Спортсоревн.", category: "Спорт"),
        IdeaItem(text: "Личный дневник", category: "Личное"),
        IdeaItem(text: "Жить у моря", category: "Мечта"),
        IdeaItem(text: "Верховая езд", category: "Активность"),
        IdeaItem(text: "Чтение мараф", category: "Образование"),
        IdeaItem(text: "Общение с лош", category: "Навыки"),
        IdeaItem(text: "Музыкотерап.", category: "Музыка"),
        IdeaItem(text: "Дизайн интер.", category: "Творчество"),
        IdeaItem(text: "Фотосессия", category: "Личное"),
        IdeaItem(text: "Архитектура", category: "Образование"),
        IdeaItem(text: "Фестиваль", category: "Музыка"),
        IdeaItem(text: "Коньки", category: "Активность"),
        IdeaItem(text: "Свой дом", category: "Мечта"),
        IdeaItem(text: "Науч. открытие", category: "Наука"),
        IdeaItem(text: "Фин. анализ", category: "Финансы"),
        IdeaItem(text: "Стих/поэма", category: "Творчество"),
        IdeaItem(text: "Гейм-марафон", category: "Хобби"),
        IdeaItem(text: "Садоводство", category: "Хобби"),
        IdeaItem(text: "Свой подкаст", category: "Медиа"),
        IdeaItem(text: "Альпинизм", category: "Активность"),
        IdeaItem(text: "Актёрство", category: "Творчество"),
        IdeaItem(text: "Изуч. биологию", category: "Наука"),
        IdeaItem(text: "Главная роль", category: "Творчество")
    ]

    init() {
        loadFavoriteIdeas()
    }
    
    var savedIdeasCount: Int {
        return favoriteIdeas.count
    }
    
    func saveIdea(_ idea: String, isRightSwipe: Bool) {
        if isRightSwipe {
            rightSwipedIdeas.append(idea)
            if !favoriteIdeas.contains(idea) {
                favoriteIdeas.append(idea)
            }
        } else {
            leftSwipedIdeas.append(idea)
        }
    }

    
    private func saveFavoriteIdeas() {
        do {
            let encodedFavorites = try JSONEncoder().encode(favoriteIdeas)
            defaults.set(encodedFavorites, forKey: Keys.favoriteIdeas)
        } catch {
            print("Ошибка при сохранении избранных идей: \(error)")
        }
    }
    
    private func loadFavoriteIdeas() {
        guard let data = defaults.data(forKey: Keys.favoriteIdeas) else {
            return
        }
        do {
            favoriteIdeas = try JSONDecoder().decode([String].self, from: data)
        } catch {
            print("Ошибка при загрузке избранных идей: \(error)")
        }
    }
    
    func getRandomIdea(from categories: [String] = []) -> IdeaItem {
        let filtered = categories.isEmpty ? ideas : ideas.filter { categories.contains($0.category) }
        return filtered.randomElement() ?? IdeaItem(text: "Идея отсутствует", category: "Без категории")
    }
}

extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}
