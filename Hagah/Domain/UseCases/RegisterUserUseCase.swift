//
//  register.swift
//  Hagah
//
//  Created by Donggyun Yang on 7/2/25.
//

import Foundation

protocol RegisterUserUseCase {
    func execute(user: User) async throws -> User
}

final class RegisterUserUseCaseImpl: RegisterUserUseCase {
    private let repository: RegisterUserRepository
    
    init(repository: RegisterUserRepository) {
        self.repository = repository
    }
    
    func execute(user: User) async throws -> User {
        return try await repository.register(user: user)
    }
}
