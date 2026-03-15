# 养Young App 技术设计文档 v1.0

> 💰 **重要**: 关于付费功能使用规则，请查看 [付费操作确认规则.md](./付费操作确认规则.md)

---

## 1. 技术栈

### 前端

#### iOS App
- **iOS**: Swift + SwiftUI
- **UI架构**: Design System (Theme/Color/Typography/Component统一管理)
- **状态管理**: ObservableObject + @Published
- **网络层**: Combine + URLSession
- **本地存储**: Core Data + Keychain

#### 管理后台 (Admin)
- **框架**: Vue 3 + Vite
- **UI组件**: Element Plus
- **路由**: Vue Router 4
- **状态管理**: Pinia
- **网络层**: Axios
- **富文本编辑器**: Markdown Editor (v-md-editor)
- **图表**: ECharts
- **认证**: JWT Token

#### 官方网站 (Portal) 🆕
- **框架**: React 18 + Next.js 14 (App Router)
- **语言**: TypeScript
- **样式**: Tailwind CSS 3.4+
- **动画引擎**: GSAP 3.12+ (核心)
- **滚动动画**: ScrollTrigger + ScrollSmoother
- **3D效果**: Three.js (可选)
- **图标**: Lucide React
- **部署**: Vercel (免费托管)

### 后端
- **框架**: Node.js + Fastify
- **数据库**: MongoDB (主库) + Redis (缓存/会话)
- **认证**: JWT + Refresh Token
- **AI服务**: LangChain + OpenAI/Claude API
- **向量检索**: Pinecone/Chroma (RAG知识库)

### 基础设施
- **部署**: Docker + PM2
- **文件存储**: OSS/S3
- **监控**: Winston + Sentry
- **API文档**: Swagger/OpenAPI

---

## 2. 项目结构 🆕

```
gate/
├── ai_/                        # iOS App + Node.js API (现有项目)
│   ├── YOUNGApp/              # iOS 应用
│   ├── young-api/             # 后端 API
│   └── docs/                  # 项目文档
├── young-admin/               # 管理后台 (Vue3) - 新增
│   ├── src/
│   │   ├── views/             # 页面
│   │   ├── components/        # 组件
│   │   ├── api/              # API封装
│   │   └── router/           # 路由
│   └── package.json
└── young-portal/              # 官方网站 (React) 🆕
    ├── app/                   # Next.js App Router
    │   ├── page.tsx          # 首页
    │   ├── features/         # 功能页
    │   ├── cities/           # 城市数据
    │   ├── knowledge/        # 知识中心
    │   ├── pricing/          # 定价
    │   └── about/            # 关于
    ├── components/
    │   ├── sections/         # 页面区块
    │   ├── ui/               # UI组件
    │   └── animations/       # 动画组件
    ├── lib/
    │   └── gsap/             # GSAP动画
    └── package.json
```

---

## 3. 数据库设计

### 核心集合结构

```javascript
// users - 用户基础信息
{
  _id: ObjectId,
  phone: String,           // 手机号(唯一)
  email: String,           // 邮箱
  nickname: String,        // 昵称
  avatar: String,          // 头像URL
  password_hash: String,   // 密码哈希
  membership_tier: String, // 会员等级: free/premium/black_gold
  verified: Boolean,       // 实名认证
  created_at: Date,
  updated_at: Date,
  metadata: Object,        // 扩展字段
  is_deleted: Boolean
}

// profiles - 用户扩展资料
{
  _id: ObjectId,
  user_id: ObjectId,
  fire_goal_age: Number,   // 退休目标年龄
  current_age: Number,     // 当前年龄
  risk_preference: String, // 风险偏好: C1-C5
  location_preference: Array<String>, // 偏好城市
  tags: Array<String>,
  created_at: Date,
  updated_at: Date
}

// posts - 社区内容
{
  _id: ObjectId,
  user_id: ObjectId,
  content: String,         // 文本内容
  type: String,            // 类型: text/image/video
  media_urls: Array<String>, // 媒体资源URL
  tags: Array<String>,     // 话题标签
  location: {              // 地理位置
    name: String,
    coordinates: [Number, Number]
  },
  is_public: Boolean,      // 公开可见
  stats: {
    likes: Number,
    comments: Number,
    views: Number
  },
  created_at: Date,
  updated_at: Date,
  deleted_at: Date,
  is_deleted: Boolean
}

// comments - 评论与回复
{
  _id: ObjectId,
  post_id: ObjectId,
  user_id: ObjectId,
  parent_id: ObjectId,     // 父评论ID(树状结构)
  content: String,
  mentions: Array<ObjectId>, // @的用户
  created_at: Date,
  is_deleted: Boolean
}

// cities - 城市数据
{
  _id: ObjectId,
  name_zh: String,         // 中文名
  name_en: String,         // 英文名
  country: String,         // 国家
  scores: {                // 评分维度
    living_cost: Number,   // 生活成本 0-10
    healthcare: Number,    // 医疗水平 0-10
    air_quality: Number,   // 空气质量 0-10
    nomad_friendly: Number,// 数字游民友好 0-10
    climate: Number,       // 气候宜居 0-10
    culture: Number        // 文化包容 0-10
  },
  monthly_cost: Number,    // 月生活成本(CNY)
  cover_image: String,
  updated_at: Date
}

// fire_plans - FIRE计划
{
  _id: ObjectId,
  user_id: ObjectId,
  name: String,            // 方案名称
  params: {
    current_age: Number,
    retire_age: Number,
    current_assets: Number,
    annual_return: Number, // 年化收益率
    inflation_rate: Number // 通胀率
  },
  result: {
    fire_index: Number,    // FIRE指数
    target_assets: Number, // 目标资产
    gap: Number            // 缺口
  },
  version: Number,
  created_at: Date
}

// assets - 用户资产
{
  _id: ObjectId,
  user_id: ObjectId,
  type: String,            // 类型: pension/fund/insurance
  name: String,            // 资产名称
  principal: Number,       // 本金
  current_value: Number,   // 当前市值
  return_rate: Number,     // 收益率
  risk_level: String,      // 风险等级: low/medium/high
  created_at: Date,
  updated_at: Date
}

// conversations - AI对话
{
  _id: ObjectId,
  user_id: ObjectId,
  messages: Array<{        // 消息链
    role: String,          // user/assistant
    content: String,
    timestamp: Date
  }>,
  context: Object,         // 上下文数据
  created_at: Date,
  updated_at: Date
}

// knowledge_base - 知识库
{
  _id: ObjectId,
  title: String,
  category: String,        // 分类: report/practice/city/law
  content: String,         // Markdown内容
  cover_image: String,
  author: String,
  tags: Array<String>,
  embedding: Array<Number>, // 向量embedding
  views: Number,
  created_at: Date,
  updated_at: Date
}

// reports - 生成的报告
{
  _id: ObjectId,
  user_id: ObjectId,
  type: String,            // 类型: fire_plan/asset_analysis
  title: String,
  file_url: String,        // PDF文件URL
  status: String,          // 状态: generating/completed/failed
  created_at: Date
}

// notifications - 通知
{
  _id: ObjectId,
  user_id: ObjectId,
  type: String,            // 类型: comment/like/mention/system
  from_user_id: ObjectId,
  content: String,
  link: String,            // 跳转链接
  is_read: Boolean,
  created_at: Date
}

// admins - 管理员 (新增)
{
  _id: ObjectId,
  username: String,        // 登录账号(唯一)
  password_hash: String,   // 密码哈希
  nickname: String,        // 显示名称
  role: String,            // 角色: super_admin/admin/operator
  permissions: Array<String>, // 权限列表
  last_login: Date,
  created_at: Date,
  is_active: Boolean
}
```

### 索引策略

```javascript
// users
db.users.createIndex({ phone: 1 }, { unique: true })
db.users.createIndex({ email: 1 }, { unique: true, sparse: true })
db.users.createIndex({ is_deleted: 1, created_at: -1 })

// posts
db.posts.createIndex({ user_id: 1, created_at: -1 })
db.posts.createIndex({ tags: 1, created_at: -1 })
db.posts.createIndex({ is_deleted: 1, is_public: 1, created_at: -1 })
db.posts.createIndex({ "location.coordinates": "2dsphere" })

// comments
db.comments.createIndex({ post_id: 1, created_at: -1 })
db.comments.createIndex({ parent_id: 1 })

// cities
db.cities.createIndex({ name_zh: "text", name_en: "text" })
db.cities.createIndex({ "scores.living_cost": 1 })

// fire_plans
db.fire_plans.createIndex({ user_id: 1, created_at: -1 })

// assets
db.assets.createIndex({ user_id: 1 })

// conversations
db.conversations.createIndex({ user_id: 1, updated_at: -1 })

// knowledge_base
db.knowledge_base.createIndex({ category: 1, created_at: -1 })
db.knowledge_base.createIndex({ title: "text", content: "text" })
db.knowledge_base.createIndex({ tags: 1 })

// notifications
db.notifications.createIndex({ user_id: 1, is_read: 1, created_at: -1 })

// admins
db.admins.createIndex({ username: 1 }, { unique: true })
db.admins.createIndex({ is_active: 1 })
```

### 扩展性设计
- **预留字段**: metadata(JSON), ext_data(JSON), tags(Array)
- **软删除**: deleted_at, is_deleted
- **版本控制**: version, updated_at
- **地理位置**: GeoJSON格式支持2dsphere索引
- **全文搜索**: text索引支持中英文搜索

---

## 3. API 响应规范

### 统一响应格式

```javascript
// 成功响应
{
  "success": true,
  "data": {
    // 业务数据
  },
  "message": "操作成功",
  "timestamp": 1710234567890
}

// 分页响应
{
  "success": true,
  "data": {
    "items": [...],
    "pagination": {
      "page": 1,
      "pageSize": 20,
      "total": 100,
      "hasMore": true
    }
  },
  "timestamp": 1710234567890
}

// 错误响应
{
  "success": false,
  "error": {
    "code": "AUTH_001",
    "message": "Token已过期",
    "details": {}
  },
  "timestamp": 1710234567890
}
```

### 错误码定义

```javascript
// 认证相关 (AUTH_xxx)
AUTH_001: "Token已过期"
AUTH_002: "Token无效"
AUTH_003: "验证码错误"
AUTH_004: "验证码已过期"
AUTH_005: "手机号已注册"
AUTH_006: "未登录"

// 业务相关 (BIZ_xxx)
BIZ_001: "资源不存在"
BIZ_002: "权限不足"
BIZ_003: "参数错误"
BIZ_004: "操作频繁"
BIZ_005: "文件格式不支持"
BIZ_006: "文件大小超限"

// 系统相关 (SYS_xxx)
SYS_001: "服务器内部错误"
SYS_002: "数据库连接失败"
SYS_003: "第三方服务异常"
SYS_004: "AI服务超时"

// FIRE相关 (FIRE_xxx)
FIRE_001: "退休年龄必须大于当前年龄"
FIRE_002: "资产金额不能为负"
FIRE_003: "计划版本已存在"

// 社区相关 (POST_xxx)
POST_001: "内容包含敏感词"
POST_002: "图片数量超限(最多9张)"
POST_003: "视频大小超限(最大200MB)"
POST_004: "帖子不存在或已删除"
```

### HTTP 状态码使用
- **200**: 成功
- **201**: 创建成功
- **400**: 请求参数错误
- **401**: 未认证
- **403**: 无权限
- **404**: 资源不存在
- **429**: 请求过于频繁
- **500**: 服务器内部错误
- **503**: 服务不可用

---

## 4. UI设计规范

### Design Token体系

```swift
// 色彩系统
Colors.primary (品牌黄 #FFD93D)
Colors.background (深色背景 #0A0E27 / 卡片 #1A1F3A)
Colors.text (主文本 #FFFFFF / 次级 #8F92A1)
Colors.success (养老金绿 #00D9A3)
Colors.risk (风险红 #FF4D4D)

// 字体系统
Typography.h1 - h6
Typography.body / bodyBold
Typography.caption

// 间距系统
Spacing.xs(4) / s(8) / m(16) / l(24) / xl(32)

// 圆角系统
Radius.small(8) / medium(12) / large(16) / card(20)

// 阴影系统
Shadow.card / dialog / float
```

### 组件库分层
```
Atoms: Button, Input, Tag, Avatar, Badge
Molecules: CardView, ListItem, SearchBar, TabBar
Organisms: PostCard, CityCard, AssetPanel, ChatBubble
Templates: FeedLayout, ProfileLayout, FormLayout
```

### 全局状态管理
```swift
AppTheme (EnvironmentObject)
  ├── colorScheme
  ├── typography
  ├── spacing
  └── update() -> 全局刷新UI
```

---

## 5. 架构设计

### 前端架构

```
YOUNGApp/
├── App/
│   ├── YOUNGApp.swift (入口)
│   └── AppCoordinator.swift (路由)
├── Core/
│   ├── DesignSystem/ (Token+Components)
│   ├── Network/ (APIClient)
│   ├── Storage/ (CoreData+Keychain)
│   └── Extensions/
├── Features/
│   ├── Auth/
│   ├── FIRE/
│   ├── Community/
│   ├── City/
│   ├── AI/
│   ├── Asset/
│   └── Profile/
├── Shared/
│   ├── Models/
│   ├── ViewModels/
│   └── Utils/
└── Resources/
```

**设计原则**
- MVVM + Combine
- 单向数据流
- 依赖注入(Protocol)
- 可测试性优先

---

### 后端架构

```
young-api/
├── src/
│   ├── config/ (环境变量+常量)
│   ├── middleware/ (auth/log/error)
│   ├── models/ (Mongoose Schemas)
│   ├── routes/ (路由模块)
│   ├── controllers/ (业务逻辑)
│   ├── services/ (第三方服务封装)
│   ├── utils/ (工具函数)
│   └── app.js (Fastify实例)
├── tests/
├── docs/ (API文档)
└── scripts/ (部署/迁移脚本)
```

**设计原则**
- RESTful API
- 三层架构(Route->Controller->Service)
- 错误统一处理
- 日志分级记录
- 可横向扩展

---

### 管理后台架构

```
young-admin/
├── src/
│   ├── views/              # 页面视图
│   │   ├── Dashboard/      # 数据看板
│   │   ├── City/           # 城市管理
│   │   ├── Knowledge/      # 知识库管理
│   │   ├── User/           # 用户管理
│   │   ├── Post/           # 内容管理
│   │   ├── Asset/          # 资产数据
│   │   ├── Conversation/   # AI对话记录
│   │   ├── System/         # 系统配置
│   │   └── Login/          # 登录页
│   ├── components/         # 公共组件
│   │   ├── Layout/         # 布局组件
│   │   ├── Table/          # 表格组件
│   │   ├── Form/           # 表单组件
│   │   └── Chart/          # 图表组件
│   ├── api/                # API 接口封装
│   ├── router/             # 路由配置
│   ├── store/              # Pinia 状态管理
│   ├── utils/              # 工具函数
│   ├── styles/             # 全局样式
│   ├── App.vue
│   └── main.js
├── public/
├── package.json
├── vite.config.js
└── README.md
```

**设计原则**
- 组件化开发
- 基于 Element Plus 快速搭建
- 统一 API 封装
- 权限路由控制
- 响应式布局

---

## 6. 关键技术点

### 前端
- **SwiftUI动画**: matchedGeometryEffect实现页面转场
- **图表绘制**: Swift Charts绘制FIRE曲线
- **视频播放**: AVKit内嵌播放器
- **图片上传**: Multipart压缩+进度显示
- **主题切换**: EnvironmentObject驱动全局刷新

### 后端
- **AI流式输出**: SSE(Server-Sent Events)
- **向量检索**: Embedding+相似度计算
- **定时任务**: node-cron更新城市数据
- **缓存策略**: Redis热点数据+TTL管理
- **文件上传**: Busboy流式处理+OSS

---

## 7. 数据安全

- 密码: bcrypt加密存储
- Token: JWT(15min) + Refresh Token(7天)
- 敏感数据: AES-256加密
- HTTPS: 全站TLS 1.3
- 接口鉴权: Bearer Token + Rate Limit
- 数据备份: 每日增量 + 每周全量

---

## 8. 性能指标

### 前端

#### iOS App
- 首屏加载: <2s
- 列表滑动: 60fps
- 图片懒加载: LazyVStack + onAppear
- 包体积: <50MB

#### 官方网站 🆕
- Lighthouse Performance: >95
- LCP (Largest Contentful Paint): <2.5s
- FID (First Input Delay): <100ms
- CLS (Cumulative Layout Shift): <0.1
- 所有动画: 60fps 流畅
- 首屏加载: <2s

### 后端
- API响应: P95 <500ms
- 并发支持: 1000 QPS
- 数据库连接池: 50个连接
- Redis缓存命中率: >80%

---

## 9. 监控与日志

- **APM**: Sentry实时错误追踪
- **日志**: Winston分级日志(info/warn/error)
- **埋点**: 用户行为漏斗分析
- **告警规则**:
  - 错误率 >5% 触发告警
  - API P95响应时间 >1s 触发告警
  - 数据库连接数 >45 触发告警
  - Redis内存使用率 >80% 触发告警
  - 崩溃率 >1% 触发告警
- **日志保留**: 30天滚动删除
- **监控看板**: Grafana实时展示关键指标

---

## 11. 依赖清单

### iOS
```
Kingfisher (图片加载缓存)
SwiftGen (资源管理)
```

### Node.js (API)
```
fastify (Web框架)
mongoose (MongoDB ORM)
ioredis (Redis客户端)
jsonwebtoken (JWT)
bcryptjs (密码加密)
langchain (AI编排)
@pinecone-database/pinecone (向量数据库)
busboy (文件上传)
winston (日志)
joi (参数校验)
```

### Vue3 (管理后台) 🆕
```
vue (^3.4.0)
vite (^5.0.0)
element-plus (^2.5.0)
vue-router (^4.0.0)
pinia (^2.0.0)
axios (^1.6.0)
echarts (^5.4.0)
v-md-editor (Markdown编辑器)
dayjs (日期处理)
lodash-es (工具库)
```

### React (官方网站) 🆕
```
react (^18.2.0)
react-dom (^18.2.0)
next (^14.1.0)
typescript (^5.0.0)
gsap (^3.12.5) ⭐
@gsap/react (^2.1.0)
three (^0.161.0)
@react-three/fiber (^8.15.0)
tailwindcss (^3.4.0)
lucide-react (^0.323.0)
```

---

**文档版本**: v1.1  
**最后更新**: 2026-03-15  
**维护人**: 晨曦

**更新日志**:
- 2026-03-15: 新增管理后台技术栈、项目结构、admins集合；新增官方网站详细技术方案
- 2026-03-12: 初始版本
