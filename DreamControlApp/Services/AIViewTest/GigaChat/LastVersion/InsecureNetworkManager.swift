//
//  InsecureNetworkManager.swift
//  DreamControlApp
//
//  Created by Ainur on 10.04.2025.
//


import Foundation

class InsecureNetworkManager: NSObject {
    private var session: URLSession!
    
    override init() {
        super.init()
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }
    
    func fetchData(for request: URLRequest) async throws -> Data {
        let (data, res) = try await session.data(for: request) // session.dataTask(with: request) { data, _, error in
        return data
    }
}

// MARK: - Отключаем проверку SSL
extension InsecureNetworkManager: URLSessionDelegate {
    func urlSession(
        _ session: URLSession,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
    ) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
           let trust = challenge.protectionSpace.serverTrust {
            let credential = URLCredential(trust: trust)
            completionHandler(.useCredential, credential)
        } else {
            completionHandler(.performDefaultHandling, nil)
        }
    }
}
