//
//  AIService.swift
//  DreamControlApp
//
//  Created by Ainur on 17.03.2025.
//

import Foundation

func generateTextFromKoboldAI(prompt: String, completion: @escaping (String) -> Void) {
    let url = URL(string: "https://lite.koboldai.net/api/v1/generate")!
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let body: [String: Any] = [
        "prompt": prompt,
        "max_length": 200,
        "temperature": 0.8,
        "top_p": 0.9
    ]
    
    request.httpBody = try? JSONSerialization.data(withJSONObject: body)

    URLSession.shared.dataTask(with: request) { data, response, error in
        if let data = data {
            if let jsonResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let generatedText = jsonResponse["results"] as? [[String: Any]],
               let text = generatedText.first?["text"] as? String {
                DispatchQueue.main.async {
                    completion(text)
                }
            }
        } else {
            print("Ошибка запроса: \(error?.localizedDescription ?? "Неизвестная ошибка")")
        }
    }.resume()
}
