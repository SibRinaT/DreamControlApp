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

    func checkSubscriptionStatus(completion: @escaping (Bool) -> Void) {
        guard let telegramId = user?.telegramUserId else {
            completion(false)
            return
        }

        guard let url = URL(string: "http://192.168.1.10:3000/api/integrations/v1/users/1645257568/check_subscription") else {
            completion(false)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { _, response, error in
            DispatchQueue.main.async {
                guard error == nil, let httpResponse = response as? HTTPURLResponse else {
                    completion(false)
                    return
                }

                if httpResponse.statusCode == 200 {
                    self.isSubscriptionEnabled = true
                    completion(true)
                } else {
                    self.isSubscriptionEnabled = false
                    completion(false)
                }
            }
        }.resume()
    }
}
