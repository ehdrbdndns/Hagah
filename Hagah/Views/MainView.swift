//
//  MainView.swift
//  Hagah
//
//  Created by Donggyun Yang on 6/18/25.
//

import SwiftUI

struct MainView: View {
    let user: User
    @EnvironmentObject private var authManager: AuthenticationManager
    @State private var showingLogoutAlert = false
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // Welcome message
            VStack(spacing: 8) {
                Text("환영합니다!")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.black)
                
                if let name = user.name {
                    Text("\(name)님")
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                } else if user.isGuest {
                    Text("게스트님")
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                }
            }
            
            // User info
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("로그인 방법:")
                        .font(.system(size: 16, weight: .medium))
                    Spacer()
                    Text(authMethodText)
                        .font(.system(size: 16))
                        .foregroundColor(.blue)
                }
                
                if let email = user.email {
                    HStack {
                        Text("이메일:")
                            .font(.system(size: 16, weight: .medium))
                        Spacer()
                        Text(email)
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                }
                
                HStack {
                    Text("사용자 ID:")
                        .font(.system(size: 16, weight: .medium))
                    Spacer()
                    Text(user.id.prefix(8) + "...")
                        .font(.system(size: 16, family: .monospaced))
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            .padding(.horizontal, 40)
            
            Spacer()
            
            // Logout button
            Button(action: {
                showingLogoutAlert = true
            }) {
                Text("로그아웃")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.red)
                    .frame(height: 44)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.red, lineWidth: 1)
                    )
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 50)
        }
        .background(Color.white)
        .alert("로그아웃", isPresented: $showingLogoutAlert) {
            Button("취소", role: .cancel) { }
            Button("로그아웃", role: .destructive) {
                Task {
                    await authManager.logout()
                }
            }
        } message: {
            Text("정말 로그아웃하시겠습니까?")
        }
    }
    
    private var authMethodText: String {
        switch user.authMethod {
        case .kakao:
            return "카카오톡"
        case .apple:
            return "Apple"
        case .guest:
            return "게스트"
        }
    }
}

#Preview {
    let repository = MockAuthenticationRepository()
    let interactor = SignUpInteractor(authRepository: repository)
    let authManager = AuthenticationManager(signUpInteractor: interactor)
    
    return MainView(user: User(id: "test123", name: "테스트 사용자", email: "test@example.com", authMethod: .kakao))
        .environmentObject(authManager)
}