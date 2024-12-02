//
//  DreamControlAppApp.swift
//  DreamControlApp
//
//  Created by Ainur on 29.02.2024.
//

import SwiftUI
import DataProvider

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
    }
    
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
