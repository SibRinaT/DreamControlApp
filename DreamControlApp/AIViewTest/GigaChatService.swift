//
//  GigaChatService.swift
//  DreamControlApp
//
//  Created by Ainur on 10.04.2025.
//

import Foundation

class GigaChatService {
    private let apiURL = "https://gigachat.devices.sberbank.ru/api/v1/chat/completions"

    func generateText(prompt: String, accessToken: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: apiURL) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody: [String: Any] = [
            "model": "GigaChat", // используемая модель
            "messages": [
                ["role": "user", "content": prompt]
            ],
            "temperature": 0.8
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let choices = json["choices"] as? [[String: Any]],
                  let message = choices.first?["message"] as? [String: Any],
                  let content = message["content"] as? String else {
                completion(nil)
                return
            }
            completion(content)
        }.resume()
    }
}


