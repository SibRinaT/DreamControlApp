//
//  AITextView.swift
//  DreamControlApp
//
//  Created by Ainur on 10.04.2025.
//

//
//import SwiftUI
//
//struct AITextView: View {
//    @State private var responseText: String = ""
//    
//    var body: some View {
//        VStack {
//            Text(responseText)
//                .padding()
//            
//            Button("Получить токен и запросить текст") {
//                // Получаем токен через GigaChatAuthService
//                GigaChatAuthService.shared.fetchToken { token, error in
//                    if let error = error {
//                        print("Ошибка при получении токена: \(error.localizedDescription)")
//                        return
//                    }
//                    
//                    if let token = token {
//                        print("Токен получен: \(token)")
//                        // Вызываем запрос с полученным токеном
//                        self.fetchTextWithToken(token: token)
//                    }
//                }
//            }
//        }
//        .padding()
//    }
//    
//    private func fetchTextWithToken(token: String) {
//        // URL для запроса
//        let url = URL(string: "https://ngw.devices.sberbank.ru:9443/api/v2/some-endpoint")!
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        
//        // Заголовки с токеном
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Ошибка при запросе текста: \(error.localizedDescription)")
//                return
//            }
//            
//            // Парсим ответ (предположим, что это текст)
//            if let data = data, let text = String(data: data, encoding: .utf8) {
//                DispatchQueue.main.async {
//                    self.responseText = text
//                }
//            }
//        }
//        
//        task.resume()
//    }
//}
