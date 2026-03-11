# FIRE Advisor - 完整启动指南

## 🎯 项目已创建完成!

你现在有一个完整的 FIRE 财务顾问应用项目,包括:
- ✅ 后端 API (Node.js + Express + MongoDB)  
- ✅ 数据库模型 (User, FIRE Profile, NetWorthSnapshot)
- ✅ 认证系统 (JWT)
- ✅ FIRE 计算逻辑
- 🔜 前端 iOS App (SwiftUI) - 代码文件即将生成

---

## 📋 必需软件安装

### 1. 安装 MongoDB

**方法 A: 使用 Homebrew (推荐)**
```bash
brew tap mongodb/brew
brew install mongodb-community
brew services start mongodb-community
```

**方法 B: 使用 Docker**
```bash
docker run -d -p 27017:27017 --name mongodb mongo:latest
```

### 2. 验证 MongoDB 运行
```bash
mongosh --eval "db.version()"
# 应该显示 MongoDB 版本号
```

---

## 🚀 启动后端服务器

```bash
cd /Users/doubo/Desktop/gate/ai_/backend

# 后端已经在运行!
# 如果需要重启:
npm run dev
```

服务器运行在: **http://localhost:3000**

---

## 📱 前端 iOS App 创建步骤

### Step 1: 创建 Xcode 项目

1. 打开 **Xcode**
2. 选择 **"Create a new Xcode project"**
3. 选择 **iOS** → **App**
4. 配置:
   ```
   Product Name: FIREAdvisor
   Team: [选择你的团队]
   Organization Identifier: com.fire.advisor
   Interface: SwiftUI
   Language: Swift
   Storage: None
   ```
5. 保存到: `/Users/doubo/Desktop/gate/ai_/frontend/FIREAdvisor`

### Step 2: 添加依赖包

在 Xcode 中:
1. File → Add Package Dependencies
2. 添加以下包:

**Alamofire (网络请求)**
```
https://github.com/Alamofire/Alamofire.git
版本: 5.8.0 或更高
```

**KeychainSwift (安全存储)**
```
https://github.com/evgenyneu/keychain-swift.git  
版本: 20.0.0 或更高
```

### Step 3: 复制代码文件

我将生成完整的 Swift 代码文件,包括:
- ✅ 设计系统 (颜色、字体、组件)
- ✅ 网络层 (API Client)
- ✅ 数据模型 (User, FIREProfile)
- ✅ 认证功能 (登录/注册)
- ✅ 首页仪表盘 (FIRE 进度展示)

---

## 🧪 测试 API

### 1. 测试健康检查
```bash
curl http://localhost:3000/health
```

### 2. 注册测试用户
```bash
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@fire.com",
    "password": "password123",
    "username": "FIRE Test User"
  }'
```

保存返回的 `token`,后续请求需要使用。

### 3. 更新 FIRE 档案
```bash
curl -X POST http://localhost:3000/api/fire/profile \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -d '{
    "current_age": 30,
    "target_fire_age": 40,
    "current_savings": 50000,
    "monthly_income": 5000,
    "monthly_expenses": 2500
  }'
```

### 4. 获取 FIRE 进度
```bash
curl http://localhost:3000/api/fire/progress \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

---

## 📂 项目结构

```
ai_/
├── PRD.md                          # 产品需求文档
├── backend/                        # 后端 API
│   ├── src/
│   │   ├── config/
│   │   │   └── database.js        # MongoDB 配置
│   │   ├── models/
│   │   │   ├── User.js            # 用户模型
│   │   │   └── NetWorthSnapshot.js # 净资产快照模型
│   │   ├── controllers/
│   │   │   ├── auth.controller.js  # 认证控制器
│   │   │   └── fire.controller.js  # FIRE 功能控制器
│   │   ├── routes/
│   │   │   ├── auth.routes.js      # 认证路由
│   │   │   └── fire.routes.js      # FIRE 路由
│   │   ├── middleware/
│   │   │   └── auth.middleware.js  # 认证中间件
│   │   ├── utils/
│   │   │   └── jwt.js              # JWT 工具
│   │   ├── app.js                  # Express 应用
│   │   └── server.js               # 服务器入口
│   ├── .env                        # 环境变量
│   ├── package.json
│   └── README.md
│
└── frontend/                       # iOS 前端 (待创建)
    └── FIREAdvisor/
        ├── Models/
        ├── Views/
        ├── ViewModels/
        ├── Services/
        └── DesignSystem/
```

---

## ✅ 当前状态

- ✅ 后端项目已创建
- ✅ 依赖已安装
- ✅ 后端服务器正在运行
- ⏳ 等待 MongoDB 启动
- 🔜 前端代码生成中...

---

## 🆘 常见问题

### Q: MongoDB 连接失败?
A: 确保 MongoDB 服务正在运行:
```bash
# 检查状态
brew services list | grep mongodb

# 启动服务
brew services start mongodb-community
```

### Q: 端口 3000 已被占用?
A: 修改 `backend/.env` 中的 `PORT=3000` 为其他端口

### Q: iOS 模拟器无法连接 localhost?
A: 使用你的 Mac 的 IP 地址替代 localhost

---

## 🎉 下一步

1. ✅ 安装 MongoDB (如果还没安装)
2. ✅ 重启后端服务器
3. ✅ 创建 Xcode 项目
4. ✅ 复制前端代码文件(即将生成)
5. ✅ 运行 iOS 应用
6. ✅ 测试登录和首页功能

准备好了吗? 让我开始生成前端代码!
