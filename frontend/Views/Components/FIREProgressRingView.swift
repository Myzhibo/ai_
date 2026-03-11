// FIREProgressRingView.swift
// FIRE 进度环形图组件

import SwiftUI

struct FIREProgressRingView: View {
    let progress: FIREProgress
    
    @State private var animatedProgress: CGFloat = 0
    
    var body: some View {
        VStack(spacing: FIRESpacing.xl) {
            ZStack {
                // 背景圆环
                Circle()
                    .stroke(Color.borderPrimary, lineWidth: 20)
                    .frame(width: 200, height: 200)
                
                // 进度圆环
                Circle()
                    .trim(from: 0, to: animatedProgress)
                    .stroke(
                        LinearGradient(
                            colors: [.fireGreen, .fireGreen.opacity(0.7)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        style: StrokeStyle(lineWidth: 20, lineCap: .round)
                    )
                    .frame(width: 200, height: 200)
                    .rotationEffect(.degrees(-90))
                    .fireGlow()
                
                // 中心文字
                VStack(spacing: FIRESpacing.xs) {
                    Text("\(Int(progress.progress))%")
                        .font(.fireNumberLarge)
                        .foregroundColor(.textPrimary)
                    
                    Text("FIRE 进度")
                        .font(.fireCaption)
                        .foregroundColor(.textSecondary)
                }
            }
            
            // 状态标签
            HStack(spacing: FIRESpacing.sm) {
                Image(systemName: progress.onTrack ? "checkmark.circle.fill" : "exclamationmark.circle.fill")
                    .foregroundColor(progress.onTrack ? .fireGreen : .orange)
                
                Text(progress.onTrack ? "按计划进行" : "需要调整计划")
                    .font(.fireBody)
                    .foregroundColor(.textSecondary)
            }
            .padding(.horizontal, FIRESpacing.lg)
            .padding(.vertical, FIRESpacing.sm)
            .background(Color.backgroundCard)
            .cornerRadius(FIRERadius.pill)
            
            // 年限信息
            VStack(spacing: FIRESpacing.xs) {
                Text("\(String(format: "%.1f", progress.yearsToFire)) 年")
                    .font(.fireHeading2)
                    .foregroundColor(.fireGreen)
                
                Text("预计达成 FIRE")
                    .font(.fireCaption)
                    .foregroundColor(.textSecondary)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5)) {
                animatedProgress = CGFloat(progress.progress / 100)
            }
        }
    }
}
