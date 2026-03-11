// ProfileSetupView.swift
// FIRE 档案设置界面

import SwiftUI

struct ProfileSetupView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var currentAge = "30"
    @State private var targetFireAge = "40"
    @State private var currentSavings = "50000"
    @State private var monthlyIncome = "5000"
    @State private var monthlyExpenses = "2500"
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundDark
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: FIRESpacing.xl) {
                        // 说明
                        VStack(spacing: FIRESpacing.sm) {
                            Image(systemName: "flame.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.fireGreen)
                            
                            Text("设置你的 FIRE 档案")
                                .font(.fireHeading2)
                                .foregroundColor(.textPrimary)
                            
                            Text("填写基本财务信息,我们将计算你的 FIRE 进度")
                                .font(.fireBody)
                                .foregroundColor(.textSecondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, FIRESpacing.xl)
                        
                        // 表单
                        VStack(spacing: FIRESpacing.lg) {
                            FIRENumberField(
                                title: "当前年龄",
                                value: $currentAge,
                                placeholder: "30",
                                unit: "岁"
                            )
                            
                            FIRENumberField(
                                title: "目标 FIRE 年龄",
                                value: $targetFireAge,
                                placeholder: "40",
                                unit: "岁"
                            )
                            
                            FIRENumberField(
                                title: "当前储蓄",
                                value: $currentSavings,
                                placeholder: "50000",
                                unit: "$"
                            )
                            
                            FIRENumberField(
                                title: "月收入",
                                value: $monthlyIncome,
                                placeholder: "5000",
                                unit: "$"
                            )
                            
                            FIRENumberField(
                                title: "月支出",
                                value: $monthlyExpenses,
                                placeholder: "2500",
                                unit: "$"
                            )
                            
                            // 储蓄率预览
                            if let income = Double(monthlyIncome),
                               let expenses = Double(monthlyExpenses),
                               income > 0 {
                                let savingsRate = ((income - expenses) / income) * 100
                                HStack {
                                    Text("预计储蓄率:")
                                        .font(.fireBody)
                                        .foregroundColor(.textSecondary)
                                    
                                    Spacer()
                                    
                                    Text(String(format: "%.1f%%", savingsRate))
                                        .font(.fireHeading2)
                                        .foregroundColor(.fireGreen)
                                }
                                .padding(FIRESpacing.lg)
                                .background(Color.backgroundCard)
                                .cornerRadius(FIRERadius.medium)
                            }
                            
                            Button(action: saveProfile) {
                                if viewModel.isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .backgroundDark))
                                } else {
                                    Text("保存档案")
                                        .font(.fireBodySemiBold)
                                        .foregroundColor(.backgroundDark)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, FIRESpacing.lg)
                            .background(Color.fireGreen)
                            .cornerRadius(FIRERadius.pill)
                            .disabled(viewModel.isLoading || !isFormValid)
                        }
                        .padding(.horizontal, FIRESpacing.xl)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("取消") {
                        dismiss()
                    }
                    .foregroundColor(.fireGreen)
                }
            }
        }
    }
    
    private var isFormValid: Bool {
        Int(currentAge) != nil &&
        Int(targetFireAge) != nil &&
        Double(currentSavings) != nil &&
        Double(monthlyIncome) != nil &&
        Double(monthlyExpenses) != nil
    }
    
    private func saveProfile() {
        guard let age = Int(currentAge),
              let fireAge = Int(targetFireAge),
              let savings = Double(currentSavings),
              let income = Double(monthlyIncome),
              let expenses = Double(monthlyExpenses) else {
            return
        }
        
        Task {
            await viewModel.updateProfile(
                currentAge: age,
                targetFireAge: fireAge,
                currentSavings: savings,
                monthlyIncome: income,
                monthlyExpenses: expenses
            )
            
            if viewModel.errorMessage == nil {
                dismiss()
            }
        }
    }
}

// MARK: - 数字输入框组件
struct FIRENumberField: View {
    let title: String
    @Binding var value: String
    let placeholder: String
    let unit: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: FIRESpacing.sm) {
            Text(title)
                .font(.fireCaption)
                .foregroundColor(.textSecondary)
                .textCase(.uppercase)
            
            HStack {
                if unit == "$" {
                    Text("$")
                        .font(.fireBody)
                        .foregroundColor(.textSecondary)
                }
                
                TextField(placeholder, text: $value)
                    .font(.fireBody)
                    .foregroundColor(.textPrimary)
                    .keyboardType(.numberPad)
                
                if unit != "$" {
                    Text(unit)
                        .font(.fireBody)
                        .foregroundColor(.textSecondary)
                }
            }
            .padding(FIRESpacing.lg)
            .background(Color.backgroundInput)
            .cornerRadius(FIRERadius.medium)
            .overlay(
                RoundedRectangle(cornerRadius: FIRERadius.medium)
                    .stroke(Color.borderLight, lineWidth: 1)
            )
        }
    }
}
