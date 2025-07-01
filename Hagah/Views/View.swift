//
//  View.swift
//  Hagah
//
//  Created by Donggyun Yang on 6/18/25.
//

import SwiftUI

// MARK: - Sign Up View
struct SignUpView: View {
    @EnvironmentObject private var authManager: AuthenticationManager
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            // Logo and tagline
            VStack(spacing: 16) {
                Text("Logo")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.black)
                
                Text("맘속을 되새기다, 하가")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 60)
            
            // Illustration placeholder
            VStack {
                Image(systemName: "figure.walk")
                    .font(.system(size: 120))
                    .foregroundColor(.gray.opacity(0.3))
            }
            .padding(.bottom, 80)
            
            Spacer()
            
            // Login buttons
            VStack(spacing: 16) {
                // Kakao login button
                Button(action: {
                    Task {
                        await authManager.signUp(with: .kakao)
                    }
                }) {
                    HStack {
                        Image(systemName: "message.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                        
                        Text("TALK")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                    }
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.yellow)
                    .cornerRadius(25)
                }
                .disabled(authManager.isLoading)
                
                // Apple login button
                Button(action: {
                    Task {
                        await authManager.signUp(with: .apple)
                    }
                }) {
                    HStack {
                        Image(systemName: "apple.logo")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                    .frame(width: 50, height: 50)
                    .background(Color.black)
                    .cornerRadius(25)
                }
                .disabled(authManager.isLoading)
                
                // Guest login text
                Button(action: {
                    Task {
                        await authManager.signUp(with: .guest)
                    }
                }) {
                    Text("계정 없이 시작할게요")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .underline()
                }
                .disabled(authManager.isLoading)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 50)
            
            // Loading indicator
            if authManager.isLoading {
                ProgressView()
                    .scaleEffect(1.2)
                    .padding()
            }
        }
        .background(Color.white)
        .alert("오류", isPresented: .constant(authManager.errorMessage != nil)) {
            Button("확인") {
                authManager.errorMessage = nil
            }
        } message: {
            if let errorMessage = authManager.errorMessage {
                Text(errorMessage)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    let repository = MockAuthenticationRepository()
    let interactor = SignUpInteractor(authRepository: repository)
    let authManager = AuthenticationManager(signUpInteractor: interactor)
    
    return SignUpView()
        .environmentObject(authManager)
}

