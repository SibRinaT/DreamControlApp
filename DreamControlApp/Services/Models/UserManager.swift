//
//  UserManager.swift
//  DreamControlApp
//
//  Created by Artem on 4/27/25.
//

import Foundation
import Combine
import StoreKit

@MainActor
final class UserManager: ObservableObject {
    
    private let userDefaultsUserKey = "userDefaultsUserKey"
    private let userDefaultsSubscriptionKey = "subscriptionEnabled"
    private let defaults = UserDefaults.standard
    private let subscriptionProductId = "DreamControl.Premium.Monthly" // AppStore подписки

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
    
    func purchaseSubscription() async {
        do {
            let products = try await Product.products(for: [subscriptionProductId])
            guard let product = products.first else {
                print("Продукт не найден")
                return
            }

            let result = try await product.purchase()

            switch result {
            case .success(let verification):
                switch verification {
                case .verified(let transaction):
                    print("Покупка подтверждена")
                    await transaction.finish()
                    activateSubscription()
                case .unverified:
                    print("Покупка не подтверждена")
                }
            case .userCancelled:
                print("Пользователь отменил")
            case .pending:
                print("Ожидание оплаты")
            @unknown default:
                break
            }
        } catch {
            print("Ошибка покупки: \(error)")
        }
    }

    var isLoggedIn: Bool {
        user != nil
    }
    // для вью тестов кнопки активации подписки
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

    // функция для подписок, если делать с сервером + ботом в тг
//    func checkSubscriptionStatus(completion: @escaping (Bool) -> Void) {
//        guard let telegramId = user?.telegramUserId else {
//            completion(false)
//            return
//        }
//
//        guard let url = URL(string: "http://localhost:3000/api/integrations/v1/users/1645257568/check_subscription") else {
//            completion(false)
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//
//        URLSession.shared.dataTask(with: request) { _, response, error in
//            DispatchQueue.main.async {
//                guard error == nil, let httpResponse = response as? HTTPURLResponse else {
//                    completion(false)
//                    return
//                }
//
//                if httpResponse.statusCode == 200 {
//                    self.isSubscriptionEnabled = true
//                    completion(true)
//                } else {
//                    self.isSubscriptionEnabled = false
//                    completion(false)
//                }
//            }
//        }.resume()
}
