//
//  TokenManager.swift
//  DreamControlApp
//
//  Created by Ainur on 11.04.2025.
//


import Foundation

class TokenManager: NSObject, URLSessionDelegate {
    static let shared = TokenManager()

    private var token: String?
    private var tokenExpiration: Date?

    private let clientId = "твой_client_id"
    private let clientSecret = "твой_client_secret"

    private let authURL = URL(string: "https://ngw.devices.sberbank.ru:9443/api/v2/oauth")!

    private override init() {}

    func getToken(completion: @escaping (String?) -> Void) {
        if let token = token, let expiration = tokenExpiration, Date() < expiration {
            completion(token)
            return
        }

        fetchToken { [weak self] newToken, expiresIn in
            guard let newToken = newToken, let expiresIn = expiresIn else {
                completion(nil)
                return
            }

            self?.token = newToken
            self?.tokenExpiration = Date().addingTimeInterval(TimeInterval(expiresIn))
            completion(newToken)
        }
    }

    private func fetchToken(completion: @escaping (String?, Int?) -> Void) {
        var request = URLRequest(url: authURL)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(UUID().uuidString, forHTTPHeaderField: "RqUID")

        let credentials = "\(clientId):\(clientSecret)"
        guard let base64Creds = credentials.data(using: .utf8)?.base64EncodedString() else {
            completion(nil, nil)
            return
        }

        request.setValue("Basic \(base64Creds)", forHTTPHeaderField: "Authorization")

        let bodyString = "scope=GIGACHAT_API_PERS"
        request.httpBody = bodyString.data(using: .utf8)

        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)

        session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Ошибка при получении токена: \(error.localizedDescription)")
                completion(nil, nil)
                return
            }

            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let token = json["access_token"] as? String,
                  let expiresIn = json["expires_in"] as? Int else {
                print("Не удалось распарсить ответ: \(String(data: data ?? Data(), encoding: .utf8) ?? "")")
                completion(nil, nil)
                return
            }

            completion(token, expiresIn)
        }.resume()
    }

    // MARK: - Отключаем проверку SSL
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
           let trust = challenge.protectionSpace.serverTrust {
            completionHandler(.useCredential, URLCredential(trust: trust))
        } else {
            completionHandler(.performDefaultHandling, nil)
        }
    }
}
