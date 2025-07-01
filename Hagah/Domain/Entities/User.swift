//
//  User.swift
//  Hagah
//
//  Created by Donggyun Yang on 7/1/25.
//

import Foundation

enum SignupType: Int {
    case guest = 0
    case kakao = 1
    case apple = 2
}

enum Gender: Int {
    case male = 0
    case female = 1
}

struct User: Identifiable {
    let id: UUID
    let name: String
    let email: String
    let gender: Gender
    let birthday: String
    let signup_type: SignupType
    let created_at: Date
    let state: UserState
    let progress: UserProgress
}

struct UserState: Identifiable {
    let id: UUID
    let alarmToggle: Bool
    let dailyHagahCount: Int
    let updatedAt: Date
}

struct UserProgress: Identifiable {
    let id: UUID
    let streakCount: Int
    let updatedAt: Date
}
