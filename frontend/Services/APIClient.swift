// APIClient.swift
// 网络请求客户端

import Foundation
import Alamofire

class APIClient {
    static let shared = APIClient()
    
    // 修改为你的后端地址
    // 如果使用模拟器,可能需要使用你的 Mac IP 地址
    private let baseURL = "http://localhost:3000/api"
    
    private init() {}
    
    // MARK: - Auth APIs
    
    func register(email: String, password: String, username: String) async throws -> AuthResponse {
        let parameters: [String: Any] = [
            "email": email,
            "password": password,
            "username": username
        ]
        
        return try await request(
            endpoint: "/auth/register",
            method: .post,
            parameters: parameters
        )
    }
    
    func login(email: String, password: String) async throws -> AuthResponse {
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        let response: AuthResponse = try await request(
            endpoint: "/auth/login",
            method: .post,
            parameters: parameters
        )
        
        // 保存 token
        KeychainManager.shared.saveToken(response.token)
        
        return response
    }
    
    func getMe() async throws -> User {
        struct UserResponse: Codable {
            let user: User
        }
        
        let response: UserResponse = try await request(
            endpoint: "/auth/me",
            method: .get,
            requiresAuth: true
        )
        
        return response.user
    }
    
    // MARK: - FIRE APIs
    
    func getFIREProfile() async throws -> FIREProfile? {
        struct ProfileResponse: Codable {
            let fire_profile: FIREProfile?
        }
        
        let response: ProfileResponse = try await request(
            endpoint: "/fire/profile",
            method: .get,
            requiresAuth: true
        )
        
        return response.fire_profile
    }
    
    func updateFIREProfile(
        currentAge: Int,
        targetFireAge: Int,
        currentSavings: Double,
        monthlyIncome: Double,
        monthlyExpenses: Double,
        riskTolerance: String = "moderate"
    ) async throws -> FIREProfile {
        let parameters: [String: Any] = [
            "current_age": currentAge,
            "target_fire_age": targetFireAge,
            "current_savings": currentSavings,
            "monthly_income": monthlyIncome,
            "monthly_expenses": monthlyExpenses,
            "risk_tolerance": riskTolerance
        ]
        
        struct ProfileResponse: Codable {
            let fire_profile: FIREProfile
        }
        
        let response: ProfileResponse = try await request(
            endpoint: "/fire/profile",
            method: .post,
            parameters: parameters,
            requiresAuth: true
        )
        
        return response.fire_profile
    }
    
    func getFIREProgress() async throws -> FIREProgress {
        return try await request(
            endpoint: "/fire/progress",
            method: .get,
            requiresAuth: true
        )
    }
    
    // MARK: - Generic Request
    
    private func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        requiresAuth: Bool = false
    ) async throws -> T {
        let url = baseURL + endpoint
        
        var headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        if requiresAuth, let token = KeychainManager.shared.getToken() {
            headers.add(name: "Authorization", value: "Bearer \(token)")
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                url,
                method: method,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: headers
            )
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    continuation.resume(returning: value)
                case .failure(let error):
                    print("❌ API Error:", error.localizedDescription)
                    if let data = response.data, let str = String(data: data, encoding: .utf8) {
                        print("Response:", str)
                    }
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
