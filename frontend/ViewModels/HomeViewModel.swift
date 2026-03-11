// HomeViewModel.swift
// 首页 ViewModel

import Foundation
import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    @Published var fireProgress: FIREProgress?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showProfileSetup = false
    
    func fetchProgress() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let progress = try await APIClient.shared.getFIREProgress()
            fireProgress = progress
            
            // 如果 FIRE 数字为 0,说明还没设置档案
            if progress.fireNumber == 0 {
                showProfileSetup = true
            }
        } catch {
            errorMessage = "加载数据失败"
            print("Fetch progress error:", error)
        }
        
        isLoading = false
    }
    
    func updateProfile(
        currentAge: Int,
        targetFireAge: Int,
        currentSavings: Double,
        monthlyIncome: Double,
        monthlyExpenses: Double
    ) async {
        isLoading = true
        errorMessage = nil
        
        do {
            _ = try await APIClient.shared.updateFIREProfile(
                currentAge: currentAge,
                targetFireAge: targetFireAge,
                currentSavings: currentSavings,
                monthlyIncome: monthlyIncome,
                monthlyExpenses: monthlyExpenses
            )
            
            // 重新加载进度
            await fetchProgress()
            showProfileSetup = false
        } catch {
            errorMessage = "更新档案失败"
            print("Update profile error:", error)
        }
        
        isLoading = false
    }
    
    // 格式化货币
    func formatCurrency(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: amount)) ?? "$0"
    }
    
    // 格式化百分比
    func formatPercentage(_ value: Double) -> String {
        return String(format: "%.1f%%", value)
    }
}
