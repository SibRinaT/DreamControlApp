//
//  GigaChatService 2.swift
//  DreamControlApp
//
//  Created by Ainur on 10.04.2025.
//

import Foundation

class GigaChatService {
    private let apiURL = "https://gigachat.devices.sberbank.ru/api/v1/chat/completions"

    func generateText(prompt: String, accessToken: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: apiURL) else {
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody: [String: Any] = [
            "model": "GigaChat",
            "messages": [
                ["role": "user", "content": prompt]
            ],
            "temperature": 0.7,
            "max_tokens": 512
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ Ошибка запроса: \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("❌ Пустой ответ от сервера")
                completion(nil)
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let choices = json?["choices"] as? [[String: Any]],
                   let message = choices.first?["message"] as? [String: Any],
                   let content = message["content"] as? String {
                    completion(content)
                } else {
                    print("⚠️ Ответ не содержит ожидаемых данных")
                    print("📄 JSON: \(String(data: data, encoding: .utf8) ?? "n/a")")
                    completion(nil)
                }
            } catch {
                print("❌ Ошибка при парсинге JSON: \(error)")
                print("📄 Ответ: \(String(data: data, encoding: .utf8) ?? "n/a")")
                completion(nil)
            }
        }.resume()
    }
}
