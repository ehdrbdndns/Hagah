//
//  Interactors.swift
//  Hagah
//
//  Created by Donggyun Yang on 6/18/25.
//

import Foundation

// MARK: - Sign Up Use Cases
class SignUpInteractor {
    private let authRepository: AuthenticationRepository
    
    init(authRepository: AuthenticationRepository) {
        self.authRepository = authRepository
    }
    
    func signUpWithKakao() async -> AuthenticationResult {
        return await authRepository.loginWithKakao()
    }
    
    func signUpWithApple() async -> AuthenticationResult {
        return await authRepository.loginWithApple()
    }
    
    func signUpAsGuest() async -> AuthenticationResult {
        return await authRepository.loginAsGuest()
    }
    
    func logout() async -> Bool {
        return await authRepository.logout()
    }
}

// MARK: - Authentication State Manager
@MainActor
class AuthenticationManager: ObservableObject {
    @Published var currentUser: User?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let signUpInteractor: SignUpInteractor
    
    init(signUpInteractor: SignUpInteractor) {
        self.signUpInteractor = signUpInteractor
    }
    
    func signUp(with method: AuthenticationMethod) async {
        isLoading = true
        errorMessage = nil
        
        let result: AuthenticationResult
        
        switch method {
        case .kakao:
            result = await signUpInteractor.signUpWithKakao()
        case .apple:
            result = await signUpInteractor.signUpWithApple()
        case .guest:
            result = await signUpInteractor.signUpAsGuest()
        }
        
        switch result {
        case .success(let user):
            currentUser = user
        case .failure(let error):
            errorMessage = errorDescription(for: error)
        }
        
        isLoading = false
    }
    
    func logout() async {
        isLoading = true
        
        // Call repository logout
        let success = await signUpInteractor.logout()
        
        if success {
            currentUser = nil
        }
        
        isLoading = false
    }
    
    private func errorDescription(for error: AuthenticationError) -> String {
        switch error {
        case .cancelled:
            return "로그인이 취소되었습니다"
        case .failed(let message):
            return message
        case .networkError:
            return "네트워크 오류가 발생했습니다"
        case .invalidCredentials:
            return "잘못된 인증 정보입니다"
        }
    }
}

