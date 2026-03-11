# FIREAdvisor iOS 项目

## ✅ 项目已成功创建!

现在你可以在 Xcode 中直接打开和运行这个项目了。

## 打开项目

```bash
open /Users/doubo/Desktop/gate/ai_/frontend/FIREAdvisor.xcodeproj
```

或者在 Xcode 中选择 `File > Open` 然后导航到该路径。

## 项目结构

```
frontend/
├── FIREAdvisor.xcodeproj/     # Xcode 项目文件
├── Assets.xcassets/           # 资源文件
├── Info.plist                 # 应用配置
├── FIREAdvisorApp.swift       # 应用入口
├── ContentView.swift          # 主视图
├── Models/                    # 数据模型
│   └── User.swift
├── Views/                     # 视图组件
│   ├── Auth/
│   │   ├── LoginView.swift
│   │   └── RegisterView.swift
│   ├── Home/
│   │   └── HomeView.swift
│   ├── Profile/
│   │   └── ProfileSetupView.swift
│   └── Components/
│       └── FIREProgressRingView.swift
├── ViewModels/                # 视图模型
│   ├── AuthViewModel.swift
│   └── HomeViewModel.swift
├── Services/                  # 服务层
│   ├── APIClient.swift
│   └── KeychainManager.swift
└── DesignSystem/             # 设计系统
    ├── Colors.swift
    └── Typography.swift
```

## 📦 添加依赖包

项目需要以下依赖包,请在 Xcode 中添加:

### 1. 打开 Package Dependencies

在 Xcode 中:
1. 选择项目文件(顶部的 FIREAdvisor)
2. 选择 `Package Dependencies` 标签页
3. 点击 `+` 按钮添加包

### 2. 添加 Alamofire (网络请求)

- URL: `https://github.com/Alamofire/Alamofire.git`
- Version: `5.8.0` 或更高

### 3. 添加 KeychainSwift (安全存储)

- URL: `https://github.com/evgenyneu/keychain-swift.git`
- Version: `20.0.0` 或更高

## 🔧 配置后端 API 地址

项目默认连接到本地后端 API。如果需要修改,请编辑 `Services/APIClient.swift`:

```swift
private let baseURL = "http://localhost:3000/api"
```

## ▶️ 运行项目

1. 确保后端服务已启动
2. 在 Xcode 中选择目标设备(模拟器或真机)
3. 点击运行按钮 (⌘R) 或选择 `Product > Run`

## 📱 最低系统要求

- iOS 16.0+
- Xcode 15.0+
- Swift 5.9+

## 🎨 App 图标

如需添加 App 图标:
1. 准备各种尺寸的图标图片
2. 在 Xcode 中打开 `Assets.xcassets`
3. 选择 `AppIcon`
4. 拖拽图片到对应的尺寸槽位

## 🐛 常见问题

### 编译错误:找不到 Alamofire 或 KeychainSwift

确保已按照上述步骤添加了依赖包,并在添加后等待 Xcode 解析完成。

### 无法连接到后端 API

1. 检查后端是否已启动:`cd backend && npm start`
2. 检查 API 地址是否正确
3. 如果使用真机测试,需要将 API 地址改为电脑的 IP 地址

### 真机运行需要签名

1. 在 Xcode 中选择项目 > Signing & Capabilities
2. 选择你的开发团队
3. Xcode 会自动配置签名

## 📖 相关文档

- [PRD 产品需求文档](../PRD.md)
- [快速开始指南](../QUICK_START.md)
- [环境配置指南](../ENVIRONMENT_SETUP.md)

## 🚀 下一步

1. ✅ 项目已创建
2. 📦 添加依赖包(Alamofire, KeychainSwift)
3. ▶️ 运行项目
4. 🎨 自定义 App 图标(可选)
5. 📱 测试功能

祝你开发愉快! 🎉
