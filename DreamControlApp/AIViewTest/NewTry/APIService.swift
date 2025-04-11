//
//  APIService.swift
//  DreamControlApp
//
//  Created by Ainur on 10.04.2025.
//


import Foundation

class APIService: NSObject, ObservableObject {  // Наследуем от NSObject
    @Published var responseText: String = "Ожидание ответа..."
    let token = "eyJjdHkiOiJqd3QiLCJlbmMiOiJBMjU2Q0JDLUhTNTEyIiwiYWxnIjoiUlNBLU9BRVAtMjU2In0.CD4lqbAp-TUuDB3cuk3fe7WV2TKgtrZHzNIvfK8kB8YyeSDza2rclJhV9-giKCf0HEWPLpJlM5m91oyYjG3gsudG6KVMzl6hXfKTH9uSnWgIPTiAabmECloou-VdrVT9OHlzMpkB9iLXawYdvMjJYQX2_l0uR8I1Ie3hia2neOGfsUHf4SYA0HcWJAD_NzK9fZn4uVko8dc3H-npSslD854fGWvpoBk61Ue4IB3wmzGqtBXm6ryi0hDUAiAAvxKJYiIaek9KC7quP0N8C6nFc5-LRNFWTt5UociqOv1aAzghpyoqM5tI5iPJ-oy9tDdiBs5Kuw8j_GUBd_NJpRrhnQ.ld3GxG0e93GBYhetewZRrA.FUoSNVUmVz76-jbLUkrTGkzknlA1Lo55PJIJyTPYIwjLm_EKAPIFtkzLXHb2luzmSXx8lwxMctxrnW3mtRy4taEvdX6yo_Tjn41hiN0JSIPABTPc3dTxZoH28VTfjbrI30Xav-H25souqZFXZzgxk1WtXwu3B5D2iuK80nB476Gr7FEVdEQ6pw5r-s7cqmauX5dcgUrIKlxqWcbwKEV8WiwYLWWyiUhXnMRh-120qsL5sxuLjy5zpySkxMoyE1x4OX_vNj05EhGhP7sbFDu07jclx0tvuTk6r7G4UmlP3HfKpAyCmAd1ELOcFn98HQyQTx50I52DWYFUPEIMd5DNTTR2rYkTYw4ncrGg6uIDXrYknSHeKKPkopsXZpnUt_1vFXYRMrqgFRD7LyumtXmNiNW6d9j4UBeRDXIhY-mlD4CL01-NIB64vpSAyJYIFti6fArheP5ZlJHhvtP7-NxRw7Ni2xRyyZTxlxEZO9EeLqMZ4Zfm47Ts-h4T_CG-yTqzw_E4NBEfLiqtGaWEPGcl5SihMisiteTlPButPJFFemwHv5a4JPivFAoS2KXhpRFHL-PoCzV28vy0Ggul-1RL8Ol_qTOlmBbmfBODx2oUj_y7DLJIZqOCmNAEgyrjy4UDvyFu36twTHf1nqwg_HclT0OyvWcvIkja5PDT25PZINzZV9rYSYBNpExbiIiv4SVfdOr5MYJbG_SCgSpEBDiRZTUUKOE7BVjC9VXsUifhEDU.4aTQDthW03epuz09IJMqdV9WnHhAXcRXuZ9z5F4NRU0"

    func fetchData() {
        // URL для запроса
        guard let url = URL(string: "https://ngw.devices.sberbank.ru:9443/api/v2/some_endpoint") else {
            responseText = "Неверный URL"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET" // Если это GET запрос, используйте метод GET
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Игнорировать SSL-сертификат
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.responseText = "Ошибка: \(error.localizedDescription)"
                }
                return
            }

            if let data = data {
                if let responseString = String(data: data, encoding: .utf8) {
                    DispatchQueue.main.async {
                        self.responseText = responseString
                    }
                } else {
                    DispatchQueue.main.async {
                        self.responseText = "Не удалось декодировать ответ"
                    }
                }
            }
        }
        task.resume()
    }
}

extension APIService: URLSessionDelegate {
    // Игнорируем ошибки сертификатов
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}

