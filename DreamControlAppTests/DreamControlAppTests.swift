//
//  DreamControlAppTests.swift
//  DreamControlAppTests
//
//  Created by Artem on 5/27/25.
//

import Testing
@testable import DreamControlApp

struct DreamControlAppTests {

    @Test func example() async throws {
        let token = try await TokenManager.shared.getToken()
        #expect(!token.isEmpty)
        
        
        let prompt = await NewStoryView.getFinalPrompt(description: "Милый дом", savedName: "Хочу свой дом")
        #expect(!prompt.isEmpty)
        
        let dream = try await APIService().send(prompt: prompt, with: token)
        #expect(!dream.isEmpty)
        #expect(dream.contains("дом"))
    }

}
