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

    init() {
        storiesService = StoriesService()
        ideasViewModel = IdeasViewModel()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
        .environment(storiesService)
        .environmentObject(ideasViewModel)
    }
}
