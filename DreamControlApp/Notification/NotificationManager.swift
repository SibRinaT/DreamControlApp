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
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Напоминание"
        content.body = "Не забывайте мечтать, ведь постоянство - ключ к успеху!"
        content.sound = .default
        content.categoryIdentifier = "category_id"

        // Триггер через 10 секунд
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)

        // Уникальный идентификатор для уведомления
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Ошибка при добавлении уведомления: \(error.localizedDescription)")
            }
        }
    }
    
    class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
        func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
            if response.actionIdentifier == "action_id" {
                print("Кнопка действия нажата!")
            }
            completionHandler()
        }

        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.banner, .sound]) // Показывать уведомление, даже если приложение активно
        }
    }

}
