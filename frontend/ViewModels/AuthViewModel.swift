// AuthViewModel.swift
// 认证 ViewModel

import Foundation
import SwiftUI

@MainActor
class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    init() {
        checkAuthStatus()
    }
    
    func checkAuthStatus() {
        isAuthenticated = KeychainManager.shared.hasToken()
        if isAuthenticated {
            Task {
                await fetchCurrentUser()
            }
        }
    }
    
    func login(email: String, password: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await APIClient.shared.login(email: email, password: password)
            currentUser = response.user
            isAuthenticated = true
        } catch {
            errorMessage = "登录失败,请检查邮箱和密码"
            print("Login error:", error)
        }
        
        isLoading = false
    }
    
    func register(email: String, password: String, username: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await APIClient.shared.register(
                email: email,
                password: password,
                username: username
            )
            currentUser = response.user
            isAuthenticated = true
        } catch {
            errorMessage = "注册失败,该邮箱可能已被使用"
            print("Register error:", error)
        }
        
        isLoading = false
    }
    
    func logout() {
        KeychainManager.shared.deleteToken()
        currentUser = nil
        isAuthenticated = false
    }
    
    private func fetchCurrentUser() async {
        do {
            currentUser = try await APIClient.shared.getMe()
        } catch {
            // Token 可能过期,退出登录
            logout()
        }
    }
}
