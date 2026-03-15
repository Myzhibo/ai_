# 养Young 管理后台设计文档 v1.0

> 💰 **重要**: 关于付费功能使用规则，请查看 [付费操作确认规则.md](./付费操作确认规则.md)

---

## 1. 项目定位

为养Young App提供数据管理、内容运营、用户管理的可视化管理后台系统。

**核心价值**:
- 📊 可视化数据管理，替代手动操作数据库
- 🚀 提升开发效率，快速维护测试数据
- 🛡️ 支撑运营工作，内容审核与用户管理
- 📈 数据分析看板，实时监控核心指标

**目标用户**:
- 产品运营人员
- 内容审核人员
- 数据分析人员
- 技术开发人员

---

## 2. 技术栈

### 前端框架
```javascript
{
  "框架": "Vue 3.4+ (Composition API)",
  "构建工具": "Vite 5+",
  "UI组件库": "Element Plus 2.5+",
  "路由": "Vue Router 4",
  "状态管理": "Pinia 2",
  "HTTP客户端": "Axios 1.6+",
  "图表库": "ECharts 5",
  "Markdown编辑器": "v-md-editor",
  "工具库": "lodash-es, dayjs"
}
```

### 开发工具
```javascript
{
  "包管理器": "pnpm",
  "代码规范": "ESLint + Prettier",
  "Git Hooks": "husky + lint-staged",
  "类型检查": "TypeScript (可选)"
}
```

### 部署方案
- **开发环境**: Vite Dev Server (本地)
- **生产环境**: Nginx 静态部署 (与API同服务器)
- **构建产物**: 静态HTML/CSS/JS

---

## 3. 功能模块设计

### 3.1 登录认证

**路由**: `/login`

**功能说明**:
- 管理员账号密码登录
- JWT Token 认证
- 记住登录状态(7天)
- 登录日志记录

**关键点**:
- ✅ 使用简单的账号密码登录(不需要短信验证码)
- ✅ 本地存储 Token (localStorage)
- ✅ Token 过期自动跳转登录页

**接口**:
```javascript
POST /api/admin/login
{
  username: "admin",
  password: "******"
}

// 响应
{
  success: true,
  data: {
    token: "eyJhbGc...",
    admin: {
      id: "xxx",
      username: "admin",
      nickname: "管理员",
      role: "super_admin",
      permissions: ["all"]
    }
  }
}
```

---

### 3.2 数据看板 (Dashboard)

**路由**: `/dashboard`

**功能说明**:
- 核心指标展示(用户数、帖子数、DAU/MAU等)
- 数据趋势图表(7天/30天)
- 实时数据刷新
- 快捷入口导航

**关键指标**:
```
用户统计:
- 总用户数
- 新增用户(今日/本周/本月)
- DAU/MAU
- 付费用户数

内容统计:
- 总帖子数
- 今日发帖量
- 待审核帖子数
- 评论总数

城市数据:
- 城市总数
- 热门城市TOP10

知识库:
- 文章总数
- 分类分布
- 阅读量TOP10

AI对话:
- 今日对话次数
- 平均对话轮数
```

**图表类型**:
- 折线图: 用户增长趋势
- 柱状图: 每日发帖量
- 饼图: 内容分类占比
- 数字卡片: 核心指标

**接口**:
```javascript
GET /api/admin/dashboard/stats
GET /api/admin/dashboard/trends?days=7
```

---

### 3.3 城市管理 (City Management)

**路由**: `/city`

**优先级**: ⭐⭐⭐ (最高优先级)

**功能说明**:
- 城市列表(搜索/筛选/分页)
- 新增城市
- 编辑城市信息
- 城市评分维护
- 封面图片上传(初期使用默认图片)
- 批量导入(CSV/Excel)

**列表字段**:
```
- 城市ID
- 中文名 / 英文名
- 国家
- 综合评分
- 月生活成本
- 创建时间
- 操作(编辑/删除)
```

**表单字段**:
```javascript
{
  name_zh: "清迈",
  name_en: "Chiang Mai",
  country: "泰国",
  scores: {
    living_cost: 8.5,      // 生活成本 0-10
    healthcare: 7.0,       // 医疗水平
    air_quality: 6.5,      // 空气质量
    nomad_friendly: 9.0,   // 数字游民友好度
    climate: 8.0,          // 气候宜居
    culture: 8.5           // 文化包容
  },
  monthly_cost: 6200,      // 月生活成本(CNY)
  cover_image: "/defaults/cities/chiang-mai.jpg",
  description: "城市简介(Markdown)"
}
```

**功能亮点**:
- 评分滑块组件(0-10)
- 实时计算综合评分
- 城市对比预览
- 数据导出(Excel)

**接口**:
```javascript
GET /api/admin/cities?page=1&pageSize=20&keyword=清迈
POST /api/admin/cities
PUT /api/admin/cities/:id
DELETE /api/admin/cities/:id
POST /api/admin/cities/import (批量导入)
```

---

### 3.4 知识库管理 (Knowledge Base)

**路由**: `/knowledge`

**优先级**: ⭐⭐⭐ (最高优先级)

**功能说明**:
- 文章列表(搜索/筛选/分页)
- 新增文章
- 编辑文章(Markdown编辑器)
- 分类管理
- 标签管理
- 发布/下线控制
- 文章预览

**列表字段**:
```
- 文章ID
- 标题
- 分类
- 标签
- 作者
- 阅读量
- 状态(草稿/已发布)
- 创建时间
- 操作(编辑/预览/删除)
```

**表单字段**:
```javascript
{
  title: "如何用4%法则计算FIRE目标",
  category: "practice",     // report/practice/city/law
  content: "Markdown内容...",
  cover_image: "/defaults/knowledge/fire.jpg",
  author: "晨曦",
  tags: ["FIRE", "理财规划", "退休"],
  status: "published",      // draft/published
  is_featured: false        // 是否精选
}
```

**Markdown 编辑器**:
- 实时预览
- 图片上传(初期使用默认图片)
- 语法高亮
- 目录生成

**分类管理**:
```
- 精选报告 (report)
- FIRE实践 (practice)
- 城市评测 (city)
- 法律合规 (law)
```

**接口**:
```javascript
GET /api/admin/knowledge?page=1&category=practice
POST /api/admin/knowledge
PUT /api/admin/knowledge/:id
DELETE /api/admin/knowledge/:id
GET /api/admin/knowledge/:id/preview
```

---

### 3.5 用户管理 (User Management)

**路由**: `/user`

**优先级**: ⭐⭐

**功能说明**:
- 用户列表(搜索/筛选/分页)
- 用户详情查看
- 测试账号快速创建
- 会员等级修改
- 用户封禁/解封
- 用户数据导出

**列表字段**:
```
- 用户ID
- 昵称
- 手机号
- 会员等级(免费/专业版/黑金)
- 注册时间
- 最后登录
- 状态(正常/封禁)
- 操作(查看详情/编辑)
```

**用户详情**:
```
基础信息:
- 昵称、头像、手机号、邮箱
- 会员等级、认证状态
- 注册时间、最后登录

FIRE数据:
- 当前资产、退休目标年龄
- FIRE指数、目标缺口
- 计划版本数

社区数据:
- 发帖数、评论数
- 获赞数、关注/粉丝数

资产数据:
- 总资产、持仓明细
- 收益率

AI使用:
- 对话次数、最近咨询时间
```

**快速创建测试用户**:
```javascript
{
  nickname: "测试用户01",
  phone: "13800138000",
  password: "test123",
  membership_tier: "free",
  // 自动生成其他字段
}
```

**接口**:
```javascript
GET /api/admin/users?page=1&keyword=张三&membership=premium
GET /api/admin/users/:id
POST /api/admin/users (创建测试用户)
PUT /api/admin/users/:id
POST /api/admin/users/:id/ban (封禁)
POST /api/admin/users/:id/unban (解封)
```

---

### 3.6 内容管理 (Post Management)

**路由**: `/post`

**优先级**: ⭐⭐

**功能说明**:
- 帖子列表(搜索/筛选/分页)
- 帖子详情查看
- 快速创建测试帖子
- 帖子删除/置顶
- 内容审核(待审核队列)
- 评论管理

**列表字段**:
```
- 帖子ID
- 作者
- 内容摘要
- 类型(图文/视频/纯文本)
- 标签
- 点赞数/评论数/浏览数
- 状态(正常/待审核/已删除)
- 发布时间
- 操作(查看/删除/置顶)
```

**帖子详情**:
```
- 完整内容
- 媒体资源(图片/视频)
- 发布者信息
- 地理位置
- 互动数据(点赞列表、评论列表)
- 举报记录
```

**快速创建测试帖子**:
```javascript
{
  user_id: "选择测试用户",
  content: "帖子内容...",
  type: "text",
  tags: ["FIRE生活", "数字游民"],
  is_public: true
}
```

**内容审核**:
- 待审核队列(新发布/被举报)
- 审核操作(通过/拒绝/删除)
- 审核理由记录

**接口**:
```javascript
GET /api/admin/posts?page=1&status=normal
GET /api/admin/posts/:id
POST /api/admin/posts (创建测试帖子)
DELETE /api/admin/posts/:id
PUT /api/admin/posts/:id/pin (置顶)
GET /api/admin/posts/pending (待审核列表)
POST /api/admin/posts/:id/review (审核)
```

---

### 3.7 资产数据 (Asset Data)

**路由**: `/asset`

**优先级**: ⭐

**功能说明**:
- 用户资产列表
- 资产类型统计
- 资产明细查看
- 数据导出

**列表视图**:
```
按用户维度:
- 用户信息
- 总资产
- 持仓数量
- 最后更新时间

按资产维度:
- 资产类型(养老金/基金/保险)
- 用户
- 本金/市值
- 收益率
```

**接口**:
```javascript
GET /api/admin/assets?user_id=xxx
GET /api/admin/assets/stats
```

---

### 3.8 AI对话记录 (Conversation Logs)

**路由**: `/conversation`

**优先级**: ⭐

**功能说明**:
- 对话列表(按用户/时间筛选)
- 对话详情查看
- 对话质量评估
- 问题统计分析

**列表字段**:
```
- 对话ID
- 用户
- 消息轮数
- 创建时间
- 最后更新
- 操作(查看详情)
```

**对话详情**:
```
完整对话链:
- 用户问题
- AI回答
- 时间戳
```

**统计分析**:
- 高频问题TOP10
- 平均对话轮数
- 用户满意度(如果有反馈)

**接口**:
```javascript
GET /api/admin/conversations?page=1&user_id=xxx
GET /api/admin/conversations/:id
GET /api/admin/conversations/stats
```

---

### 3.9 系统配置 (System Config)

**路由**: `/system`

**优先级**: ⭐

**功能说明**:
- 系统参数配置
- 管理员账号管理
- 操作日志查看
- 数据备份/恢复

**系统参数**:
```
推荐算法:
- 推荐权重配置
- 热度计算公式

内容审核:
- 敏感词库管理
- 自动审核规则

通知推送:
- 推送开关
- 推送频率限制
```

**管理员管理**:
- 管理员列表
- 新增管理员
- 角色权限配置
- 密码修改

**操作日志**:
```
- 操作人
- 操作类型(新增/修改/删除)
- 操作对象
- 操作时间
- IP地址
```

**接口**:
```javascript
GET /api/admin/system/config
PUT /api/admin/system/config
GET /api/admin/admins
POST /api/admin/admins
GET /api/admin/logs?page=1
```

---

## 4. UI/UX 设计

### 4.1 布局结构

```
┌─────────────────────────────────────────┐
│  Header (顶部导航栏)                      │
│  - Logo + 系统名称                        │
│  - 管理员信息 + 退出登录                   │
├──────────┬──────────────────────────────┤
│          │                              │
│  Sidebar │  Main Content               │
│  (侧边栏) │  (主内容区)                  │
│          │                              │
│  - 数据看板│  - 页面标题                  │
│  - 城市管理│  - 操作按钮                  │
│  - 知识库  │  - 数据表格/表单             │
│  - 用户管理│  - 分页器                    │
│  - 内容管理│                              │
│  - ...    │                              │
│          │                              │
│          │                              │
└──────────┴──────────────────────────────┘
```

### 4.2 色彩方案

```css
/* 品牌色 */
--primary-color: #FFD93D;        /* 主题黄 */
--primary-dark: #E5C235;
--primary-light: #FFF2B2;

/* 功能色 */
--success-color: #00D9A3;        /* 成功/养老金绿 */
--warning-color: #FF9F43;        /* 警告橙 */
--danger-color: #FF4D4D;         /* 危险/风险红 */
--info-color: #4A90E2;           /* 信息蓝 */

/* 中性色 */
--bg-color: #F5F7FA;             /* 背景灰 */
--border-color: #DCDFE6;         /* 边框灰 */
--text-primary: #303133;         /* 主文本 */
--text-secondary: #606266;       /* 次文本 */
--text-placeholder: #C0C4CC;     /* 占位文本 */
```

### 4.3 组件规范

**表格 (Table)**:
- 斑马纹
- 悬停高亮
- 固定表头
- 操作列固定右侧

**表单 (Form)**:
- 标签右对齐
- 必填项标红星
- 实时验证
- 错误提示

**按钮 (Button)**:
- 主要按钮: 品牌黄
- 危险按钮: 红色
- 默认按钮: 白底黑字

**弹窗 (Dialog)**:
- 居中显示
- 遮罩背景
- 确认/取消按钮

---

## 5. 路由配置

```javascript
const routes = [
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/Login/index.vue'),
    meta: { title: '登录', noAuth: true }
  },
  {
    path: '/',
    component: Layout,
    redirect: '/dashboard',
    children: [
      {
        path: 'dashboard',
        name: 'Dashboard',
        component: () => import('@/views/Dashboard/index.vue'),
        meta: { title: '数据看板', icon: 'dashboard' }
      },
      {
        path: 'city',
        name: 'City',
        component: () => import('@/views/City/index.vue'),
        meta: { title: '城市管理', icon: 'location' }
      },
      {
        path: 'knowledge',
        name: 'Knowledge',
        component: () => import('@/views/Knowledge/index.vue'),
        meta: { title: '知识库管理', icon: 'reading' }
      },
      {
        path: 'user',
        name: 'User',
        component: () => import('@/views/User/index.vue'),
        meta: { title: '用户管理', icon: 'user' }
      },
      {
        path: 'post',
        name: 'Post',
        component: () => import('@/views/Post/index.vue'),
        meta: { title: '内容管理', icon: 'document' }
      },
      {
        path: 'asset',
        name: 'Asset',
        component: () => import('@/views/Asset/index.vue'),
        meta: { title: '资产数据', icon: 'money' }
      },
      {
        path: 'conversation',
        name: 'Conversation',
        component: () => import('@/views/Conversation/index.vue'),
        meta: { title: 'AI对话记录', icon: 'chat-dot-round' }
      },
      {
        path: 'system',
        name: 'System',
        component: () => import('@/views/System/index.vue'),
        meta: { title: '系统配置', icon: 'setting' }
      }
    ]
  }
]
```

---

## 6. API 封装

### 6.1 Axios 实例配置

```javascript
// src/utils/request.js
import axios from 'axios'
import { ElMessage } from 'element-plus'
import { useUserStore } from '@/store/user'
import router from '@/router'

const service = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL || 'http://localhost:3000/api',
  timeout: 15000
})

// 请求拦截器
service.interceptors.request.use(
  config => {
    const userStore = useUserStore()
    if (userStore.token) {
      config.headers['Authorization'] = `Bearer ${userStore.token}`
    }
    return config
  },
  error => {
    return Promise.reject(error)
  }
)

// 响应拦截器
service.interceptors.response.use(
  response => {
    const res = response.data
    if (res.success) {
      return res.data
    } else {
      ElMessage.error(res.error?.message || '请求失败')
      return Promise.reject(new Error(res.error?.message || '请求失败'))
    }
  },
  error => {
    if (error.response?.status === 401) {
      ElMessage.error('登录已过期，请重新登录')
      const userStore = useUserStore()
      userStore.logout()
      router.push('/login')
    } else {
      ElMessage.error(error.message || '网络错误')
    }
    return Promise.reject(error)
  }
)

export default service
```

### 6.2 API 模块化

```javascript
// src/api/city.js
import request from '@/utils/request'

export function getCityList(params) {
  return request({
    url: '/admin/cities',
    method: 'get',
    params
  })
}

export function createCity(data) {
  return request({
    url: '/admin/cities',
    method: 'post',
    data
  })
}

export function updateCity(id, data) {
  return request({
    url: `/admin/cities/${id}`,
    method: 'put',
    data
  })
}

export function deleteCity(id) {
  return request({
    url: `/admin/cities/${id}`,
    method: 'delete'
  })
}
```

---

## 7. 状态管理 (Pinia)

```javascript
// src/store/user.js
import { defineStore } from 'pinia'
import { login as loginApi } from '@/api/auth'

export const useUserStore = defineStore('user', {
  state: () => ({
    token: localStorage.getItem('admin_token') || '',
    userInfo: JSON.parse(localStorage.getItem('admin_info') || '{}')
  }),
  
  getters: {
    isLogin: (state) => !!state.token
  },
  
  actions: {
    async login(username, password) {
      const data = await loginApi({ username, password })
      this.token = data.token
      this.userInfo = data.admin
      localStorage.setItem('admin_token', data.token)
      localStorage.setItem('admin_info', JSON.stringify(data.admin))
    },
    
    logout() {
      this.token = ''
      this.userInfo = {}
      localStorage.removeItem('admin_token')
      localStorage.removeItem('admin_info')
    }
  }
})
```

---

## 8. 开发计划

### Phase 1: 基础框架 (2天)

**任务**:
- [x] 项目初始化(Vite + Vue3)
- [x] Element Plus 集成
- [x] 路由配置
- [x] Pinia 状态管理
- [x] Axios 封装
- [x] 布局组件(Layout/Header/Sidebar)

### Phase 2: 核心功能 (7天)

**Day 1-2: 登录 + 城市管理**
- [x] 登录页面
- [x] 城市列表
- [x] 城市新增/编辑表单
- [x] 评分滑块组件

**Day 3-4: 知识库管理**
- [x] 知识库列表
- [x] Markdown 编辑器集成
- [x] 分类/标签管理
- [x] 文章预览

**Day 5: 用户管理**
- [x] 用户列表
- [x] 用户详情
- [x] 测试用户创建

**Day 6: 内容管理**
- [x] 帖子列表
- [x] 帖子详情
- [x] 测试帖子创建

**Day 7: 数据看板**
- [x] 核心指标卡片
- [x] 趋势图表(ECharts)
- [x] 快捷入口

### Phase 3: 完善优化 (2天)

**任务**:
- [x] 权限控制
- [x] 错误处理
- [x] 响应式适配
- [x] 性能优化
- [x] 打包部署配置

---

## 9. 部署方案

### 开发环境

```bash
# 安装依赖
pnpm install

# 启动开发服务器
pnpm dev

# 访问地址
http://localhost:5173
```

### 生产环境

```bash
# 构建
pnpm build

# 产物目录
dist/
```

**Nginx 配置**:
```nginx
server {
  listen 80;
  server_name admin.young.com;
  
  root /var/www/young-admin/dist;
  index index.html;
  
  location / {
    try_files $uri $uri/ /index.html;
  }
  
  location /api {
    proxy_pass http://localhost:3000;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
  }
}
```

---

## 10. 安全策略

### 认证鉴权
- JWT Token 认证
- Token 过期时间: 7天
- 自动刷新机制

### 权限控制
- 角色权限: super_admin / admin / operator
- 路由级别权限
- 按钮级别权限

### 数据安全
- HTTPS 传输
- 敏感信息加密
- SQL 注入防护
- XSS 防护

### 操作审计
- 关键操作日志
- 操作人追溯
- IP地址记录

---

## 11. 测试策略

### 单元测试
- 工具函数测试
- Store 测试

### 集成测试
- API 接口联调
- 页面功能测试

### 手动测试清单
```
[ ] 登录/登出功能
[ ] 城市数据 CRUD
[ ] 知识库文章 CRUD
[ ] 用户列表查询
[ ] 内容管理操作
[ ] 数据看板展示
[ ] 响应式布局
[ ] 权限控制
```

---

## 12. 维护与迭代

### 持续优化
- 根据运营反馈优化功能
- 性能监控与优化
- 代码质量提升

### 功能扩展
- 数据导出(Excel/CSV)
- 批量操作功能
- 高级筛选/搜索
- 数据可视化增强

---

**文档版本**: v1.0  
**创建时间**: 2026-03-15  
**最后更新**: 2026-03-15  
**维护人**: 晨曦
