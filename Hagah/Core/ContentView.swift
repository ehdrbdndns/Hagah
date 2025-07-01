//
//  ContentView.swift
//  Hagah
//
//  Created by Donggyun Yang on 6/18/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject private var authManager: AuthenticationManager
    
    init() {
        let repository = MockAuthenticationRepository()
        let interactor = SignUpInteractor(authRepository: repository)
        _authManager = StateObject(wrappedValue: AuthenticationManager(signUpInteractor: interactor))
    }
    
    var body: some View {
        Group {
            if let user = authManager.currentUser {
                MainView(user: user)
                    .environmentObject(authManager)
            } else {
                SignUpView()
                    .environmentObject(authManager)
            }
        }
    }
}

#Preview {
    ContentView()
}
