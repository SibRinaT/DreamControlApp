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
    
    init() {
        storiesService = StoriesService()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
        .environment(storiesService)
    }
}
