//
//  TestNotification.swift
//  DreamControlApp
//
//  Created by Ainur on 16.11.2024.
//
import SwiftUI

struct TestNotificationView: View {
    var body: some View {
        VStack {
            Text("Тест уведомлений")
                .font(.title)
                .padding()

            Button("Отправить уведомление") {
                NotificationManager.shared.requestAuthorization()
                NotificationManager.shared.scheduleNotification()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}
