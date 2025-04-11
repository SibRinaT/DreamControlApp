//
//  AIService.swift
//  DreamControlApp
//
//  Created by Ainur on 17.03.2025.
//
//
import Foundation

class GigaChatNetworkManager: NSObject {
    private lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()

    private let token = " Bearer eyJjdHkiOiJqd3QiLCJlbmMiOiJBMjU2Q0JDLUhTNTEyIiwiYWxnIjoiUlNBLU9BRVAtMjU2In0.CD4lqbAp-TUuDB3cuk3fe7WV2TKgtrZHzNIvfK8kB8YyeSDza2rclJhV9-giKCf0HEWPLpJlM5m91oyYjG3gsudG6KVMzl6hXfKTH9uSnWgIPTiAabmECloou-VdrVT9OHlzMpkB9iLXawYdvMjJYQX2_l0uR8I1Ie3hia2neOGfsUHf4SYA0HcWJAD_NzK9fZn4uVko8dc3H-npSslD854fGWvpoBk61Ue4IB3wmzGqtBXm6ryi0hDUAiAAvxKJYiIaek9KC7quP0N8C6nFc5-LRNFWTt5UociqOv1aAzghpyoqM5tI5iPJ-oy9tDdiBs5Kuw8j_GUBd_NJpRrhnQ.ld3GxG0e93GBYhetewZRrA.FUoSNVUmVz76-jbLUkrTGkzknlA1Lo55PJIJyTPYIwjLm_EKAPIFtkzLXHb2luzmSXx8lwxMctxrnW3mtRy4taEvdX6yo_Tjn41hiN0JSIPABTPc3dTxZoH28VTfjbrI30Xav-H25souqZFXZzgxk1WtXwu3B5D2iuK80nB476Gr7FEVdEQ6pw5r-s7cqmauX5dcgUrIKlxqWcbwKEV8WiwYLWWyiUhXnMRh-120qsL5sxuLjy5zpySkxMoyE1x4OX_vNj05EhGhP7sbFDu07jclx0tvuTk6r7G4UmlP3HfKpAyCmAd1ELOcFn98HQyQTx50I52DWYFUPEIMd5DNTTR2rYkTYw4ncrGg6uIDXrYknSHeKKPkopsXZpnUt_1vFXYRMrqgFRD7LyumtXmNiNW6d9j4UBeRDXIhY-mlD4CL01-NIB64vpSAyJYIFti6fArheP5ZlJHhvtP7-NxRw7Ni2xRyyZTxlxEZO9EeLqMZ4Zfm47Ts-h4T_CG-yTqzw_E4NBEfLiqtGaWEPGcl5SihMisiteTlPButPJFFemwHv5a4JPivFAoS2KXhpRFHL-PoCzV28vy0Ggul-1RL8Ol_qTOlmBbmfBODx2oUj_y7DLJIZqOCmNAEgyrjy4UDvyFu36twTHf1nqwg_HclT0OyvWcvIkja5PDT25PZINzZV9rYSYBNpExbiIiv4SVfdOr5MYJbG_SCgSpEBDiRZTUUKOE7BVjC9VXsUifhEDU.4aTQDthW03epuz09IJMqdV9WnHhAXcRXuZ9z5F4NRU0"

    func sendPrompt(prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "https://gigachat.devices.sberbank.ru/api/v1/chat/completions") else {
            completion(.failure(URLError(.badURL)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Authorization")

        let body: [String: Any] = [
            "model": "GigaChat:latest",
            "messages": [["role": "user", "content": prompt]],
            "temperature": 1,
            "top_p": 0.9,
            "n": 1,
            "stream": false
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let choices = json["choices"] as? [[String: Any]],
                   let message = choices.first?["message"] as? [String: Any],
                   let content = message["content"] as? String {
                    completion(.success(content))
                } else {
                    completion(.failure(URLError(.cannotParseResponse)))
                }
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}

// MARK: - Отключаем проверку SSL (временно для тестов)
extension GigaChatNetworkManager: URLSessionDelegate {
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
           let trust = challenge.protectionSpace.serverTrust {
            completionHandler(.useCredential, URLCredential(trust: trust))
        } else {
            completionHandler(.performDefaultHandling, nil)
        }
    }
}
