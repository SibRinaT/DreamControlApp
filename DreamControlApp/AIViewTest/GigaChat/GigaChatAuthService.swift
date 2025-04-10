//
//  AIService.swift
//  DreamControlApp
//
//  Created by Ainur on 17.03.2025.
//
//
import Foundation

import Foundation

class GigaChatAuthService: NSObject, URLSessionDelegate {
    private let clientID = "<Твой Client ID>"
    private let clientSecret = "<Твой Client Secret>"
    private let tokenURL = "https://ngw.devices.sberbank.ru:9443/api/v2/oauth"

    func fetchAccessToken(completion: @escaping (String?) -> Void) {
        guard let url = URL(string: tokenURL) else {
            print("⚠️ Неверный URL!")
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Обновим заголовки, чтобы быть уверенными, что они корректные
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // Тело запроса
        let bodyString = "scope=GIGACHAT_API_PUB"
        request.httpBody = bodyString.data(using: .utf8)

        // Basic Auth
        let authString = "\(clientID):\(clientSecret)"
        guard let authData = authString.data(using: .utf8) else { return }
        let base64Auth = authData.base64EncodedString()
        request.setValue("Basic \(base64Auth)", forHTTPHeaderField: "Authorization")

        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)

        session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ Ошибка при запросе токена: \(error.localizedDescription)")
                completion(nil)
                return
            }

            // Проверка кода ответа
            if let httpResponse = response as? HTTPURLResponse {
                print("📊 HTTP статус: \(httpResponse.statusCode)")
                if httpResponse.statusCode != 200 {
                    print("⚠️ Ошибка! Код статуса не 200: \(httpResponse.statusCode)")
                    completion(nil)
                    return
                }
            }

            guard let data = data else {
                print("⚠️ Нет данных от сервера")
                completion(nil)
                return
            }

            // Печать "сырых" данных от сервера
            let rawText = String(data: data, encoding: .utf8) ?? "Не удалось преобразовать данные в строку"
            print("📄 Ответ сервера (raw):\n\(rawText)")

            // Попробуем парсить ответ
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let accessToken = json["access_token"] as? String {
                completion(accessToken)
            } else {
                print("⚠️ Ошибка при парсинге JSON: \(String(data: data, encoding: .utf8) ?? "Нет текста")")
                completion(nil)
            }
        }.resume()
    }

    // ✅ Обработка SSL-сертификата (разрешаем всё)
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {

        if let serverTrust = challenge.protectionSpace.serverTrust {
            completionHandler(.useCredential, URLCredential(trust: serverTrust))
        } else {
            completionHandler(.performDefaultHandling, nil)
        }
    }
}
