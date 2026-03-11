# ✅ FIRE Advisor 启动检查清单

## 🎯 开始之前

按照以下步骤,确保所有环境准备就绪。

---

## 📋 第一步: 环境检查

### 1. 检查 Node.js
```bash
node --version
# 需要: v18.0.0 或更高
```

✅ 已安装  
❌ 未安装 → `brew install node`

---

### 2. 检查 MongoDB
```bash
mongosh --version
# 或
mongo --version
```

✅ 已安装  
❌ 未安装 → 执行下方安装步骤

#### MongoDB 安装 (选择一种方法)

**方法 A: Homebrew (推荐)**
```bash
brew tap mongodb/brew
brew install mongodb-community
brew services start mongodb-community

# 验证
mongosh --eval "db.version()"
```

**方法 B: Docker**
```bash
docker run -d \
  --name mongodb \
  -p 27017:27017 \
  mongo:latest

# 验证
docker ps | grep mongodb
```

---

### 3. 检查 Xcode
```bash
xcode-select --version
# 或打开 Xcode
```

✅ 已安装 (版本 >= 14.0)  
❌ 未安装 → 从 App Store 安装 Xcode

---

## 📦 第二步: 安装依赖

### 后端依赖
```bash
cd /Users/doubo/Desktop/gate/ai_/backend
npm install

# 应该看到:
# ✅ added 135 packages
```

✅ 完成  
❌ 失败 → 检查错误信息

---

### 前端依赖
```
在 Xcode 中添加 Swift Packages:

1. File → Add Package Dependencies

2. 添加 Alamofire:
   URL: https://github.com/Alamofire/Alamofire.git
   Version: 5.8.0 或更高

3. 添加 KeychainSwift:
   URL: https://github.com/evgenyneu/keychain-swift.git
   Version: 20.0.0 或更高
```

✅ 完成  
❌ 未完成 → 稍后在 Xcode 中添加

---

## 🚀 第三步: 启动后端服务器

```bash
cd /Users/doubo/Desktop/gate/ai_/backend
npm run dev
```

### 应该看到:
```
✅ MongoDB Connected: localhost
✅ Database indexes created
🚀 Server: http://localhost:3000
📊 Environment: development
```

✅ 服务器正常运行  
❌ 出现错误:

**常见错误处理:**

1. **MongoDB 连接失败**
   ```
   ❌ MongoDB connection error: connect ECONNREFUSED
   ```
   → MongoDB 未启动,执行: `brew services start mongodb-community`

2. **端口被占用**
   ```
   ❌ Error: listen EADDRINUSE: address already in use :::3000
   ```
   → 修改 `backend/.env` 中的 `PORT=3000` 为其他端口 (如 3001)

3. **模块未找到**
   ```
   ❌ Error: Cannot find module 'express'
   ```
   → 重新安装: `npm install`

---

## 🧪 第四步: 测试 API

### 测试健康检查
```bash
curl http://localhost:3000/health
```

**期望响应:**
```json
{"status":"ok","timestamp":"2026-03-11T...","env":"development"}
```

✅ API 正常  
❌ 无响应 → 检查服务器是否运行

---

### 测试注册 API
```bash
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@fire.com",
    "password": "password123",
    "username": "Test User"
  }'
```

**期望响应:**
```json
{
  "token":"eyJhbGc...",
  "user":{
    "id":"...",
    "email":"test@fire.com",
    "username":"Test User"
  }
}
```

✅ 注册成功  
❌ 失败 → 检查 MongoDB 连接

---

## 📱 第五步: 创建 iOS 项目

### 1. 创建 Xcode 项目
```
1. 打开 Xcode
2. Create a new Xcode project
3. iOS → App
4. 配置:
   Product Name: FIREAdvisor
   Team: [你的团队]
   Organization Identifier: com.fire.advisor
   Interface: SwiftUI
   Language: Swift
5. 保存到: /Users/doubo/Desktop/gate/ai_/frontend/
```

✅ 项目已创建

---

### 2. 项目结构设置

在 Xcode 左侧项目导航器中:

```
右键 FIREAdvisor → New Group
创建以下文件夹:
- Models
- Services
- ViewModels
- Views
  - Auth
  - Home
  - Profile
  - Components
- DesignSystem
```

✅ 文件夹结构已创建

---

### 3. 复制 Swift 文件

将 `/Users/doubo/Desktop/gate/ai_/frontend/` 目录下的文件
拖入对应的 Xcode 文件夹:

```
拖入步骤:
1. 在 Finder 中打开 /Users/doubo/Desktop/gate/ai_/frontend/
2. 将 Models/User.swift 拖入 Xcode 的 Models 文件夹
3. 弹出对话框:
   ☑️ Copy items if needed
   ☑️ FIREAdvisor (Target)
4. 点击 Finish
5. 对所有文件重复此操作
```

**文件清单:**
- [ ] FIREAdvisorApp.swift (替换默认文件)
- [ ] ContentView.swift (替换默认文件)
- [ ] Models/User.swift
- [ ] Services/APIClient.swift
- [ ] Services/KeychainManager.swift
- [ ] ViewModels/AuthViewModel.swift
- [ ] ViewModels/HomeViewModel.swift
- [ ] Views/Auth/LoginView.swift
- [ ] Views/Auth/RegisterView.swift
- [ ] Views/Home/HomeView.swift
- [ ] Views/Profile/ProfileSetupView.swift
- [ ] Views/Components/FIREProgressRingView.swift
- [ ] DesignSystem/Colors.swift
- [ ] DesignSystem/Typography.swift

✅ 所有文件已添加

---

### 4. 添加 Swift Packages

```
File → Add Package Dependencies

1. Alamofire:
   https://github.com/Alamofire/Alamofire.git
   [等待解析...] → Add Package

2. KeychainSwift:
   https://github.com/evgenyneu/keychain-swift.git
   [等待解析...] → Add Package
```

✅ 包已添加

---

### 5. 配置 Info.plist

```
1. 在项目导航器中找到 Info.plist
2. 右键 → Open As → Source Code
3. 在 <dict> 标签内添加:

<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsLocalNetworking</key>
    <true/>
</dict>

4. 保存
```

✅ Info.plist 已配置

---

## 🎮 第六步: 运行应用

### 1. 选择模拟器
```
Xcode 顶部:
FIREAdvisor > iPhone 14 (或更高)
```

### 2. 编译项目
```
Product → Build (⌘B)
```

**期望结果:**
```
✅ Build Succeeded
```

❌ 编译失败 → 检查错误信息:
- 确保所有文件都在 Target 中
- 确保已添加 Alamofire 和 KeychainSwift

### 3. 运行应用
```
Product → Run (⌘R)
```

**期望结果:**
```
✅ 模拟器启动
✅ 显示登录界面
```

---

## 🧪 第七步: 功能测试

### Test Case 1: 注册新用户
```
步骤:
1. 点击 "还没有账号? 注册"
2. 填写:
   用户名: Test User
   邮箱: test@fire.com  
   密码: password123
   确认密码: password123
3. 点击 "注册"

期望结果:
✅ 自动登录
✅ 跳转到首页
✅ 显示空状态 "开始你的 FIRE 之旅"
```

### Test Case 2: 设置 FIRE 档案
```
步骤:
1. 点击 "设置档案"
2. 填写:
   当前年龄: 30
   目标 FIRE 年龄: 40
   当前储蓄: 50000
   月收入: 5000
   月支出: 2500
3. 查看预计储蓄率: 50.0%
4. 点击 "保存档案"

期望结果:
✅ 返回首页
✅ 显示 FIRE 进度环 (6.7%)
✅ 显示关键指标
```

### Test Case 3: 查看首页数据
```
首页应显示:
✅ FIRE 进度环: 6.7%
✅ FIRE 数字: $750,000
✅ 当前储蓄: $50,000
✅ 储蓄率: 50.0%
✅ 预计 FIRE: 47 岁
✅ 月收入: $5,000
✅ 月支出: $2,500
✅ 月储蓄: $2,500
```

### Test Case 4: 登出并重新登录
```
步骤:
1. 点击 "Me" 标签
2. 点击 "登出"
3. 返回登录界面
4. 登录:
   邮箱: test@fire.com
   密码: password123

期望结果:
✅ 登录成功
✅ 数据保持 (不需要重新设置)
```

---

## ✅ 最终检查清单

- [ ] Node.js 已安装
- [ ] MongoDB 已安装并运行
- [ ] Xcode 已安装
- [ ] 后端依赖已安装 (`npm install`)
- [ ] 后端服务器运行正常
- [ ] API 健康检查通过
- [ ] 注册 API 测试通过
- [ ] Xcode 项目已创建
- [ ] Swift 文件已添加
- [ ] Swift Packages 已添加
- [ ] Info.plist 已配置
- [ ] 应用编译成功
- [ ] 应用运行正常
- [ ] 注册功能测试通过
- [ ] FIRE 档案设置测试通过
- [ ] 首页数据显示正常
- [ ] 登出/登录测试通过

---

## 🎉 恭喜!

如果所有检查项都完成,你的 FIRE Advisor 应用已经完全就绪!

### 下一步可以做什么?

1. ✅ 美化 UI 细节
2. ✅ 实现 Plan 页面
3. ✅ 添加数据图表
4. ✅ 实现 Community 功能
5. ✅ 集成 AI 对话 (第二阶段)

---

## 🆘 需要帮助?

如果遇到问题:

1. 查看 `QUICK_START.md`
2. 查看 `SETUP_GUIDE.md`
3. 检查后端日志
4. 检查 Xcode 控制台输出

**开始你的 FIRE 应用开发之旅吧! 🚀🔥**
