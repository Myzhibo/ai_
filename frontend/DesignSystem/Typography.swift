// Typography.swift
// FIRE Advisor 设计系统 - 字体

import SwiftUI

extension Font {
    // MARK: - Headings
    static let fireHeading1 = Font.system(size: 14, weight: .bold, design: .rounded)
    static let fireHeading2 = Font.system(size: 20, weight: .bold, design: .rounded)
    static let fireHeading3 = Font.system(size: 24, weight: .bold, design: .rounded)
    
    // MARK: - Body
    static let fireBody = Font.system(size: 14, weight: .regular, design: .rounded)
    static let fireBodyMedium = Font.system(size: 14, weight: .medium, design: .rounded)
    static let fireBodySemiBold = Font.system(size: 14, weight: .semibold, design: .rounded)
    
    // MARK: - Caption
    static let fireCaption = Font.system(size: 11, weight: .bold, design: .rounded)
    static let fireCaptionSmall = Font.system(size: 10, weight: .bold, design: .rounded)
    
    // MARK: - Numbers (用于显示金额和百分比)
    static let fireNumber = Font.system(size: 32, weight: .bold, design: .rounded)
    static let fireNumberLarge = Font.system(size: 48, weight: .bold, design: .rounded)
}

// MARK: - Spacing
struct FIRESpacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
    static let xl: CGFloat = 24
    static let xxl: CGFloat = 32
}

// MARK: - Corner Radius
struct FIRERadius {
    static let small: CGFloat = 8
    static let medium: CGFloat = 12
    static let large: CGFloat = 16
    static let pill: CGFloat = 9999
}

// MARK: - Shadow Extension
extension View {
    func fireGlow() -> some View {
        self.shadow(color: Color.fireGreen.opacity(0.2), radius: 15, x: 0, y: 0)
    }
    
    func fireButtonShadow() -> some View {
        self.shadow(color: Color.fireGreen.opacity(0.2), radius: 10, x: 0, y: 10)
    }
}
