// LoginView.swift
// 登录界面

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var showRegister = false
    
    var body: some View {
        ZStack {
            Color.backgroundDark
                .ignoresSafeArea()
            
            VStack(spacing: FIRESpacing.xl) {
                Spacer()
                
                // Logo 和标题
                VStack(spacing: FIRESpacing.lg) {
                    Image(systemName: "flame.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.fireGreen)
                    
                    Text("FIRE Advisor")
                        .font(.fireHeading3)
                        .foregroundColor(.textPrimary)
                    
                    Text("Financial Independence, Retire Early")
                        .font(.fireCaption)
                        .foregroundColor(.textSecondary)
                }
                
                Spacer()
                
                // 登录表单
                VStack(spacing: FIRESpacing.lg) {
                    FIRETextField(
                        title: "邮箱",
                        text: $email,
                        placeholder: "your@email.com"
                    )
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    
                    FIRETextField(
                        title: "密码",
                        text: $password,
                        placeholder: "••••••••",
                        isSecure: true
                    )
                    
                    if let error = authViewModel.errorMessage {
                        Text(error)
                            .font(.fireCaption)
                            .foregroundColor(.red)
                    }
                    
                    Button(action: login) {
                        if authViewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .backgroundDark))
                        } else {
                            Text("登录")
                                .font(.fireBodySemiBold)
                                .foregroundColor(.backgroundDark)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, FIRESpacing.lg)
                    .background(Color.fireGreen)
                    .cornerRadius(FIRERadius.pill)
                    .disabled(authViewModel.isLoading)
                    
                    Button(action: { showRegister = true }) {
                        Text("还没有账号? 注册")
                            .font(.fireBody)
                            .foregroundColor(.fireGreen)
                    }
                }
                .padding(.horizontal, FIRESpacing.xl)
                
                Spacer()
            }
        }
        .sheet(isPresented: $showRegister) {
            RegisterView()
        }
    }
    
    private func login() {
        Task {
            await authViewModel.login(email: email, password: password)
        }
    }
}

// MARK: - 自定义输入框组件
struct FIRETextField: View {
    let title: String
    @Binding var text: String
    let placeholder: String
    var isSecure: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: FIRESpacing.sm) {
            Text(title)
                .font(.fireCaption)
                .foregroundColor(.textSecondary)
                .textCase(.uppercase)
            
            Group {
                if isSecure {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            .font(.fireBody)
            .foregroundColor(.textPrimary)
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
