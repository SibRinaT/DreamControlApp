//
//  AIService.swift
//  DreamControlApp
//
//  Created by Ainur on 17.03.2025.
//
//
import Foundation

class GigaChatAuthService {
    // Вставь сюда свой client_id и готовый base64(client_id:client_secret)
    private let clientID = "94d37597-b464-4895-a331-353712880d03"
    private let base64ClientAuth = "OTRkMzc1OTctYjQ2NC00ODk1LWEzMzEtMzUzNzEyODgwZDAzOjE3MzBkNmM4LWY0ZjctNDk5OC1iM2FlLTYzZDcxZGM2NDU4OA==" // уже закодировано

    private let tokenURL = "https://ngw.devices.sberbank.ru:9443/api/v2/oauth"

    func fetchAccessToken(completion: @escaping (String?) -> Void) {
        guard let url = URL(string: tokenURL) else {
            print("❌ Неверный URL")
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // Тело запроса (формат x-www-form-urlencoded)
        let bodyString = "scope=GIGACHAT_API_PUB"
        request.httpBody = bodyString.data(using: .utf8)

        // Заголовки
        request.setValue("Basic \(base64ClientAuth)", forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        // Отправка запроса
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ Ошибка при запросе токена: \(error)")
                completion(nil)
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("📡 Статус ответа: \(httpResponse.statusCode)")
            }

            guard let data = data else {
                print("❌ Нет данных в ответе")
                completion(nil)
                return
            }

            let responseString = String(data: data, encoding: .utf8) ?? "неизвестный ответ"
            print("📦 Ответ от сервера: \(responseString)")

            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let accessToken = json["access_token"] as? String {
                print("✅ Токен получен")
                completion(accessToken)
            } else {
                print("⚠️ Не удалось извлечь токен из ответа")
                completion(nil)
            }
        }.resume()
    }
}
