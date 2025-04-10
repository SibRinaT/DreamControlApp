//
//  AIService.swift
//  DreamControlApp
//
//  Created by Ainur on 17.03.2025.
//
//
import Foundation

class GigaChatAuthService: NSObject {
    private let clientID = "94d37597-b464-4895-a331-353712880d03"
    private let clientSecret = "OTRkMzc1OTctYjQ2NC00ODk1LWEzMzEtMzUzNzEyODgwZDAzOjE3MzBkNmM4LWY0ZjctNDk5OC1iM2FlLTYzZDdxNWMwMTg5OA=="
    private let tokenURL = "https://ngw.devices.sberbank.ru:9443/api/v2/oauth"

    func fetchAccessToken(completion: @escaping (String?) -> Void) {
        guard let url = URL(string: tokenURL) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Формируем тело запроса как JSON
        let bodyDict: [String: Any] = [
            "grant_type": "client_credentials",
            "scope": "GIGACHAT_API_PUB"
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: bodyDict, options: [])
        } catch {
            print("Ошибка при сериализации JSON: \(error)")
            completion(nil)
            return
        }

        // Формируем Basic авторизацию
        let authString = "\(clientID):\(clientSecret)"
        guard let authData = authString.data(using: .utf8) else { return }
        let base64Auth = authData.base64EncodedString()
        request.setValue("Basic \(base64Auth)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")  // Ожидаем ответ в JSON

        // Создаем кастомный URLSession с обработчиком для игнорирования ошибок SSL
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)

        session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Ошибка при запросе токена: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("Не получены данные в ответе.")
                completion(nil)
                return
            }

            // Логируем HTTP статус код и тип контента
            if let httpResponse = response as? HTTPURLResponse {
                print("Код ответа HTTP: \(httpResponse.statusCode)")
                print("Тип контента: \(httpResponse.allHeaderFields["Content-Type"] ?? "Не указан")")
            }

            // Логируем raw response
            if let responseString = String(data: data, encoding: .utf8) {
                print("Ответ сервера (raw): \(responseString)")  // Логируем весь ответ от сервера
            }

            // Пробуем распарсить как JSON
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    print("Парсинг успешен: \(json)")  // Логируем распарсенный JSON
                    if let accessToken = json["access_token"] as? String {
                        completion(accessToken)
                    } else {
                        print("Ошибка: отсутствует поле 'access_token' в ответе.")
                        completion(nil)
                    }
                } else {
                    print("Ошибка: не удалось преобразовать данные в JSON.")
                    completion(nil)
                }
            } catch {
                print("Ошибка при парсинге JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
}

// Реализация URLSessionDelegate для игнорирования ошибки SSL
extension GigaChatAuthService: URLSessionDelegate {
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        // Игнорируем SSL-сертификаты
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
        } else {
            completionHandler(.performDefaultHandling, nil)
        }
    }
}
