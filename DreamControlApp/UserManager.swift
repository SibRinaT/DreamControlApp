//
//  UserManager.swift
//  DreamControlApp
//
//  Created by Artem on 4/27/25.
//

import Foundation
import Combine

@MainActor
final class UserManager: ObservableObject {
    
    private let userDefaultsUserKey = "userDefaultsUserKey"
    private let userDefaultsSubscriptionKey = "subscriptionEnabled"
    private let defaults = UserDefaults.standard

    @Published private(set) var user: User? {
        didSet {
            saveUser()
        }
    }
    
    @Published var isSubscriptionEnabled: Bool {
        didSet {
            saveSubscription()
        }
    }

    init() {
        // Загрузка пользователя
        if let data = defaults.data(forKey: userDefaultsUserKey),
           let decoded = try? JSONDecoder().decode(User.self, from: data) {
            self.user = decoded
        } else {
            self.user = nil
        }
        
        // Загрузка подписки
        self.isSubscriptionEnabled = defaults.bool(forKey: userDefaultsSubscriptionKey)
    }

    var isLoggedIn: Bool {
        user != nil
    }

    func activateSubscription() {
        isSubscriptionEnabled = true
    }

    func deactivateSubscription() {
        isSubscriptionEnabled = false
    }

    func saveUser(_ user: User) {
        self.user = user
    }

    private func saveUser() {
        guard let user = user,
              let encoded = try? JSONEncoder().encode(user) else { return }
        defaults.set(encoded, forKey: userDefaultsUserKey)
    }

    private func saveSubscription() {
        defaults.set(isSubscriptionEnabled, forKey: userDefaultsSubscriptionKey)
    }
}
