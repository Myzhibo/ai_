# FIRE Advisor Backend

## 快速启动

### 1. 安装 MongoDB
```bash
# macOS
brew install mongodb-community
brew services start mongodb-community

# 或使用 Docker
docker run -d -p 27017:27017 --name mongodb mongo:latest
```

### 2. 安装依赖
```bash
npm install
```

### 3. 启动服务器
```bash
npm run dev
```

服务器将运行在 `http://localhost:3000`

## API 端点

### 认证
- `POST /api/auth/register` - 注册
- `POST /api/auth/login` - 登录
- `GET /api/auth/me` - 获取当前用户

### FIRE 功能
- `GET /api/fire/profile` - 获取 FIRE 档案
- `POST /api/fire/profile` - 更新 FIRE 档案
- `GET /api/fire/progress` - 获取 FIRE 进度
- `POST /api/fire/net-worth-snapshot` - 记录净资产快照
- `GET /api/fire/net-worth-history` - 获取净资产历史

## 测试

### 1. 注册用户
```bash
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "password123",
    "username": "Test User"
  }'
```

### 2. 更新 FIRE 档案
```bash
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
