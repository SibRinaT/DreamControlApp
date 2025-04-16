//
//  DreamControlAppApp.swift
//  DreamControlApp
//
//  Created by Ainur on 29.02.2024.
//

import SwiftUI
import DataProvider
//
//// Запуск тестового решения авто историй
//import SwiftUI
//
//@main
//struct DreamControlAppApp: App {
//    var body: some Scene {
//        WindowGroup {
//            GigaChatView()
//        }
//    }
//}

@main
struct DreamControlAppApp: App {
    private let ideasViewModel: IdeasViewModel
    @State private var hasCompletedOnboarding: Bool
    @State private var isFirstLaunch: Bool
    
    @MainActor private let dataHandler: DataHandler
    
    init() {
        ideasViewModel = IdeasViewModel()
        dataHandler = DataHandler(modelContainer: DataProvider.shared.sharedModelContainer,
                                  mainActor: true)
        
        // Проверяем, первый ли это запуск и завершен ли онбординг
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        let completedOnboarding = UserDefaults.standard.bool(forKey: "onboardingCompleted")
        
        if !launchedBefore {
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            _isFirstLaunch = State(initialValue: true)
            _hasCompletedOnboarding = State(initialValue: false)
        } else {
            _isFirstLaunch = State(initialValue: false)
            _hasCompletedOnboarding = State(initialValue: completedOnboarding)
        }
        
//        Task {
//            do {
//    //            if !ideasPopulatedFromJSON {
//                    let ideas = try loadFromJson()
//                    ideas.forEach {
//                        let idea = Idea(title: $0.name, status: IdeaShowStatus.neutral)
//                        await dataHandler.new(idea: idea)
//                    }
//                    
//    //            }
//                
//            } catch {
//                print(error)
//            }
//        }

        
    }
    
//    struct IdeaStruct: Codable {
//        let name: String
//    }
//    
//    func loadFromJson() throws -> [IdeaStruct] {
//        if let url = Bundle.main.url(forResource: "ideas", withExtension: "json") {
//            let data = try Data(contentsOf: url)
//            let ideas = try JSONDecoder().decode([IdeaStruct].self, from: data)
//            print(ideas)
//            return ideas
//        }
//    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if isFirstLaunch || !hasCompletedOnboarding {
                    SplashView()
                } else {
                    getTimeBasedSplashView()
                }
            }
        }
        .environment(\.dynamicTypeSize, .xxLarge)
        .environment(ideasViewModel)
        .environment(\.dataHandler, dataHandler)
        .environment(\.modelContext, dataHandler.modelContainer.mainContext)
    }
    
    // Метод для выбора нужного Splash экрана в зависимости от времени суток
    private func getTimeBasedSplashView() -> some View {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 6..<12:
            return AnyView(MorningSplash())
        case 12..<18:
            return AnyView(DaySplash())
        case 18..<24:
            return AnyView(EveningSplash())
        default:
            return AnyView(DaySplash())
        }
        // for test notification        return AnyView(TestNotificationView())
        
    }
}
