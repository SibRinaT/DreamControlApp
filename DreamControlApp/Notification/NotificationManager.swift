//
//  NotificationManager.swift
//  DreamControlApp
//
//  Created by Ainur on 16.11.2024.
//

import SwiftUI
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()

    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Ошибка запроса разрешений: \(error.localizedDescription)")
            }
            print("Разрешение предоставлено: \(granted)")
        }
    }
    
    func setupNotificationCategories() {
        let action = UNNotificationAction(identifier: "action_id", title: "Открыть", options: [.foreground])
        let category = UNNotificationCategory(identifier: "category_id", actions: [action], intentIdentifiers: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }


}
