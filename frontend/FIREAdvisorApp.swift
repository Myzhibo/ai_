// FIREAdvisorApp.swift
// 应用入口

import SwiftUI

@main
struct FIREAdvisorApp: App {
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
        }
    }
}
