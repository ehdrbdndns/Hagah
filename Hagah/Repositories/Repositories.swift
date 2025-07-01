//
//  Repositories.swift
//  Hagah
//
//  Created by Donggyun Yang on 6/18/25.
//

import Foundation

// MARK: - Authentication Repository Protocol
protocol AuthenticationRepository {
    func loginWithKakao() async -> AuthenticationResult
    func loginWithApple() async -> AuthenticationResult
    func loginAsGuest() async -> AuthenticationResult
    func logout() async -> Bool
    func getCurrentUser() -> User?
}

// MARK: - Mock Authentication Repository
class MockAuthenticationRepository: AuthenticationRepository {
    private var currentUser: User?
    
    func loginWithKakao() async -> AuthenticationResult {
        // Simulate network delay
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        // Mock successful Kakao login
        let user = User(
            id: "kakao_\(UUID().uuidString)",
            name: "카카오 사용자",
            email: "user@kakao.com",
            authMethod: .kakao
        )
        currentUser = user
        return .success(user)
    }
    
    func loginWithApple() async -> AuthenticationResult {
        // Simulate network delay
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        // Mock successful Apple login
        let user = User(
            id: "apple_\(UUID().uuidString)",
            name: "Apple 사용자",
            email: "user@icloud.com",
            authMethod: .apple
        )
        currentUser = user
        return .success(user)
    }
    
    func loginAsGuest() async -> AuthenticationResult {
        // Mock guest login (instant)
        let user = User(
            id: "guest_\(UUID().uuidString)",
            name: nil,
            email: nil,
            authMethod: .guest
        )
        currentUser = user
        return .success(user)
    }
    
    func logout() async -> Bool {
        currentUser = nil
        return true
    }
    
    func getCurrentUser() -> User? {
        return currentUser
    }
}
