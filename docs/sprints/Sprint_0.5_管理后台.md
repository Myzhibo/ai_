# Sprint 0.5: 管理后台 v1.0

**时长**: 1.5周  
**状态**: 📋 待开始  
**优先级**: P0 (最高)

---

## 目标

开发管理后台系统,提供可视化的数据管理工具,替代手动操作数据库,为后续 App 开发提供高效的数据维护支持。

---

## 核心价值

1. ✅ **提升开发效率**: 可视化管理数据,无需编写脚本
2. ✅ **降低出错率**: 表单验证和友好提示,减少数据错误
3. ✅ **支撑运营工作**: Beta 测试阶段即可使用内容审核功能
4. ✅ **团队协作**: 非技术人员也能参与数据维护

---

## 任务清单

### 第一天: 项目初始化

- [ ] 创建 Vue3 + Vite 项目
- [ ] 安装依赖(Element Plus, Vue Router, Pinia, Axios, ECharts)
- [ ] 配置 ESLint + Prettier
- [ ] 创建项目目录结构
- [ ] 配置环境变量(.env)

### 第二天: 基础架构

- [ ] 布局组件(Layout/Header/Sidebar)
- [ ] 路由配置(9个主要路由)
- [ ] Axios 请求封装(拦截器/错误处理)
- [ ] Pinia Store (user/app)
- [ ] 登录页面开发
- [ ] Token 认证逻辑

### 第三天: 城市管理 ⭐

- [ ] 城市列表页面(表格/搜索/分页)
- [ ] 城市新增弹窗
- [ ] 城市编辑弹窗
- [ ] 评分滑块组件(6个维度)
- [ ] 城市删除确认
- [ ] 接口联调

### 第四天: 知识库管理 ⭐

- [ ] 知识库列表页面
- [ ] Markdown 编辑器集成(v-md-editor)
- [ ] 文章新增/编辑表单
- [ ] 分类选择器
- [ ] 标签输入组件
- [ ] 文章预览功能
- [ ] 接口联调

### 第五天: 用户管理 ⭐

- [ ] 用户列表页面
- [ ] 用户详情抽屉
- [ ] 测试用户快速创建表单
- [ ] 会员等级修改
- [ ] 用户封禁/解封
- [ ] 接口联调

### 第六天: 内容管理 ⭐

- [ ] 帖子列表页面
- [ ] 帖子详情抽屉
- [ ] 测试帖子快速创建
- [ ] 帖子删除/置顶
- [ ] 评论列表
- [ ] 接口联调

### 第七天: 数据看板

- [ ] Dashboard 页面布局
- [ ] 核心指标卡片(用户数/帖子数等)
- [ ] ECharts 图表(用户增长/发帖趋势)
- [ ] 快捷入口
- [ ] 接口联调

### 第八天: 其他功能

- [ ] 资产数据页面(简单列表)
- [ ] AI 对话记录页面(简单列表)
- [ ] 系统配置页面(基础框架)
- [ ] 管理员信息显示
- [ ] 退出登录功能

### 第九天: 测试与优化

- [ ] 功能测试(所有页面)
- [ ] 响应式适配
- [ ] 错误处理完善
- [ ] 加载状态优化
- [ ] 权限控制测试

### 第十天: 数据录入 🎯

- [ ] 录入 50+ 城市数据
- [ ] 录入 20+ 知识库文章
- [ ] 创建 5+ 测试用户
- [ ] 创建 30+ 测试帖子
- [ ] 数据质量检查

### 第十一天: 部署与文档

- [ ] 构建生产版本
- [ ] 配置 Nginx
- [ ] 部署到服务器
- [ ] 编写使用文档
- [ ] 团队培训

---

## 验收标准

### 功能完整性
- [ ] 9个核心页面全部完成(登录/看板/城市/知识库/用户/内容/资产/对话/系统)
- [ ] 所有 CRUD 操作正常工作
- [ ] 表单验证完整准确
- [ ] 错误提示友好清晰

### 数据质量
- [ ] 城市数据 >= 50 条(包含热门城市)
- [ ] 知识库文章 >= 20 篇(涵盖各分类)
- [ ] 测试用户 >= 5 个(不同会员等级)
- [ ] 测试帖子 >= 30 条(不同类型)

### 性能指标
- [ ] 页面加载 < 2s
- [ ] 列表操作流畅(60fps)
- [ ] 打包体积 < 1MB (gzip)

### 用户体验
- [ ] 响应式布局(适配1920/1440/1280分辨率)
- [ ] 操作反馈及时(Loading/Success/Error)
- [ ] 交互逻辑清晰
- [ ] 样式统一美观

---

## 测试用例

### TC-0.5.1: 管理员登录
**步骤**:
1. 访问 http://admin.young.com
2. 输入账号: admin, 密码: admin123
3. 点击登录

**预期结果**: 
- 登录成功,跳转到数据看板
- Token 存储到 localStorage
- 侧边栏显示管理员昵称

---

### TC-0.5.2: 城市数据管理
**步骤**:
1. 进入"城市管理"页面
2. 点击"新增城市"按钮
3. 填写城市信息:
   - 中文名: 清迈
   - 英文名: Chiang Mai
   - 国家: 泰国
   - 6个评分维度
   - 月生活成本: 6200
4. 点击"保存"

**预期结果**:
- 保存成功提示
- 列表中显示新城市
- 数据库中存在该记录

---

### TC-0.5.3: 知识库文章编辑
**步骤**:
1. 进入"知识库管理"
2. 点击"新增文章"
3. 输入标题、选择分类、添加标签
4. 使用 Markdown 编辑器编写内容
5. 实时预览
6. 保存文章

**预期结果**:
- Markdown 正确渲染
- 预览和编辑同步
- 保存成功并显示在列表

---

### TC-0.5.4: 快速创建测试用户
**步骤**:
1. 进入"用户管理"
2. 点击"创建测试用户"
3. 填写昵称、手机号
4. 选择会员等级
5. 保存

**预期结果**:
- 用户创建成功
- 自动生成默认头像
- 自动生成测试密码
- 可在列表中查看

---

### TC-0.5.5: 数据看板展示
**步骤**:
1. 登录后进入 Dashboard
2. 查看核心指标卡片
3. 查看趋势图表

**预期结果**:
- 所有指标数据准确
- 图表正常渲染
- 数据实时更新

---

### TC-0.5.6: 权限控制
**步骤**:
1. 未登录访问管理页面
2. Token 过期后操作

**预期结果**:
- 自动跳转到登录页
- 提示"请先登录"

---

### TC-0.5.7: 响应式布局
**步骤**:
1. 缩小浏览器窗口到 1280px
2. 查看各页面布局

**预期结果**:
- 布局自适应
- 表格横向滚动
- 侧边栏可折叠

---

### TC-0.5.8: 批量数据录入
**步骤**:
1. 使用管理后台录入 50 个城市
2. 录入 20 篇知识库文章
3. 创建 5 个测试用户
4. 创建 30 条测试帖子

**预期结果**:
- 所有数据录入成功
- 数据格式正确
- App 端可正常查询到数据

---

## 技术要点

### Vue3 Composition API
```javascript
<script setup>
import { ref, reactive, onMounted } from 'vue'
import { getCityList } from '@/api/city'

const tableData = ref([])
const loading = ref(false)
const pagination = reactive({
  page: 1,
  pageSize: 20,
  total: 0
})

const loadData = async () => {
  loading.value = true
  try {
    const data = await getCityList(pagination)
    tableData.value = data.items
    pagination.total = data.total
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  loadData()
})
</script>
```

### Element Plus 表格
```vue
<el-table :data="tableData" v-loading="loading">
  <el-table-column prop="name_zh" label="中文名" />
  <el-table-column prop="name_en" label="英文名" />
  <el-table-column prop="monthly_cost" label="月成本" />
  <el-table-column label="操作" width="180">
    <template #default="{ row }">
      <el-button type="primary" size="small" @click="handleEdit(row)">
        编辑
      </el-button>
      <el-button type="danger" size="small" @click="handleDelete(row)">
        删除
      </el-button>
    </template>
  </el-table-column>
</el-table>
```

### Markdown 编辑器
```vue
<template>
  <v-md-editor
    v-model="content"
    height="600px"
    left-toolbar="undo redo | h bold italic | ul ol | link image"
    @upload-image="handleUploadImage"
  />
</template>

<script setup>
import { ref } from 'vue'

const content = ref('# 标题\n\n内容...')

const handleUploadImage = (event, insertImage) => {
  // 初期使用默认图片
  insertImage({
    url: '/defaults/placeholder.jpg',
    desc: '图片描述'
  })
}
</script>
```

### ECharts 图表
```javascript
import * as echarts from 'echarts'

const initChart = () => {
  const chart = echarts.init(chartRef.value)
  const option = {
    title: { text: '用户增长趋势' },
    xAxis: { type: 'category', data: ['周一', '周二', '周三', '周四', '周五'] },
    yAxis: { type: 'value' },
    series: [{
      data: [120, 200, 150, 80, 70],
      type: 'line'
    }]
  }
  chart.setOption(option)
}
```

---

## 依赖关系

**前置依赖**: Sprint 0 (后端 API 基础接口)  
**后续依赖**: Sprint 1-13 (所有 Sprint 都使用后台管理数据)

---

## 风险与问题

| 风险 | 影响 | 应对措施 |
|------|------|----------|
| Markdown 编辑器集成复杂 | 中 | 使用成熟的 v-md-editor 库 |
| 数据录入工作量大 | 高 | 分工协作,使用模板批量录入 |
| 响应式适配耗时 | 低 | Element Plus 自带响应式支持 |
| 后端 API 未完成 | 高 | 与后端并行开发,及时沟通接口 |

---

## 完成标准

- ✅ 所有验收标准通过
- ✅ 所有测试用例通过
- ✅ 50+ 城市数据录入完成
- ✅ 20+ 知识库文章录入完成
- ✅ 部署到服务器可访问
- ✅ 团队成员培训完成
- ✅ 代码 Review 完成
- ✅ 文档更新完成

---

## 开发环境配置

### 安装依赖
```bash
cd young-admin
pnpm install
```

### 环境变量
```env
# .env.development
VITE_API_BASE_URL=http://localhost:3000/api
VITE_APP_TITLE=养Young管理后台
```

### 启动开发服务器
```bash
pnpm dev
# 访问 http://localhost:5173
```

### 构建生产版本
```bash
pnpm build
# 产物: dist/
```

---

## 部署配置

### Nginx 配置
```nginx
server {
  listen 80;
  server_name admin.young.local;
  
  root /var/www/young-admin/dist;
  index index.html;
  
  # SPA 路由支持
  location / {
    try_files $uri $uri/ /index.html;
  }
  
  # API 代理
  location /api {
    proxy_pass http://localhost:3000;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  }
  
  # 静态资源缓存
  location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg)$ {
    expires 1y;
    add_header Cache-Control "public, immutable";
  }
}
```

---

## 后端 API 需求

### 管理员认证
```
POST /api/admin/login
GET  /api/admin/profile
POST /api/admin/logout
```

### 城市管理
```
GET    /api/admin/cities
POST   /api/admin/cities
GET    /api/admin/cities/:id
PUT    /api/admin/cities/:id
DELETE /api/admin/cities/:id
POST   /api/admin/cities/import
```

### 知识库管理
```
GET    /api/admin/knowledge
POST   /api/admin/knowledge
GET    /api/admin/knowledge/:id
PUT    /api/admin/knowledge/:id
DELETE /api/admin/knowledge/:id
```

### 用户管理
```
GET    /api/admin/users
POST   /api/admin/users
GET    /api/admin/users/:id
PUT    /api/admin/users/:id
POST   /api/admin/users/:id/ban
POST   /api/admin/users/:id/unban
```

### 内容管理
```
GET    /api/admin/posts
POST   /api/admin/posts
GET    /api/admin/posts/:id
DELETE /api/admin/posts/:id
PUT    /api/admin/posts/:id/pin
GET    /api/admin/posts/pending
POST   /api/admin/posts/:id/review
```

### 数据看板
```
GET /api/admin/dashboard/stats
GET /api/admin/dashboard/trends
```

---

## 数据录入清单

### 城市数据 (50+ 条)

**国内热门城市** (20个):
- 北京、上海、深圳、广州、杭州
- 成都、重庆、西安、南京、武汉
- 苏州、天津、长沙、郑州、青岛
- 大连、厦门、三亚、丽江、大理

**国外热门城市** (30个):
- 泰国: 清迈、曼谷、普吉、芭提雅
- 日本: 东京、大阪、京都、福冈
- 东南亚: 新加坡、吉隆坡、河内、胡志明市、巴厘岛
- 欧洲: 伦敦、巴黎、柏林、阿姆斯特丹、布拉格
- 美洲: 纽约、旧金山、温哥华、墨西哥城
- 大洋洲: 悉尼、墨尔本、奥克兰
- 其他: 迪拜、首尔、台北、香港

### 知识库文章 (20+ 篇)

**精选报告** (5篇):
- 2026年全球FIRE指数报告
- 中国养老金制度深度解析
- 数字游民全球签证政策对比
- 个人养老金税收优惠指南
- 50城市生活成本对比报告

**FIRE实践** (8篇):
- 如何用4%法则计算FIRE目标
- 月薪1万如何规划财务自由
- 35岁实现FIRE的真实案例
- Coast FIRE vs Lean FIRE选择
- 复利的力量:时间换空间
- FIRE后如何保持收入来源
- 被动收入的5种构建方式
- 从零开始学习指数基金定投

**城市评测** (4篇):
- 清迈:数字游民天堂深度体验
- 大理vs丽江:退休养老哪个更好
- 东南亚5城生活成本对比
- 欧洲3城数字游民友好度评测

**法律合规** (3篇):
- 个人养老金账户开户指南
- 跨境资产配置合规要点
- 数字游民税务筹划实操

---

## 使用手册

### 管理员登录
1. 访问管理后台地址
2. 输入管理员账号密码
3. 登录成功后进入数据看板

### 城市数据管理
1. 左侧菜单点击"城市管理"
2. 点击"新增城市"按钮
3. 填写城市信息和评分
4. 保存后在列表查看
5. 可编辑/删除现有城市

### 知识库内容管理
1. 左侧菜单点击"知识库管理"
2. 点击"新增文章"
3. 填写标题、选择分类
4. 使用 Markdown 编辑器编写内容
5. 实时预览效果
6. 保存发布

### 用户管理
1. 左侧菜单点击"用户管理"
2. 查看用户列表
3. 可创建测试用户
4. 点击用户查看详情
5. 可修改会员等级

### 内容管理
1. 左侧菜单点击"内容管理"
2. 查看所有帖子
3. 可创建测试帖子
4. 可删除/置顶帖子
5. 查看评论列表

---

**创建时间**: 2026-03-15  
**负责人**: 待分配  
**相关文档**: 
- [管理后台设计文档](../ADMIN_管理后台设计文档.md)
- [技术设计文档](../TECH_技术设计文档.md)
- [迭代规划总览](../SPRINT_迭代规划总览.md)
