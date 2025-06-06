//
//  TokenManager.swift
//  DreamControlApp
//
//  Created by Ainur on 11.04.2025.
//


import Foundation

enum GigaChatManagerError: Error {
    case customError(String)
}

class TokenManager: NSObject, URLSessionDelegate {
    static let shared = TokenManager()
    
    private let clientID = "94d37597-b464-4895-a331-353712880d03"
    private let clientSecret = "OTRkMzc1OTctYjQ2NC00ODk1LWEzMzEtMzUzNzEyODgwZDAzOjE3MzBkNmM4LWY0ZjctNDk5OC1iM2FlLTYzZDcxZGM2NDU4OA=="
    internal let tokenURL = URL(string: "https://ngw.devices.sberbank.ru:9443/api/v2/oauth")!
    
    internal var accessToken: String?
    internal var tokenExpirationDate: Date?
    
    private override init() {
        super.init()
    }
    
    func getToken() async throws -> String {
        if let token = accessToken, let expiration = tokenExpirationDate, expiration > Date() {
            return token
        }
        
        var request = URLRequest(url: tokenURL)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Basic \(clientSecret)", forHTTPHeaderField: "Authorization") // Используем уже готовый Base64
        request.setValue(UUID().uuidString, forHTTPHeaderField: "RqUID")
        request.httpBody = "scope=GIGACHAT_API_PERS".data(using: .utf8)
        
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
        
 
        let (data, resp) = try await session.data(for: request)
        if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
            print("🌐 Ответ от токен сервера: \(json)") // Отладочный вывод для проверки
            
            if let token = json["access_token"] as? String, let expiresAt = json["expires_at"] as? Double {
                self.accessToken = token
                self.tokenExpirationDate = Date(timeIntervalSince1970: expiresAt / 1000) // Преобразуем из миллисекунд в дату
                return token
            } else {
                throw GigaChatManagerError.customError("❌ Ошибка при парсинге токена")
            }
        } else {
            throw GigaChatManagerError.customError("❌ Ошибка при получении данных")
        }
            

//            print("❌ Ошибка: \(error.localizedDescription)")
        
        
    }
        
        
//        session.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("❌ Ошибка: \(error.localizedDescription)")
//                DispatchQueue.main.async {
//                    completion(nil)
//                }
//                return
//            }
//
//            guard let data = data,
//                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                print("❌ Ошибка при получении данных")
//                DispatchQueue.main.async {
//                    completion(nil)
//                }
//                return
//            }
//
//            print("🌐 Ответ от токен сервера: \(json)") // Отладочный вывод для проверки
//
//            guard let token = json["access_token"] as? String,
//                  let expiresAt = json["expires_at"] as? Double else {
//                print("❌ Ошибка при парсинге токена")
//                DispatchQueue.main.async {
//                    completion(nil)
//                }
//                return
//            }
//
//            self.accessToken = token
//            self.tokenExpirationDate = Date(timeIntervalSince1970: expiresAt / 1000) // Преобразуем из миллисекунд в дату
//
//            DispatchQueue.main.async {
//                print(token)
//                completion(token)
//            }
//        }.resume()
//    }

    // MARK: - Отключение проверки SSL (для DEV)
    func urlSession(
        _ session: URLSession,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
    ) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
           let trust = challenge.protectionSpace.serverTrust {
            completionHandler(.useCredential, URLCredential(trust: trust))
        } else {
            completionHandler(.performDefaultHandling, nil)
        }
    }
}
