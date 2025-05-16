//
//  SubscriptionManager.swift
//  DreamControlApp
//
//  Created by Ainur on 16.05.2025.
//


import StoreKit

@MainActor
class SubscriptionManager: ObservableObject {
    @Published var products: [Product] = []
    @Published var isSubscribed = false

    private let productIds = ["com.yourapp.premium.monthly"]

    init() {
        Task {
            await fetchProducts()
            await updateSubscriptionStatus()
        }
    }

    func fetchProducts() async {
        do {
            products = try await Product.products(for: productIds)
        } catch {
            print("Ошибка загрузки продуктов: \(error)")
        }
    }

    func purchase(product: Product) async {
        do {
            let result = try await product.purchase()
            switch result {
            case .success(.verified(let transaction)):
                await transaction.finish()
                await updateSubscriptionStatus()
            default:
                break
            }
        } catch {
            print("Ошибка покупки: \(error)")
        }
    }

    func updateSubscriptionStatus() async {
        for await result in Transaction.currentEntitlements {
            switch result {
            case .verified(let transaction):
                if productIds.contains(transaction.productID) {
                    isSubscribed = true
                    return
                }
            default:
                continue
            }
        }
        isSubscribed = false
    }
}
