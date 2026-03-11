// User.swift
// 用户数据模型

import Foundation

struct User: Codable, Identifiable {
    let id: String
    let email: String
    let username: String
    let avatarUrl: String?
    let fireProfile: FIREProfile?
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case username
        case avatarUrl = "avatar_url"
        case fireProfile = "fire_profile"
    }
}

struct FIREProfile: Codable {
    let currentAge: Int
    let targetFireAge: Int
    let currentSavings: Double
    let monthlyIncome: Double
    let monthlyExpenses: Double
    let savingsRate: Double
    let fireNumber: Double
    let riskTolerance: String
    
    enum CodingKeys: String, CodingKey {
        case currentAge = "current_age"
        case targetFireAge = "target_fire_age"
        case currentSavings = "current_savings"
        case monthlyIncome = "monthly_income"
        case monthlyExpenses = "monthly_expenses"
        case savingsRate = "savings_rate"
        case fireNumber = "fire_number"
        case riskTolerance = "risk_tolerance"
    }
}

struct FIREProgress: Codable {
    let fireNumber: Double
    let currentSavings: Double
    let progress: Double
    let savingsRate: Double
    let monthlyIncome: Double
    let monthlyExpenses: Double
    let monthlySavings: Double
    let yearsToFire: Double
    let projectedFireAge: Int
    let onTrack: Bool
    
    enum CodingKeys: String, CodingKey {
        case fireNumber = "fire_number"
        case currentSavings = "current_savings"
        case progress
        case savingsRate = "savings_rate"
        case monthlyIncome = "monthly_income"
        case monthlyExpenses = "monthly_expenses"
        case monthlySavings = "monthly_savings"
        case yearsToFire = "years_to_fire"
        case projectedFireAge = "projected_fire_age"
        case onTrack = "on_track"
    }
}

struct AuthResponse: Codable {
    let token: String
    let user: User
}
