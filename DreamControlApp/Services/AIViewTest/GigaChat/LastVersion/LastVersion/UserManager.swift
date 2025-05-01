//
//  UserManager.swift
//  DreamControlApp
//
//  Created by Artem on 4/27/25.
//

import Foundation

@MainActor
@Observable final class UserManager {
    
    private let userDefaultsKey = "userDefaultsKey"
    private let defaults = UserDefaults.standard
    private var user: User?
    
    init() {
        loadUser()
    }
    
    func isLoggedIn() -> Bool {
        user != nil
    }
    
    func activateSubscription() {
        guard isLoggedIn() else { return }
        user?.enableSubscription()
        saveUser()
    }
    
    func getUser() -> User? {
        user
    }
    
    func saveUser(_ user: User) {
        self.user = user
        saveUser()
    }
    
//MARK: private methods
    private func loadUser() {
        user = defaults.object(forKey: userDefaultsKey) as? User
    }
    
    private func saveUser() {
        if let user {
            defaults.set(user, forKey: userDefaultsKey)
        }
    }
    
}
