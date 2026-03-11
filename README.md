# 🔥 FIRE Advisor

> **Financial Independence, Retire Early** - AI 驱动的财务独立顾问应用

一款帮助用户实现财务独立和提前退休目标的智能财务顾问应用,基于 **4% 规则**和 **FIRE 运动**理念。

![Status](https://img.shields.io/badge/Status-MVP%20Ready-success)
![Backend](https://img.shields.io/badge/Backend-Node.js%20%2B%20MongoDB-green)
![Frontend](https://img.shields.io/badge/Frontend-iOS%20SwiftUI-blue)
![License](https://img.shields.io/badge/License-MIT-yellow)

---

## 📱 预览

### 首页 FIRE 仪表盘
- ✅ FIRE 进度环形图 (动画)
- ✅ 关键指标卡片 (FIRE 数字、储蓄率、预计年龄)
- ✅ 月度收支概览
- ✅ 实时数据刷新

### 认证系统
- ✅ 注册/登录
- ✅ JWT 安全认证
- ✅ Keychain 存储

### FIRE 档案
- ✅ 个性化档案设置
- ✅ FIRE 计算引擎
- ✅ 进度追踪

---

## 🎯 核心功能

### ✅ 已实现 (MVP)
- [x] 用户注册和登录
- [x] FIRE 档案设置
- [x] FIRE 数字计算 (年支出 × 25)
- [x] 储蓄率计算和分析
- [x] FIRE 进度追踪
- [x] 预计 FIRE 年限
- [x] 首页仪表盘展示
- [x] 个人中心

### 🔜 待实现
- [ ] FIRE 路线图 (Plan 页面)
- [ ] AI 对话功能
- [ ] 社区功能
- [ ] 数据图表和趋势
- [ ] 净资产追踪
- [ ] 智能提醒系统

---

## 🏗️ 技术栈

### 后端
- **Runtime**: Node.js 18+
- **Framework**: Express.js
- **Database**: MongoDB
- **Cache**: Redis (可选)
- **Auth**: JWT
- **API**: RESTful

### 前端
- **Platform**: iOS 16.0+
- **Framework**: SwiftUI
- **Architecture**: MVVM
- **Networking**: Alamofire
- **Storage**: Keychain
- **Language**: Swift 5.8+

### 未来规划
- **AI**: LangChain + OpenAI/Claude
- **RAG**: Pinecone + FIRE 知识库
- **Files**: AWS S3 / 阿里云 OSS

---

## 🚀 快速开始

### 前置要求

```bash
# 检查 Node.js
node --version  # >= 18.0.0

# 检查 MongoDB
mongosh --version

# 检查 Xcode
xcode-select --version  # >= 14.0
```

### 1. 克隆项目 (或使用现有目录)

```bash
cd /Users/doubo/Desktop/gate/ai_
```

### 2. 启动后端

```bash
cd backend

# 安装依赖
npm install

# 启动 MongoDB (如果还没运行)
brew services start mongodb-community

# 启动服务器
npm run dev
```

应该看到:
```
✅ MongoDB Connected: localhost
✅ Database indexes created
🚀 Server: http://localhost:3000
```

### 3. 创建 iOS 项目

详细步骤请查看: **[📖 QUICK_START.md](./QUICK_START.md)**

简要步骤:
1. 打开 Xcode → Create a new Xcode project
2. iOS → App → SwiftUI
3. 添加 Swift Package: Alamofire + KeychainSwift
4. 复制 `frontend/` 下的所有 `.swift` 文件到项目
5. 配置 Info.plist (允许本地网络)
6. 运行 (⌘R)

---

## 📚 文档

### 核心文档
- **[📋 PRD.md](./PRD.md)** - 完整产品需求文档 (1893行)
- **[🚀 QUICK_START.md](./QUICK_START.md)** - 快速启动指南 ⭐
- **[✅ CHECKLIST.md](./CHECKLIST.md)** - 启动检查清单
- **[📊 PROJECT_SUMMARY.md](./PROJECT_SUMMARY.md)** - 项目总结
- **[🌳 FILE_TREE.md](./FILE_TREE.md)** - 文件结构

### 分模块文档
- **[backend/README.md](./backend/README.md)** - 后端 API 文档
- **[frontend/README.md](./frontend/README.md)** - 前端开发指南

---

## 📊 项目统计

```
文档:         6 个
后端文件:    14 个
前端文件:    14 个
代码行数:  ~6000 行
API 端点:     8 个
页面视图:     7 个
```

---

## 🎨 设计系统

### 颜色主题
```swift
Primary:     #13EC5B (FIRE 绿)
Background:  #102216 (深绿黑)
Card:        #23482F (卡片绿)
Text:        #F1F5F9 (主文本)
Secondary:   #64748B (次要文本)
```

### 字体
- **Heading**: System Rounded Bold (14-48px)
- **Body**: System Rounded Regular/Medium (14px)
- **Caption**: System Rounded Bold (10-11px)

设计稿: [Figma Link](https://www.figma.com/design/Edeqsgmz2DYAZJJ5X31sgR/)

---

## 🧪 API 端点

### 认证
```
POST   /api/auth/register      # 注册
POST   /api/auth/login         # 登录
GET    /api/auth/me            # 获取当前用户
```

### FIRE 功能
```
GET    /api/fire/profile       # 获取 FIRE 档案
POST   /api/fire/profile       # 更新 FIRE 档案
GET    /api/fire/progress      # 获取 FIRE 进度
POST   /api/fire/net-worth-snapshot  # 记录净资产快照
GET    /api/fire/net-worth-history   # 获取净资产历史
```

### 健康检查
```
GET    /health                 # 服务器状态
```

---

## 🧪 测试

### 后端测试

```bash
# 健康检查
curl http://localhost:3000/health

# 注册用户
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@fire.com",
    "password": "password123",
    "username": "Test User"
  }'

# 更新 FIRE 档案
curl -X POST http://localhost:3000/api/fire/profile \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "current_age": 30,
    "target_fire_age": 40,
    "current_savings": 50000,
    "monthly_income": 5000,
    "monthly_expenses": 2500
  }'
```

### iOS 测试流程

1. **注册**: test@fire.com / password123
2. **设置档案**: 30岁 → 40岁 / $50K / $5K月收入 / $2.5K月支出
3. **查看进度**: 6.7% / $750K FIRE数字 / 50%储蓄率 / 17年

---

## 📁 项目结构

```
ai_/
├── PRD.md                      # 产品需求文档
├── README.md                   # 本文件
├── backend/                    # Node.js API
│   ├── src/
│   │   ├── models/            # MongoDB 模型
│   │   ├── controllers/       # 业务逻辑
│   │   ├── routes/            # API 路由
│   │   └── middleware/        # 中间件
│   └── package.json
└── frontend/                   # iOS SwiftUI
    ├── Models/                # 数据模型
    ├── Services/              # 网络和存储
    ├── ViewModels/            # MVVM
    ├── Views/                 # UI 界面
    └── DesignSystem/          # 设计系统
```

---

## 🛠️ 开发指南

### 后端开发

```bash
cd backend

# 开发模式 (自动重启)
npm run dev

# 生产模式
npm start
```

### 前端开发

```bash
# 在 Xcode 中打开项目
open frontend/FIREAdvisor/FIREAdvisor.xcodeproj

# 或使用命令行运行
xcodebuild -scheme FIREAdvisor -destination 'platform=iOS Simulator,name=iPhone 14'
```

---

## 🐛 常见问题

### MongoDB 连接失败?
```bash
# 启动 MongoDB
brew services start mongodb-community

# 或使用 Docker
docker run -d -p 27017:27017 --name mongodb mongo
```

### 端口被占用?
修改 `backend/.env`:
```
PORT=3001  # 改为其他端口
```

### iOS 编译失败?
1. 确保已添加 Swift Packages (Alamofire, KeychainSwift)
2. 确保所有 Swift 文件都在 Target 中
3. Clean Build Folder (⇧⌘K)

### API 连接失败?
1. 检查后端是否运行
2. 检查 Info.plist 是否配置
3. iOS 模拟器使用 `localhost` 或 `127.0.0.1`

---

## 🗺️ Roadmap

### Phase 1: MVP ✅ (Week 1-6)
- [x] 后端 API
- [x] 用户认证
- [x] FIRE 档案
- [x] 首页仪表盘

### Phase 2: 高级功能 (Week 7-12)
- [ ] FIRE 路线图页面
- [ ] 文件上传
- [ ] AI 生成报告
- [ ] 语音输入
- [ ] 底部导航完整功能

### Phase 3: 数据分析 (Week 13-18)
- [ ] 净资产追踪
- [ ] 数据可视化图表
- [ ] 智能提醒
- [ ] 里程碑系统

### Phase 4: AI 功能 (Week 19-24)
- [ ] AI 对话 (LangChain)
- [ ] FIRE 知识库 (RAG)
- [ ] 多专家 Agent
- [ ] 个性化建议

---

## 🤝 贡献

欢迎贡献! 请查看 [PRD.md](./PRD.md) 了解详细规划。

---

## 📄 License

MIT License

---

## 👨‍💻 作者

FIRE Advisor Team

---

## 🙏 致谢

- **FIRE 运动**: Vicki Robin, JL Collins, Mr. Money Mustache
- **Trinity Study**: 4% 规则的理论基础
- **设计灵感**: Figma 社区

---

## 📞 支持

- 📧 Email: support@fireadvisor.app
- 📱 Issues: [GitHub Issues](https://github.com/your-repo/issues)
- 📖 文档: [QUICK_START.md](./QUICK_START.md)

---

<div align="center">

**🔥 开始你的 FIRE 之旅! 🔥**

[快速开始](./QUICK_START.md) · [查看文档](./PRD.md) · [问题反馈](#)

</div>
