// Colors.swift
// FIRE Advisor 设计系统 - 颜色

import SwiftUI

extension Color {
    // MARK: - Primary Colors
    static let fireGreen = Color(hex: "#13EC5B")
    static let fireGreenLight = Color(hex: "#13EC5B").opacity(0.2)
    static let fireGreenBorder = Color(hex: "#13EC5B").opacity(0.3)
    
    // MARK: - Background Colors
    static let backgroundDark = Color(hex: "#102216")
    static let backgroundCard = Color(hex: "#23482F")
    static let backgroundInput = Color(hex: "#1A2E21")
    
    // MARK: - Border Colors
    static let borderPrimary = Color(hex: "#1E293B")
    static let borderLight = Color.white.opacity(0.05)
    static let borderGlow = Color(hex: "#13EC5B").opacity(0.1)
    
    // MARK: - Text Colors
    static let textPrimary = Color(hex: "#F1F5F9")
    static let textSecondary = Color(hex: "#64748B")
    static let textMuted = Color(hex: "#94A3B8")
    
    // MARK: - Status Colors
    static let statusOnline = Color(hex: "#13EC5B")
    static let statusOffline = Color(hex: "#64748B")
    
    // MARK: - Helper Initializer
    init(hex: String, opacity: Double = 1.0) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (r, g, b) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: opacity
        )
    }
}
