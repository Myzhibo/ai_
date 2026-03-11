// RegisterView.swift
// 注册界面

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundDark
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: FIRESpacing.xl) {
                        // 标题
                        VStack(spacing: FIRESpacing.sm) {
                            Text("创建账户")
                                .font(.fireHeading3)
                                .foregroundColor(.textPrimary)
                            
                            Text("开始你的 FIRE 之旅")
                                .font(.fireBody)
                                .foregroundColor(.textSecondary)
                        }
                        .padding(.top, FIRESpacing.xxl)
                        
                        // 注册表单
                        VStack(spacing: FIRESpacing.lg) {
                            FIRETextField(
                                title: "用户名",
                                text: $username,
                                placeholder: "Your Name"
                            )
                            
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
                                placeholder: "至少 6 位字符",
                                isSecure: true
                            )
                            
                            FIRETextField(
                                title: "确认密码",
                                text: $confirmPassword,
                                placeholder: "再次输入密码",
                                isSecure: true
                            )
                            
                            if let error = authViewModel.errorMessage {
                                Text(error)
                                    .font(.fireCaption)
                                    .foregroundColor(.red)
                            }
                            
                            Button(action: register) {
                                if authViewModel.isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .backgroundDark))
                                } else {
                                    Text("注册")
                                        .font(.fireBodySemiBold)
                                        .foregroundColor(.backgroundDark)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, FIRESpacing.lg)
                            .background(Color.fireGreen)
                            .cornerRadius(FIRERadius.pill)
                            .disabled(authViewModel.isLoading || !isFormValid)
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
        !username.isEmpty &&
        !email.isEmpty &&
        password.count >= 6 &&
        password == confirmPassword
    }
    
    private func register() {
        Task {
            await authViewModel.register(email: email, password: password, username: username)
            if authViewModel.isAuthenticated {
                dismiss()
            }
        }
    }
}
