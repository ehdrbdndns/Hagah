//
//  HagahTests.swift
//  HagahTests
//
//  Created by Donggyun Yang on 6/18/25.
//

import Testing
@testable import Hagah

struct HagahTests {

    @Test func signUpWithKakaoSucceeds() async throws {
        // Given
        let repository = MockAuthenticationRepository()
        let interactor = SignUpInteractor(authRepository: repository)
        
        // When
        let result = await interactor.signUpWithKakao()
        
        // Then
        switch result {
        case .success(let user):
            #expect(user.authMethod == .kakao)
            #expect(user.isGuest == false)
            #expect(user.name != nil)
        case .failure:
            Issue.record("Expected success but got failure")
        }
    }
    
    @Test func signUpWithAppleSucceeds() async throws {
        // Given
        let repository = MockAuthenticationRepository()
        let interactor = SignUpInteractor(authRepository: repository)
        
        // When
        let result = await interactor.signUpWithApple()
        
        // Then
        switch result {
        case .success(let user):
            #expect(user.authMethod == .apple)
            #expect(user.isGuest == false)
            #expect(user.name != nil)
        case .failure:
            Issue.record("Expected success but got failure")
        }
    }
    
    @Test func signUpAsGuestSucceeds() async throws {
        // Given
        let repository = MockAuthenticationRepository()
        let interactor = SignUpInteractor(authRepository: repository)
        
        // When
        let result = await interactor.signUpAsGuest()
        
        // Then
        switch result {
        case .success(let user):
            #expect(user.authMethod == .guest)
            #expect(user.isGuest == true)
            #expect(user.name == nil)
        case .failure:
            Issue.record("Expected success but got failure")
        }
    }
    
    @Test func logoutSucceeds() async throws {
        // Given
        let repository = MockAuthenticationRepository()
        let interactor = SignUpInteractor(authRepository: repository)
        
        // First login
        let _ = await interactor.signUpWithKakao()
        
        // When
        let success = await interactor.logout()
        
        // Then
        #expect(success == true)
        #expect(repository.getCurrentUser() == nil)
    }
}
