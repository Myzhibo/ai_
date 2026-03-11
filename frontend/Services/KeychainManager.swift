// KeychainManager.swift
// Keychain 安全存储管理

import Foundation
import KeychainSwift

class KeychainManager {
    static let shared = KeychainManager()
    private let keychain = KeychainSwift()
    
    private let tokenKey = "fire_advisor_token"
    
    private init() {}
    
    func saveToken(_ token: String) {
        keychain.set(token, forKey: tokenKey)
    }
    
    func getToken() -> String? {
        return keychain.get(tokenKey)
    }
    
    func deleteToken() {
        keychain.delete(tokenKey)
    }
    
    func hasToken() -> Bool {
        return getToken() != nil
    }
}
