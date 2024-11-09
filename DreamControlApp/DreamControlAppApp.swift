//
//  DreamControlAppApp.swift
//  DreamControlApp
//
//  Created by Ainur on 29.02.2024.
//

import SwiftUI

@main
struct DreamControlAppApp: App {
    private let storiesService: StoriesService
    private let ideasViewModel: IdeasViewModel
    @State private var isFirstLaunch: Bool

    init() {
        storiesService = StoriesService()
        ideasViewModel = IdeasViewModel()
        
        // Проверяем, первый ли это запуск
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if !launchedBefore {
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            _isFirstLaunch = State(initialValue: true)
        } else {
            _isFirstLaunch = State(initialValue: false)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if isFirstLaunch {
                    SplashView()
                } else {
                    getTimeBasedSplashView()
                }
            }
        }
        .environment(storiesService)
        .environment(ideasViewModel)
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
    }
}
