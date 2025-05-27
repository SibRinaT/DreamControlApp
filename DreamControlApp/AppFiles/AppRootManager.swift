//
//  AppRootManager.swift
//  DreamControlApp
//
//  Created by Artem on 5/27/25.
//

import Foundation
import SwiftUI

@MainActor
@Observable final class AppRootManager {
    var currentRoot: AppRoots = .splashView
    private var hasCompletedOnboarding: Bool
    private var isFirstLaunch: Bool
    
    init() {
        // Проверяем, первый ли это запуск и завершен ли онбординг
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        let completedOnboarding = UserDefaults.standard.bool(forKey: "onboardingCompleted")
        
        if !launchedBefore {
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            isFirstLaunch = true
            hasCompletedOnboarding = false
        } else {
            isFirstLaunch = false
            hasCompletedOnboarding = completedOnboarding
        }
        updateRoot()
    }
    
    func updateRoot() {
        
        if isFirstLaunch || !hasCompletedOnboarding {
            currentRoot = .splashView
        } else {
            currentRoot = .timeBasedSplashView
        }
    }
    
    enum AppRoots {
        case splashView
        case timeBasedSplashView
    }

}
