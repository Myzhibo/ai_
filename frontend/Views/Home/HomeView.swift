// HomeView.swift
// 首页 FIRE 仪表盘

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            Color.backgroundDark
                .ignoresSafeArea()
            
            if viewModel.isLoading && viewModel.fireProgress == nil {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .fireGreen))
            } else if let progress = viewModel.fireProgress {
                ScrollView {
                    VStack(spacing: FIRESpacing.xl) {
                        // Header
                        headerView
                        
                        // FIRE 进度环形图
                        FIREProgressRingView(progress: progress)
                            .padding(.vertical, FIRESpacing.xl)
                        
                        // 关键指标卡片
                        metricsGridView(progress: progress)
                        
                        // 月度概览
                        monthlyOverviewView(progress: progress)
                        
                        Spacer(minLength: 100)
                    }
                    .padding(FIRESpacing.xl)
                }
            } else {
                // 空状态 - 需要设置档案
                emptyStateView
            }
        }
        .sheet(isPresented: $viewModel.showProfileSetup) {
            ProfileSetupView(viewModel: viewModel)
        }
        .task {
            await viewModel.fetchProgress()
        }
        .refreshable {
            await viewModel.fetchProgress()
        }
    }
    
    // MARK: - Header
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: FIRESpacing.xs) {
                Text("FIRE Dashboard")
                    .font(.fireHeading2)
                    .foregroundColor(.textPrimary)
                
                Text("你好, \(authViewModel.currentUser?.username ?? "User")")
                    .font(.fireBody)
                    .foregroundColor(.textSecondary)
            }
            
            Spacer()
            
            Button(action: { viewModel.showProfileSetup = true }) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.textSecondary)
            }
        }
    }
    
    // MARK: - 指标卡片网格
    private func metricsGridView(progress: FIREProgress) -> some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: FIRESpacing.lg) {
            MetricCard(
                title: "FIRE 数字",
                value: viewModel.formatCurrency(progress.fireNumber),
                icon: "target",
                color: .fireGreen
            )
            
            MetricCard(
                title: "当前储蓄",
                value: viewModel.formatCurrency(progress.currentSavings),
                icon: "dollarsign.circle.fill",
                color: .blue
            )
            
            MetricCard(
                title: "储蓄率",
                value: viewModel.formatPercentage(progress.savingsRate),
                icon: "chart.line.uptrend.xyaxis",
                color: .purple
            )
            
            MetricCard(
                title: "预计 FIRE",
                value: "\(progress.projectedFireAge) 岁",
                icon: "calendar",
                color: progress.onTrack ? .green : .orange
            )
        }
    }
    
    // MARK: - 月度概览
    private func monthlyOverviewView(progress: FIREProgress) -> some View {
        VStack(alignment: .leading, spacing: FIRESpacing.lg) {
            Text("月度概览")
                .font(.fireHeading2)
                .foregroundColor(.textPrimary)
            
            VStack(spacing: FIRESpacing.md) {
                MonthlyRow(
                    icon: "arrow.down.circle.fill",
                    title: "月收入",
                    amount: viewModel.formatCurrency(progress.monthlyIncome),
                    color: .green
                )
                
                MonthlyRow(
                    icon: "arrow.up.circle.fill",
                    title: "月支出",
                    amount: viewModel.formatCurrency(progress.monthlyExpenses),
                    color: .red
                )
                
                Divider()
                    .background(Color.borderPrimary)
                
                MonthlyRow(
                    icon: "plus.circle.fill",
                    title: "月储蓄",
                    amount: viewModel.formatCurrency(progress.monthlySavings),
                    color: .fireGreen
                )
            }
            .padding(FIRESpacing.lg)
            .background(Color.backgroundCard)
            .cornerRadius(FIRERadius.medium)
            .overlay(
                RoundedRectangle(cornerRadius: FIRERadius.medium)
                    .stroke(Color.borderGlow, lineWidth: 1)
            )
        }
    }
    
    // MARK: - 空状态
    private var emptyStateView: some View {
        VStack(spacing: FIRESpacing.xl) {
            Image(systemName: "flame")
                .font(.system(size: 80))
                .foregroundColor(.fireGreen.opacity(0.3))
            
            Text("开始你的 FIRE 之旅")
                .font(.fireHeading2)
                .foregroundColor(.textPrimary)
            
            Text("设置你的财务档案,追踪 FIRE 进度")
                .font(.fireBody)
                .foregroundColor(.textSecondary)
                .multilineTextAlignment(.center)
            
            Button(action: { viewModel.showProfileSetup = true }) {
                Text("设置档案")
                    .font(.fireBodySemiBold)
                    .foregroundColor(.backgroundDark)
                    .padding(.horizontal, FIRESpacing.xxl)
                    .padding(.vertical, FIRESpacing.lg)
                    .background(Color.fireGreen)
                    .cornerRadius(FIRERadius.pill)
            }
        }
        .padding(FIRESpacing.xl)
    }
}

// MARK: - 指标卡片组件
struct MetricCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: FIRESpacing.sm) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                Spacer()
            }
            
            Text(value)
                .font(.fireHeading2)
                .foregroundColor(.textPrimary)
            
            Text(title)
                .font(.fireCaption)
                .foregroundColor(.textSecondary)
        }
        .padding(FIRESpacing.lg)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.backgroundCard)
        .cornerRadius(FIRERadius.medium)
        .overlay(
            RoundedRectangle(cornerRadius: FIRERadius.medium)
                .stroke(Color.borderPrimary, lineWidth: 1)
        )
    }
}

// MARK: - 月度行组件
struct MonthlyRow: View {
    let icon: String
    let title: String
    let amount: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 20))
            
            Text(title)
                .font(.fireBody)
                .foregroundColor(.textSecondary)
            
            Spacer()
            
            Text(amount)
                .font(.fireBodySemiBold)
                .foregroundColor(.textPrimary)
        }
    }
}
