//
//  Authentication.swift
//  Hagah
//
//  Created by Donggyun Yang on 6/18/25.
//

import Foundation

// MARK: - Authentication Types
enum AuthenticationMethod {
    case kakao
    case apple
    case guest
}

enum AuthenticationError: Error {
    case cancelled
    case failed(String)
    case networkError
    case invalidCredentials
}

// MARK: - User Model
struct User {
    let id: String
    let name: String?
    let email: String?
    let authMethod: AuthenticationMethod
    let isGuest: Bool
    
    init(id: String, name: String? = nil, email: String? = nil, authMethod: AuthenticationMethod) {
        self.id = id
        self.name = name
        self.email = email
        self.authMethod = authMethod
        self.isGuest = authMethod == .guest
    }
}

// MARK: - Authentication Result
enum AuthenticationResult {
    case success(User)
    case failure(AuthenticationError)
}