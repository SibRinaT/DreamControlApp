//
//  APIService.swift
//  DreamControlApp
//
//  Created by Ainur on 11.04.2025.
//


import Foundation

class APIService: ObservableObject  {
    let insecureNetworkManager = InsecureNetworkManager()

    func sendPrompt(_ prompt: String) async throws -> String {
        
        let token = try await TokenManager.shared.getToken()
        
            
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
        
        
        let data = try await self.insecureNetworkManager.fetchData(for: request)

        if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
            let choices = json["choices"] as? [[String: Any]],
            let content = choices.first?["message"] as? [String: Any],
            let answer = content["content"] as? String {
            return answer
        } else {
            throw GigaChatManagerError.customError("❌ Ошибка ответа: не удалось распарсить ответ сервера")
        }

    
        
    }
}
