import Foundation

protocol RegisterUserRepository {
    func register(user: User) async throws -> User
} 