# Sprint 14: 官方网站开发

**时长**: 11天  
**状态**: 📋 待开始  
**优先级**: P2

---

## 目标

在 App 和所有功能完成后，开发 Apple 级别的品牌官网，使用 React + Next.js 14 + GSAP 打造流畅的动画体验。

**开发时机**: 在 Sprint 13 (测试与发布) 完成后开始开发

---

## 核心价值

1. ✅ **品牌形象**: Apple 级别的设计质感和动画效果
2. ✅ **用户获取**: SEO 优化，吸引潜在用户下载 App
3. ✅ **内容展示**: 展示产品功能、城市数据、知识库内容
4. ✅ **转化引导**: 引导用户下载 App，提高转化率

---

## 任务清单

### Day 1-2: 基础框架搭建

- [ ] Next.js 14 项目初始化
- [ ] TypeScript 配置
- [ ] Tailwind CSS 配置
- [ ] GSAP 集成和配置
- [ ] 项目目录结构搭建
- [ ] 环境变量配置
- [ ] 基础组件开发(Button/Card/Navbar/Footer)
- [ ] 布局组件(Layout/Header)
- [ ] 路由配置

### Day 3-4: 首页 Hero 与功能展示

**Hero Section**:
- [ ] 主标题入场动画 (GSAP)
- [ ] 副标题动画
- [ ] CTA 按钮动画
- [ ] 背景视频/图片
- [ ] 视差效果
- [ ] 滚动提示动画

**Feature Showcase**:
- [ ] 固定容器动画 (ScrollTrigger)
- [ ] 3个核心功能展示
- [ ] 内容切换动画
- [ ] App 截图展示

### Day 5: 横向滚动画廊

- [ ] 水平滚动容器
- [ ] 5张 App 截图展示
- [ ] Snap 效果
- [ ] 滚动指示器
- [ ] 触摸支持

### Day 6: 数据统计与定价

**Stats Section**:
- [ ] 数字滚动计数动画
- [ ] 4个核心指标卡片
- [ ] 数据可视化效果

**Pricing Section**:
- [ ] 3个会员套餐卡片
- [ ] 卡片 3D 倾斜效果
- [ ] 悬停放大动画
- [ ] 功能列表渐入

### Day 7: 产品功能页

- [ ] 功能列表页面
- [ ] 7大功能模块展示
- [ ] 功能卡片悬停效果
- [ ] 截图序列展示
- [ ] 文字渐入动画

### Day 8: 城市数据页

- [ ] 城市列表页面(20个热门城市)
- [ ] 城市卡片组件
- [ ] 城市评分雷达图(动画绘制)
- [ ] 城市对比工具
- [ ] 引导下载 App

### Day 9: 知识中心与其他页面

**知识中心**:
- [ ] 文章列表页面
- [ ] 分类导航
- [ ] 文章卡片错落入场
- [ ] 文章详情页(Markdown 渲染)
- [ ] 阅读进度条

**其他页面**:
- [ ] 定价页
- [ ] 关于我们页
- [ ] FAQ 页面

### Day 10: 优化与性能

- [ ] 图片优化(next/image)
- [ ] 代码分割
- [ ] 懒加载实现
- [ ] 移动端适配
- [ ] 响应式测试(375px-2560px)
- [ ] 动画性能优化
- [ ] 页面转场动画
- [ ] SEO 优化(Metadata)
- [ ] 结构化数据
- [ ] Sitemap 生成

### Day 11: 测试与部署

- [ ] 浏览器兼容性测试
- [ ] Lighthouse 测试
  - Performance > 95
  - Accessibility 100
  - Best Practices 100
  - SEO 100
- [ ] 移动端测试
- [ ] 动画流畅度测试(60fps)
- [ ] 链接完整性检查
- [ ] 构建生产版本
- [ ] 部署到 Vercel
- [ ] 域名配置
- [ ] HTTPS 配置
- [ ] Google Analytics 集成

---

## 验收标准

### 功能完整性
- [ ] 6个主要页面全部完成
- [ ] 所有导航链接正常工作
- [ ] 所有动画效果流畅运行
- [ ] 下载按钮正常跳转
- [ ] 表单提交正常

### 动画质量
- [ ] 所有动画 60fps 流畅
- [ ] 滚动动画无卡顿
- [ ] 页面转场自然
- [ ] 移动端动画正常
- [ ] 支持 prefers-reduced-motion

### 性能指标
- [ ] Lighthouse Performance > 95
- [ ] LCP (Largest Contentful Paint) < 2.5s
- [ ] FID (First Input Delay) < 100ms
- [ ] CLS (Cumulative Layout Shift) < 0.1
- [ ] 首屏加载 < 2s
- [ ] TTI (Time to Interactive) < 3.5s

### 响应式设计
- [ ] 适配 iPhone (375px-430px)
- [ ] 适配 iPad (768px-1024px)
- [ ] 适配桌面 (1280px-1920px)
- [ ] 适配 4K (2560px+)
- [ ] 触摸交互正常
- [ ] 横屏显示正常

### SEO 优化
- [ ] Meta 标签完整
- [ ] OpenGraph 配置正确
- [ ] 结构化数据正确
- [ ] Sitemap 已生成
- [ ] Robots.txt 配置
- [ ] 语义化 HTML

### 可访问性
- [ ] ARIA 标签正确
- [ ] 键盘导航支持
- [ ] 色彩对比度达标(WCAG AA)
- [ ] 屏幕阅读器友好
- [ ] 焦点可见

---

## 测试用例

### TC-9.5.1: Hero 动画
**步骤**:
1. 访问首页
2. 观察动画效果

**预期结果**:
- 标题从下方淡入 (1.2s)
- 副标题紧随其后 (1s)
- CTA 按钮弹性入场 (0.8s)
- 所有动画流畅无卡顿

---

### TC-9.5.2: 固定容器动画
**步骤**:
1. 向下滚动到功能展示区域
2. 继续滚动

**预期结果**:
- 容器固定在屏幕顶部
- 内容依次淡入淡出
- 滚动流畅无跳跃

---

### TC-9.5.3: 横向滚动
**步骤**:
1. 滚动到截图画廊区域
2. 继续垂直滚动

**预期结果**:
- 画廊水平滚动
- 每张截图自动吸附
- 滚动指示器正常显示

---

### TC-9.5.4: 数字滚动计数
**步骤**:
1. 滚动到数据统计区域
2. 观察数字变化

**预期结果**:
- 数字从 0 滚动到目标值
- 滚动动画流畅(2s)
- 千分位分隔符正确

---

### TC-9.5.5: 3D 卡片倾斜
**步骤**:
1. 鼠标悬停在定价卡片上
2. 移动鼠标
3. 鼠标离开

**预期结果**:
- 卡片随鼠标 3D 倾斜
- 倾斜流畅无延迟
- 鼠标离开后恢复原位

---

### TC-9.5.6: 移动端适配
**步骤**:
1. 使用 iPhone 访问网站
2. 测试所有页面
3. 测试触摸交互

**预期结果**:
- 布局自适应
- 触摸滚动流畅
- 按钮可点击
- 文字大小合适

---

### TC-9.5.7: Lighthouse 测试
**步骤**:
1. 打开 Chrome DevTools
2. 运行 Lighthouse 测试
3. 查看报告

**预期结果**:
- Performance > 95
- Accessibility 100
- Best Practices 100
- SEO 100

---

### TC-9.5.8: SEO 检查
**步骤**:
1. 查看页面源代码
2. 检查 Meta 标签
3. 检查结构化数据

**预期结果**:
- Title 和 Description 存在
- OpenGraph 标签完整
- 结构化数据格式正确
- 无 404 链接

---

## 技术要点

### GSAP 核心动画

```typescript
// 1. Hero 入场动画
const heroAnimation = gsap.timeline()
  .from('.hero-title', { y: 100, opacity: 0, duration: 1.2 })
  .from('.hero-subtitle', { y: 50, opacity: 0, duration: 1 }, '-=0.6')
  .from('.hero-cta', { scale: 0.8, opacity: 0, duration: 0.8 }, '-=0.5')

// 2. 固定容器动画
ScrollTrigger.create({
  trigger: '.feature-section',
  start: 'top top',
  end: '+=100%',
  pin: true,
  pinSpacing: true
})

// 3. 横向滚动
gsap.to('.gallery-item', {
  xPercent: -100 * (items.length - 1),
  ease: 'none',
  scrollTrigger: {
    trigger: '.gallery-container',
    pin: true,
    scrub: 1,
    snap: 1 / (items.length - 1)
  }
})

// 4. 数字计数
gsap.to(counter, {
  value: 10000,
  duration: 2,
  onUpdate: () => {
    element.textContent = Math.floor(counter.value).toLocaleString()
  }
})
```

### Next.js 优化

```typescript
// 图片优化
import Image from 'next/image'

<Image
  src="/hero.jpg"
  alt="Hero"
  width={1920}
  height={1080}
  priority
  quality={90}
/>

// 路由预加载
import Link from 'next/link'

<Link href="/features" prefetch>
  了解更多
</Link>

// 动态导入
const HeavyComponent = dynamic(() => import('./HeavyComponent'), {
  loading: () => <Spinner />,
  ssr: false
})
```

---

## 依赖关系

**前置依赖**: 
- Sprint 13 (测试与发布完成)
- App Store 已上线或即将上线
- 管理后台数据完整(城市、知识库等)

**后续依赖**: 无 (最后一个 Sprint)

**注意**: 此 Sprint 在所有 App 功能完成后独立开发，不与其他 Sprint 并行

---

## 风险与问题

| 风险 | 影响 | 应对措施 |
|------|------|----------|
| GSAP 学习曲线陡峭 | 中 | 参考官方文档和示例 |
| 动画性能优化复杂 | 中 | 使用 will-change, RAF 优化 |
| 移动端动画卡顿 | 高 | 降低动画复杂度，使用 transform |
| Vercel 部署问题 | 低 | 提前测试部署流程 |
| SEO 优化不足 | 中 | 使用 Next.js 内置 SEO 功能 |

---

## 完成标准

- ✅ 所有验收标准通过
- ✅ 所有测试用例通过
- ✅ Lighthouse 4项得分达标
- ✅ 移动端完美适配
- ✅ 部署到 Vercel 成功
- ✅ 域名配置完成
- ✅ Google Analytics 集成
- ✅ 代码 Review 完成
- ✅ 文档更新完成

---

## 部署清单

- [ ] 环境变量配置
- [ ] Vercel 项目创建
- [ ] 域名绑定(portal.young.com)
- [ ] HTTPS 证书配置
- [ ] Google Analytics 配置
- [ ] Sentry 错误监控
- [ ] 性能监控配置

---

## 项目结构

```
young-portal/
├── app/
│   ├── layout.tsx
│   ├── page.tsx              # 首页
│   ├── features/page.tsx     # 功能页
│   ├── cities/page.tsx       # 城市数据
│   ├── knowledge/page.tsx    # 知识中心
│   ├── pricing/page.tsx      # 定价
│   └── about/page.tsx        # 关于
├── components/
│   ├── sections/             # Hero, Features, etc.
│   ├── ui/                   # Button, Card, etc.
│   └── animations/           # 动画组件
├── lib/
│   ├── gsap/                 # GSAP 工具
│   └── utils.ts
├── public/
│   ├── hero-bg.mp4
│   ├── screenshots/
│   └── features/
├── styles/
│   └── globals.css
└── package.json
```

---

## 启动命令

```bash
# 安装依赖
pnpm install

# 启动开发服务器
pnpm dev

# 构建生产版本
pnpm build

# 启动生产服务器
pnpm start

# Lint 检查
pnpm lint

# Lighthouse CI
pnpm lighthouse
```

---

**创建时间**: 2026-03-15  
**负责人**: 待分配  
**相关文档**: 
- [官方网站设计文档](../PORTAL_官方网站设计文档.md)
- [技术设计文档](../TECH_技术设计文档.md)
- [迭代规划总览](../SPRINT_迭代规划总览.md)

**说明**: 此 Sprint 在 App 完全上线后开始，作为独立项目开发，不影响 App 的开发和发布进度。
