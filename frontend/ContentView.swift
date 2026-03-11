// ContentView.swift
// 主视图 - 根据认证状态显示登录或主界面

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
            if authViewModel.isAuthenticated {
                MainTabView()
            } else {
                LoginView()
            }
        }
    }
}

// MARK: - 主标签页视图
struct MainTabView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            Color.backgroundDark
                .ignoresSafeArea()
            
            TabView(selection: $selectedTab) {
                // Home 标签
                NavigationView {
                    HomeView()
                        .navigationBarHidden(true)
                }
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                    Text("Home")
                }
                .tag(0)
                
                // Plan 标签 (占位)
                NavigationView {
                    PlaceholderView(title: "Plan", icon: "chart.line.uptrend.xyaxis")
                }
                .tabItem {
                    Image(systemName: selectedTab == 1 ? "chart.bar.fill" : "chart.bar")
                    Text("Plan")
                }
                .tag(1)
                
                // AI Advisor 标签 (占位)
                NavigationView {
                    PlaceholderView(title: "AI Advisor", icon: "bubble.left.and.bubble.right.fill")
                }
                .tabItem {
                    Image(systemName: selectedTab == 2 ? "message.fill" : "message")
                    Text("AI")
                }
                .tag(2)
                
                // Community 标签 (占位)
                NavigationView {
                    PlaceholderView(title: "Community", icon: "person.3.fill")
                }
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "person.3.fill" : "person.3")
                    Text("Community")
                }
                .tag(3)
                
                // Me 标签
                NavigationView {
                    ProfileView()
                }
                .tabItem {
                    Image(systemName: selectedTab == 4 ? "person.fill" : "person")
                    Text("Me")
                }
                .tag(4)
            }
            .accentColor(.fireGreen)
        }
    }
}

// MARK: - 占位视图 (待实现的页面)
struct PlaceholderView: View {
    let title: String
    let icon: String
    
    var body: some View {
        ZStack {
            Color.backgroundDark
                .ignoresSafeArea()
            
            VStack(spacing: FIRESpacing.xl) {
                Image(systemName: icon)
                    .font(.system(size: 80))
                    .foregroundColor(.fireGreen.opacity(0.3))
                
                Text(title)
                    .font(.fireHeading2)
                    .foregroundColor(.textPrimary)
                
                Text("即将推出")
                    .font(.fireBody)
                    .foregroundColor(.textSecondary)
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Me 页面
struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            Color.backgroundDark
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: FIRESpacing.xl) {
                    // 用户信息
                    VStack(spacing: FIRESpacing.lg) {
                        Circle()
                            .fill(Color.fireGreenLight)
                            .frame(width: 80, height: 80)
                            .overlay(
                                Text(String(authViewModel.currentUser?.username.prefix(1) ?? "U"))
                                    .font(.fireHeading3)
                                    .foregroundColor(.fireGreen)
                            )
                        
                        Text(authViewModel.currentUser?.username ?? "User")
                            .font(.fireHeading2)
                            .foregroundColor(.textPrimary)
                        
                        Text(authViewModel.currentUser?.email ?? "")
                            .font(.fireBody)
                            .foregroundColor(.textSecondary)
                    }
                    .padding(.top, FIRESpacing.xxl)
                    
                    // 设置选项
                    VStack(spacing: 0) {
                        ProfileRow(icon: "person.fill", title: "个人信息")
                        Divider().background(Color.borderPrimary)
                        
                        ProfileRow(icon: "flame.fill", title: "FIRE 档案")
                        Divider().background(Color.borderPrimary)
                        
                        ProfileRow(icon: "bell.fill", title: "通知设置")
                        Divider().background(Color.borderPrimary)
                        
                        ProfileRow(icon: "lock.fill", title: "隐私与安全")
                    }
                    .background(Color.backgroundCard)
                    .cornerRadius(FIRERadius.medium)
                    .padding(.horizontal, FIRESpacing.xl)
                    
                    // 登出按钮
                    Button(action: { authViewModel.logout() }) {
                        Text("登出")
                            .font(.fireBodySemiBold)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, FIRESpacing.lg)
                            .background(Color.backgroundCard)
                            .cornerRadius(FIRERadius.medium)
                    }
                    .padding(.horizontal, FIRESpacing.xl)
                }
                .padding(.vertical, FIRESpacing.xl)
            }
        }
        .navigationBarHidden(true)
    }
}

struct ProfileRow: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.fireGreen)
                .frame(width: 24)
            
            Text(title)
                .font(.fireBody)
                .foregroundColor(.textPrimary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.textSecondary)
        }
        .padding(FIRESpacing.lg)
    }
}
