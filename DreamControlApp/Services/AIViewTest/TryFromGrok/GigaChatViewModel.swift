//
//  GigaChatViewModel.swift
//  DreamControlApp
//
//  Created by Ainur on 10.04.2025.
//


import Foundation

class GigaChatViewModel: ObservableObject {
    @Published var responseText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let accessToken = "eyJjdHkiOiJqd3QiLCJlbmMiOiJBMjU2Q0JDLUhTNTEyIiwiYWxnIjoiUlNBLU9BRVAtMjU2In0.CD4lqbAp-TUuDB3cuk3fe7WV2TKgtrZHzNIvfK8kB8YyeSDza2rclJhV9-giKCf0HEWPLpJlM5m91oyYjG3gsudG6KVMzl6hXfKTH9uSnWgIPTiAabmECloou-VdrVT9OHlzMpkB9iLXawYdvMjJYQX2_l0uR8I1Ie3hia2neOGfsUHf4SYA0HcWJAD_NzK9fZn4uVko8dc3H-npSslD854fGWvpoBk61Ue4IB3wmzGqtBXm6ryi0hDUAiAAvxKJYiIaek9KC7quP0N8C6nFc5-LRNFWTt5UociqOv1aAzghpyoqM5tI5iPJ-oy9tDdiBs5Kuw8j_GUBd_NJpRrhnQ.ld3GxG0e93GBYhetewZRrA.FUoSNVUmVz76-jbLUkrTGkzknlA1Lo55PJIJyTPYIwjLm_EKAPIFtkzLXHb2luzmSXx8lwxMctxrnW3mtRy4taEvdX6yo_Tjn41hiN0JSIPABTPc3dTxZoH28VTfjbrI30Xav-H25souqZFXZzgxk1WtXwu3B5D2iuK80nB476Gr7FEVdEQ6pw5r-s7cqmauX5dcgUrIKlxqWcbwKEV8WiwYLWWyiUhXnMRh-120qsL5sxuLjy5zpySkxMoyE1x4OX_vNj05EhGhP7sbFDu07jclx0tvuTk6r7G4UmlP3HfKpAyCmAd1ELOcFn98HQyQTx50I52DWYFUPEIMd5DNTTR2rYkTYw4ncrGg6uIDXrYknSHeKKPkopsXZpnUt_1vFXYRMrqgFRD7LyumtXmNiNW6d9j4UBeRDXIhY-mlD4CL01-NIB64vpSAyJYIFti6fArheP5ZlJHhvtP7-NxRw7Ni2xRyyZTxlxEZO9EeLqMZ4Zfm47Ts-h4T_CG-yTqzw_E4NBEfLiqtGaWEPGcl5SihMisiteTlPButPJFFemwHv5a4JPivFAoS2KXhpRFHL-PoCzV28vy0Ggul-1RL8Ol_qTOlmBbmfBODx2oUj_y7DLJIZqOCmNAEgyrjy4UDvyFu36twTHf1nqwg_HclT0OyvWcvIkja5PDT25PZINzZV9rYSYBNpExbiIiv4SVfdOr5MYJbG_SCgSpEBDiRZTUUKOE7BVjC9VXsUifhEDU.4aTQDthW03epuz09IJMqdV9WnHhAXcRXuZ9z5F4NRU0"
    
    func fetchStory(prompt: String) {
        isLoading = true
        errorMessage = nil
        
        guard let url = URL(string: "https://ngw.devices.sberbank.ru:9443/api/v2/oauth") else {
            errorMessage = "Неверный URL"
            isLoading = false
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "model": "GigaChat",
            "messages": [
                [
                    "role": "user",
                    "content": prompt
                ]
            ],
            "temperature": 0.7
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            errorMessage = "Ошибка сериализации: \(error.localizedDescription)"
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.errorMessage = "Ошибка запроса: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data else {
                    self?.errorMessage = "Нет данных в ответе"
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(GigaChatResponse.self, from: data)
                    self?.responseText = result.choices.first?.message.content ?? "Нет ответа"
                } catch {
                    self?.errorMessage = "Ошибка декодирования: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}
