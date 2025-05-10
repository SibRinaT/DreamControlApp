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
        IdeaItem(text: "Выучить новый язык", category: "Образование"),
        IdeaItem(text: "Прочитать книгу по бизнесу", category: "Бизнес"),
        IdeaItem(text: "Научиться готовить новое блюдо", category: "Кулинария"),
        IdeaItem(text: "Прокачать навыки программирования", category: "Образование"),
        IdeaItem(text: "Заняться йогой", category: "Здоровье"),
        IdeaItem(text: "Изучить основы фотографии", category: "Творчество"),
        IdeaItem(text: "Запустить собственный бизнес", category: "Бизнес"),
        IdeaItem(text: "Научиться танцевать сальсу", category: "Активность"),
        IdeaItem(text: "Прочитать 100 книг за год", category: "Образование"),
        IdeaItem(text: "Пробежать марафон", category: "Спорт"),
        IdeaItem(text: "Освоить публичные выступления", category: "Навыки"),
        IdeaItem(text: "Снять собственный короткометражный фильм", category: "Творчество"),
        IdeaItem(text: "Изучить астрономию и освоить телескоп", category: "Наука"),
        IdeaItem(text: "Переехать жить в другую страну на некоторое время", category: "Путешествия"),
        IdeaItem(text: "Освоить гитару или другой музыкальный инструмент", category: "Музыка"),
        IdeaItem(text: "Завести блог или YouTube-канал", category: "Медиа"),
        IdeaItem(text: "Увидеть северное сияние", category: "Путешествия"),
        IdeaItem(text: "Написать и опубликовать книгу", category: "Творчество"),
        IdeaItem(text: "Создать пассивный доход", category: "Финансы"),
        IdeaItem(text: "Научиться играть в шахматы на профессиональном уровне", category: "Интеллект"),
        IdeaItem(text: "Заняться дайвингом", category: "Активность"),
        IdeaItem(text: "Пройти курс по искусственному интеллекту", category: "Технологии"),
        IdeaItem(text: "Принять участие в триатлоне", category: "Спорт"),
        IdeaItem(text: "Научиться кататься на сноуборде", category: "Активность"),
        IdeaItem(text: "Сделать утренние пробежки привычкой", category: "Здоровье"),
        IdeaItem(text: "Организовать благотворительное мероприятие", category: "Общество"),
        IdeaItem(text: "Научиться рисовать или писать картины", category: "Творчество"),
        IdeaItem(text: "Изучить историю своей семьи и создать генеалогическое древо", category: "Личное"),
        IdeaItem(text: "Сдать экзамен на высокий уровень в изучаемом языке", category: "Образование"),
        IdeaItem(text: "Пройти курсы программирования", category: "Технологии"),
        IdeaItem(text: "Провести ночь под открытым небом, наблюдая за звездами", category: "Природа"),
        IdeaItem(text: "Научиться правильно медитировать", category: "Здоровье"),
        IdeaItem(text: "Освоить практику йоги", category: "Здоровье"),
        IdeaItem(text: "Создать свой веб-сайт или онлайн-портфолио", category: "Технологии"),
        IdeaItem(text: "Пройти курс ораторского мастерства", category: "Навыки"),
        IdeaItem(text: "Освоить каллиграфию", category: "Творчество"),
        IdeaItem(text: "Научиться делать керамику", category: "Творчество"),
        IdeaItem(text: "Сесть на шпагат", category: "Спорт"),
        IdeaItem(text: "Пройти обучение на гида или экскурсовода", category: "Путешествия"),
        IdeaItem(text: "Полетать на воздушном шаре", category: "Приключения"),
        IdeaItem(text: "Поставить пьесу в любительском театре", category: "Творчество"),
        IdeaItem(text: "Завести питомца", category: "Личное"),
        IdeaItem(text: "Организовать музыкальный концерт", category: "Музыка"),
        IdeaItem(text: "Попробовать фриланс или удаленную работу", category: "Карьера"),
        IdeaItem(text: "Стать экспертом в выбранной профессиональной области", category: "Карьера"),
        IdeaItem(text: "Собрать коллекцию винтажных вещей", category: "Хобби"),
        IdeaItem(text: "Изучить древнюю философию", category: "Образование"),
        IdeaItem(text: "Сменить профессию на ту, которая по-настоящему вдохновляет", category: "Карьера"),
        IdeaItem(text: "Научиться играть на барабанах", category: "Музыка"),
        IdeaItem(text: "Попробовать все известные мировые кухни", category: "Кулинария"),
        IdeaItem(text: "Создать собственный комикс или графический роман", category: "Творчество"),
        IdeaItem(text: "Принять участие в мюзикле", category: "Творчество"),
        IdeaItem(text: "Освоить основы психологии", category: "Образование"),
        IdeaItem(text: "Изучить основы криптовалют и инвестирования", category: "Финансы"),
        IdeaItem(text: "Увидеть все «чудеса света»", category: "Путешествия"),
        IdeaItem(text: "Выучить язык жестов", category: "Образование"),
        IdeaItem(text: "Пройти курс по личным финансам", category: "Финансы"),
        IdeaItem(text: "Поучаствовать в археологических раскопках", category: "Наука"),
        IdeaItem(text: "Организовать кулинарный вечер для друзей", category: "Кулинария"),
        IdeaItem(text: "Пройти обучение водолазному делу", category: "Активность"),
        IdeaItem(text: "Научиться плавать на профессиональном уровне", category: "Спорт"),
        IdeaItem(text: "Стать наставником для начинающих в своей сфере", category: "Образование"),
        IdeaItem(text: "Пройти курс по предпринимательству", category: "Бизнес"),
        IdeaItem(text: "Научиться собирать мебель", category: "Навыки"),
        IdeaItem(text: "Устроить путешествие автостопом", category: "Приключения"),
        IdeaItem(text: "Сходить в поход на несколько дней", category: "Природа"),
        IdeaItem(text: "Завести дружбу с человеком из другой культуры", category: "Общество"),
        IdeaItem(text: "Принять участие в флешмобе", category: "Общество"),
        IdeaItem(text: "Сделать серьезный вклад в сохранение экологии", category: "Экология"),
        IdeaItem(text: "Пожить какое-то время в экодоме", category: "Экология"),
        IdeaItem(text: "Пройти курс по истории искусств", category: "Образование"),
        IdeaItem(text: "Прочитать все произведения любимого писателя", category: "Образование"),
        IdeaItem(text: "Изучить технику быстрого чтения", category: "Навыки"),
        IdeaItem(text: "Научиться готовить суши", category: "Кулинария"),
        IdeaItem(text: "Принять участие в крупном спортивном соревновании", category: "Спорт"),
        IdeaItem(text: "Начать писать дневник и вести его регулярно", category: "Личное"),
        IdeaItem(text: "Пожить на побережье", category: "Мечта"),
        IdeaItem(text: "Заняться верховой ездой", category: "Активность"),
        IdeaItem(text: "Принять участие в марафоне по чтению", category: "Образование"),
        IdeaItem(text: "Научиться обращаться с лошадьми", category: "Навыки"),
        IdeaItem(text: "Заняться музыкотерапией", category: "Музыка"),
        IdeaItem(text: "Заняться дизайном интерьеров", category: "Творчество"),
        IdeaItem(text: "Снять профессиональную фотосессию", category: "Личное"),
        IdeaItem(text: "Изучить основы архитектуры", category: "Образование"),
        IdeaItem(text: "Побывать на крупном музыкальном фестивале", category: "Музыка"),
        IdeaItem(text: "Научиться кататься на коньках", category: "Активность"),
        IdeaItem(text: "Построить собственный дом", category: "Мечта"),
        IdeaItem(text: "Сделать важное научное открытие", category: "Наука"),
        IdeaItem(text: "Изучить финансовый анализ", category: "Финансы"),
        IdeaItem(text: "Написать стихотворение или поэму", category: "Творчество"),
        IdeaItem(text: "Попробовать пройти марафон по играм", category: "Хобби"),
        IdeaItem(text: "Пройти курс по садоводству", category: "Хобби"),
        IdeaItem(text: "Создать собственный подкаст", category: "Медиа"),
        IdeaItem(text: "Заняться альпинизмом", category: "Активность"),
        IdeaItem(text: "Попробовать себя в актерском мастерстве", category: "Творчество"),
        IdeaItem(text: "Принять участие в научной конференции", category: "Наука"),
        IdeaItem(text: "Сыграть главную роль в спектакле или фильме", category: "Творчество")
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
