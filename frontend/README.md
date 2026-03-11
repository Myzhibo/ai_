# FIRE Advisor iOS App

## ✅ 项目已就绪!

Xcode 项目已经创建完成,可以直接在 Xcode 中打开和运行。

## 快速开始

### 1. 打开项目

```bash
open FIREAdvisor.xcodeproj
```

或者双击 `FIREAdvisor.xcodeproj` 文件。

### 2. 添加依赖包

在 Xcode 中添加以下依赖包:

**Alamofire (网络请求)**
- URL: `https://github.com/Alamofire/Alamofire.git`
- Version: 5.8.0 或更高

**KeychainSwift (安全存储)**
- URL: `https://github.com/evgenyneu/keychain-swift.git`
- Version: 20.0.0 或更高

#### 添加步骤:
1. 在 Xcode 中选择项目文件
2. 选择 `Package Dependencies` 标签页
3. 点击 `+` 添加上述两个包

### 3. 运行项目

1. 确保后端已启动: `cd ../backend && npm start`
2. 在 Xcode 中选择模拟器或真机
3. 点击运行 (⌘R)

## 📖 详细文档

查看 [XCODE_PROJECT.md](./XCODE_PROJECT.md) 了解更多信息。

## 项目结构

- **FIREAdvisorApp.swift**: App 入口
- **Models/**: 数据模型
- **Views/**: 视图组件
- **ViewModels/**: 视图模型
- **Services/**: API 和存储服务
- **DesignSystem/**: 设计系统(颜色、字体等)
