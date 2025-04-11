//
//  APIService.swift
//  DreamControlApp
//
//  Created by Ainur on 11.04.2025.
//


import Foundation

class APIService {
    func sendPrompt(_ prompt: String, completion: @escaping (String?) -> Void) {
        TokenManager.shared.getToken { token in
            guard let token = token else {
                completion("❌ Не удалось получить токен")
                return
            }
            
            let url = URL(string: "https://gigachat.devices.sberbank.ru/api/v1/chat/completions")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            let json: [String: Any] = [
                "model": "GigaChat:latest",
                "messages": [
                    ["role": "user", "content": prompt]
                ]
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: [])
            
            URLSession.shared.dataTask(with: request) { data, _, error in
                if let data = data,
                   let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let choices = json["choices"] as? [[String: Any]],
                   let content = choices.first?["message"] as? [String: Any],
                   let answer = content["content"] as? String {
                    DispatchQueue.main.async {
                        completion(answer)
                    }
                } else {
                    print("❌ Ошибка ответа: \(error?.localizedDescription ?? "Unknown")")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }.resume()
        }
    }
}
