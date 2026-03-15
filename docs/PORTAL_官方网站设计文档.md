# 养Young 官方网站设计文档 v1.0

> 💰 **重要**: 关于付费功能使用规则，请查看 [付费操作确认规则.md](./付费操作确认规则.md)

---

## 1. 项目定位

打造媲美 Apple 官网级别的品牌展示网站，通过精美的动画效果和流畅的交互体验，展示产品核心价值，吸引潜在用户下载 App。

**核心目标**:
- 🎨 **视觉冲击**: Apple 级别的设计质感和动画效果
- 🚀 **性能极致**: 流畅的滚动动画，60fps 体验
- 📱 **完美适配**: 响应式设计，完美支持移动端
- 🔍 **SEO 优化**: Next.js SSR/SSG，搜索引擎友好
- 📈 **转化导向**: 引导用户下载 App

---

## 2. 技术栈

### 核心框架
```javascript
{
  "框架": "React 18+",
  "SSR框架": "Next.js 14+ (App Router)",
  "语言": "TypeScript",
  "样式": "Tailwind CSS 3.4+",
  "动画引擎": "GSAP 3.12+ (核心)",
  "滚动动画": "ScrollTrigger (GSAP插件)",
  "3D效果": "Three.js (可选)",
  "图标": "Lucide React",
  "字体": "Inter + SF Pro Display"
}
```

### GSAP 插件生态
```javascript
{
  "核心库": "gsap",
  "滚动触发": "ScrollTrigger",
  "路径动画": "MotionPathPlugin",
  "文字动画": "SplitText",
  "拖拽交互": "Draggable",
  "滚动平滑": "ScrollSmoother",
  "3D视差": "ScrollTrigger + transforms"
}
```

### 开发工具
```javascript
{
  "包管理器": "pnpm",
  "代码规范": "ESLint + Prettier",
  "Git Hooks": "husky",
  "图片优化": "next/image",
  "SEO": "next/head + metadata",
  "分析": "Google Analytics 4"
}
```

### 部署方案
- **平台**: Vercel (免费) ✅
- **CDN**: 自动全球加速
- **域名**: portal.young.com
- **HTTPS**: 自动配置

---

## 3. 页面结构

### 3.1 首页 (Hero + 核心功能)

**URL**: `/`

**布局结构**:
```
Section 1: Hero 区域 (全屏)
  - 主标语 + 动画文字
  - 产品视觉 (App 截图/视频)
  - CTA 按钮 (下载 App)
  - 滚动提示动画

Section 2: 核心价值主张 (3屏)
  - FIRE 规划可视化
  - 社区连接
  - 城市发现

Section 3: 产品功能展示 (多屏滚动)
  - 退休模拟器演示
  - 资产管理界面
  - AI 顾问对话
  - 城市对比工具

Section 4: 数据可信度
  - 用户数量动画
  - 城市覆盖动画
  - 知识库文章数

Section 5: 会员定价
  - 3个套餐卡片
  - 悬停动画效果

Section 6: 下载 CTA
  - App Store / TestFlight
  - 二维码展示

Footer: 页脚
  - 导航链接
  - 社交媒体
  - 法律信息
```

### 3.2 产品功能页

**URL**: `/features`

**功能模块展示**:
- FIRE 规划引擎
- 社区广场
- 城市发现
- AI 顾问
- 资产管理
- 知识库

**动画亮点**:
- 功能卡片悬停 3D 倾斜
- 截图序列滚动动画
- 文字渐入动画

### 3.3 城市数据页

**URL**: `/cities`

**内容**:
- 城市列表(公开版，展示20个热门城市)
- 城市评分雷达图(动画绘制)
- 城市对比工具
- 引导下载 App 查看完整数据

**动画亮点**:
- 地图标记动画
- 雷达图动画绘制
- 数据滚动计数

### 3.4 知识中心

**URL**: `/knowledge`

**内容**:
- 精选文章列表
- 分类导航
- 文章详情页 (Markdown 渲染)
- 相关推荐

**动画亮点**:
- 卡片错落入场
- 阅读进度条
- 图片视差效果

### 3.5 定价页

**URL**: `/pricing`

**内容**:
- 3个会员套餐对比
- 功能权益列表
- FAQ 常见问题
- 下载引导

**动画亮点**:
- 卡片悬停放大
- 价格滚动计数
- 功能列表渐入

### 3.6 关于我们

**URL**: `/about`

**内容**:
- 团队介绍
- 产品愿景
- 发展历程
- 媒体报道
- 联系方式

**动画亮点**:
- 时间轴动画
- 团队头像视差
- 文字打字机效果

---

## 4. GSAP 动画设计

### 4.1 首页 Hero 动画

**效果**: Apple 式大标题入场 + 视频背景

```typescript
// Hero 区域动画
import { gsap } from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'

gsap.registerPlugin(ScrollTrigger)

export const heroAnimation = () => {
  const tl = gsap.timeline()
  
  // 主标题动画
  tl.from('.hero-title', {
    y: 100,
    opacity: 0,
    duration: 1.2,
    ease: 'power4.out'
  })
  
  // 副标题动画
  .from('.hero-subtitle', {
    y: 50,
    opacity: 0,
    duration: 1,
    ease: 'power3.out'
  }, '-=0.6')
  
  // CTA 按钮动画
  .from('.hero-cta', {
    scale: 0.8,
    opacity: 0,
    duration: 0.8,
    ease: 'back.out(1.7)'
  }, '-=0.5')
  
  // App 截图入场
  .from('.hero-image', {
    y: 150,
    opacity: 0,
    duration: 1.5,
    ease: 'power4.out'
  }, '-=0.8')
  
  return tl
}

// 滚动视差效果
export const heroParallax = () => {
  gsap.to('.hero-image', {
    y: 200,
    ease: 'none',
    scrollTrigger: {
      trigger: '.hero-section',
      start: 'top top',
      end: 'bottom top',
      scrub: 1
    }
  })
}
```

### 4.2 功能展示滚动动画 (Pin + Reveal)

**效果**: Apple 式固定容器，内容依次展示

```typescript
// 固定容器 + 内容切换动画
export const featureShowcaseAnimation = () => {
  const sections = gsap.utils.toArray('.feature-section')
  
  sections.forEach((section: any, index) => {
    // 固定容器
    ScrollTrigger.create({
      trigger: section,
      start: 'top top',
      end: '+=100%',
      pin: true,
      pinSpacing: true
    })
    
    // 内容淡入淡出
    gsap.timeline({
      scrollTrigger: {
        trigger: section,
        start: 'top center',
        end: 'bottom center',
        scrub: 1
      }
    })
    .from(section.querySelector('.feature-content'), {
      opacity: 0,
      scale: 0.9,
      duration: 1
    })
    .to(section.querySelector('.feature-content'), {
      opacity: 0,
      scale: 1.1,
      duration: 1
    })
  })
}
```

### 4.3 水平滚动画廊 (Horizontal Scroll)

**效果**: Apple 式横向滚动展示

```typescript
// 水平滚动动画
export const horizontalScrollAnimation = () => {
  const container = document.querySelector('.horizontal-scroll-container')
  const sections = gsap.utils.toArray('.horizontal-section')
  
  gsap.to(sections, {
    xPercent: -100 * (sections.length - 1),
    ease: 'none',
    scrollTrigger: {
      trigger: container,
      pin: true,
      scrub: 1,
      snap: 1 / (sections.length - 1),
      end: () => `+=${container.offsetWidth}`
    }
  })
}
```

### 4.4 文字分裂动画 (SplitText)

**效果**: 文字逐字/逐行入场

```typescript
import { SplitText } from 'gsap/SplitText'

gsap.registerPlugin(SplitText)

export const textRevealAnimation = (selector: string) => {
  const split = new SplitText(selector, { type: 'words,chars' })
  
  gsap.from(split.chars, {
    opacity: 0,
    y: 50,
    rotateX: -90,
    stagger: 0.02,
    duration: 1,
    ease: 'back.out(1.7)',
    scrollTrigger: {
      trigger: selector,
      start: 'top 80%',
      toggleActions: 'play none none reverse'
    }
  })
}
```

### 4.5 3D 卡片倾斜效果

**效果**: 鼠标悬停卡片 3D 倾斜

```typescript
export const card3DTilt = () => {
  const cards = document.querySelectorAll('.card-3d')
  
  cards.forEach(card => {
    card.addEventListener('mousemove', (e: any) => {
      const rect = card.getBoundingClientRect()
      const x = e.clientX - rect.left
      const y = e.clientY - rect.top
      
      const centerX = rect.width / 2
      const centerY = rect.height / 2
      
      const rotateX = (y - centerY) / 10
      const rotateY = (centerX - x) / 10
      
      gsap.to(card, {
        rotateX,
        rotateY,
        transformPerspective: 1000,
        duration: 0.5,
        ease: 'power2.out'
      })
    })
    
    card.addEventListener('mouseleave', () => {
      gsap.to(card, {
        rotateX: 0,
        rotateY: 0,
        duration: 0.5,
        ease: 'power2.out'
      })
    })
  })
}
```

### 4.6 数字滚动计数动画

**效果**: 数字从 0 滚动到目标值

```typescript
export const counterAnimation = (element: HTMLElement, endValue: number) => {
  const obj = { value: 0 }
  
  gsap.to(obj, {
    value: endValue,
    duration: 2,
    ease: 'power2.out',
    onUpdate: () => {
      element.textContent = Math.floor(obj.value).toLocaleString()
    },
    scrollTrigger: {
      trigger: element,
      start: 'top 80%',
      toggleActions: 'play none none reset'
    }
  })
}
```

### 4.7 磁性按钮效果

**效果**: 按钮跟随鼠标磁力吸附

```typescript
export const magneticButton = () => {
  const buttons = document.querySelectorAll('.magnetic-btn')
  
  buttons.forEach(button => {
    button.addEventListener('mousemove', (e: any) => {
      const rect = button.getBoundingClientRect()
      const x = e.clientX - rect.left - rect.width / 2
      const y = e.clientY - rect.top - rect.height / 2
      
      gsap.to(button, {
        x: x * 0.3,
        y: y * 0.3,
        duration: 0.3,
        ease: 'power2.out'
      })
    })
    
    button.addEventListener('mouseleave', () => {
      gsap.to(button, {
        x: 0,
        y: 0,
        duration: 0.5,
        ease: 'elastic.out(1, 0.3)'
      })
    })
  })
}
```

### 4.8 图片序列动画 (Image Sequence)

**效果**: Apple 式滚动播放图片序列

```typescript
export const imageSequenceAnimation = () => {
  const canvas = document.querySelector('#sequence-canvas') as HTMLCanvasElement
  const context = canvas.getContext('2d')
  
  const frameCount = 150
  const images: HTMLImageElement[] = []
  const imageSeq = { frame: 0 }
  
  // 预加载图片
  for (let i = 0; i < frameCount; i++) {
    const img = new Image()
    img.src = `/sequence/frame-${i.toString().padStart(4, '0')}.jpg`
    images.push(img)
  }
  
  // 渲染当前帧
  const render = () => {
    context?.clearRect(0, 0, canvas.width, canvas.height)
    context?.drawImage(images[imageSeq.frame], 0, 0, canvas.width, canvas.height)
  }
  
  // 滚动驱动动画
  gsap.to(imageSeq, {
    frame: frameCount - 1,
    snap: 'frame',
    ease: 'none',
    scrollTrigger: {
      trigger: '.sequence-container',
      start: 'top top',
      end: '+=300%',
      pin: true,
      scrub: 0.5
    },
    onUpdate: render
  })
  
  images[0].onload = render
}
```

### 4.9 平滑滚动 (Smooth Scroll)

**效果**: Lenis 式平滑滚动

```typescript
import { ScrollSmoother } from 'gsap/ScrollSmoother'

gsap.registerPlugin(ScrollSmoother)

export const initSmoothScroll = () => {
  ScrollSmoother.create({
    smooth: 1.5,
    effects: true,
    smoothTouch: 0.1
  })
}
```

### 4.10 页面转场动画

**效果**: 页面切换过渡动画

```typescript
export const pageTransition = {
  initial: {
    opacity: 0,
    y: 50
  },
  animate: {
    opacity: 1,
    y: 0,
    transition: {
      duration: 0.8,
      ease: [0.6, 0.01, 0.05, 0.95]
    }
  },
  exit: {
    opacity: 0,
    y: -50,
    transition: {
      duration: 0.5
    }
  }
}
```

---

## 5. 页面设计详细方案

### 5.1 首页 (Home Page)

#### Hero Section
```tsx
// components/sections/Hero.tsx
'use client'

import { useEffect, useRef } from 'react'
import { gsap } from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'

gsap.registerPlugin(ScrollTrigger)

export default function Hero() {
  const heroRef = useRef<HTMLDivElement>(null)
  const titleRef = useRef<HTMLHeadingElement>(null)
  const imageRef = useRef<HTMLDivElement>(null)
  
  useEffect(() => {
    const ctx = gsap.context(() => {
      // 入场动画
      const tl = gsap.timeline()
      
      tl.from(titleRef.current, {
        y: 100,
        opacity: 0,
        duration: 1.2,
        ease: 'power4.out'
      })
      .from('.hero-subtitle', {
        y: 50,
        opacity: 0,
        duration: 1,
        ease: 'power3.out'
      }, '-=0.6')
      .from('.hero-cta', {
        scale: 0.8,
        opacity: 0,
        duration: 0.8,
        ease: 'back.out(1.7)'
      }, '-=0.5')
      
      // 视差效果
      gsap.to(imageRef.current, {
        y: 200,
        ease: 'none',
        scrollTrigger: {
          trigger: heroRef.current,
          start: 'top top',
          end: 'bottom top',
          scrub: 1
        }
      })
    }, heroRef)
    
    return () => ctx.revert()
  }, [])
  
  return (
    <section 
      ref={heroRef}
      className="relative h-screen flex items-center justify-center overflow-hidden bg-gradient-to-b from-black to-gray-900"
    >
      {/* 背景视频/图片 */}
      <div 
        ref={imageRef}
        className="absolute inset-0 z-0"
      >
        <video 
          autoPlay 
          muted 
          loop 
          playsInline
          className="w-full h-full object-cover opacity-30"
        >
          <source src="/hero-bg.mp4" type="video/mp4" />
        </video>
      </div>
      
      {/* 内容 */}
      <div className="relative z-10 text-center px-4">
        <h1 
          ref={titleRef}
          className="text-7xl md:text-9xl font-bold text-white mb-6"
          style={{
            fontFamily: 'SF Pro Display, -apple-system, sans-serif'
          }}
        >
          为年轻规划<br />
          为自由而生
        </h1>
        
        <p className="hero-subtitle text-2xl md:text-3xl text-gray-300 mb-12 max-w-3xl mx-auto">
          科学计算 FIRE 目标，连接同路人，探索理想生活城市
        </p>
        
        <div className="hero-cta flex gap-6 justify-center">
          <button className="magnetic-btn px-12 py-5 bg-[#FFD93D] text-black text-xl font-semibold rounded-full hover:bg-yellow-400 transition-colors">
            下载 App
          </button>
          <button className="magnetic-btn px-12 py-5 border-2 border-white text-white text-xl font-semibold rounded-full hover:bg-white hover:text-black transition-all">
            了解更多
          </button>
        </div>
      </div>
      
      {/* 滚动提示 */}
      <div className="absolute bottom-12 left-1/2 -translate-x-1/2 animate-bounce">
        <div className="w-6 h-10 border-2 border-white rounded-full flex justify-center">
          <div className="w-1 h-3 bg-white rounded-full mt-2 animate-pulse" />
        </div>
      </div>
    </section>
  )
}
```

#### Feature Showcase (固定容器动画)
```tsx
// components/sections/FeatureShowcase.tsx
'use client'

import { useEffect, useRef } from 'react'
import { gsap } from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'

const features = [
  {
    title: 'FIRE 规划引擎',
    subtitle: '科学计算你的财务自由之路',
    image: '/features/fire-engine.png',
    description: '基于4%原则，精确计算退休目标，可视化展示资产增长曲线'
  },
  {
    title: '城市发现',
    subtitle: '找到最适合养老的城市',
    image: '/features/city-discover.png',
    description: '50+城市评分对比，生活成本、医疗、空气质量一目了然'
  },
  {
    title: 'AI 理财顾问',
    subtitle: '7x24 专业建议',
    image: '/features/ai-advisor.png',
    description: '基于你的资产状况，提供个性化理财规划方案'
  }
]

export default function FeatureShowcase() {
  const containerRef = useRef<HTMLDivElement>(null)
  
  useEffect(() => {
    const sections = gsap.utils.toArray('.feature-panel')
    
    sections.forEach((section: any, i) => {
      ScrollTrigger.create({
        trigger: section,
        start: 'top top',
        end: '+=100%',
        pin: true,
        pinSpacing: true,
        anticipatePin: 1
      })
      
      gsap.timeline({
        scrollTrigger: {
          trigger: section,
          start: 'top center',
          end: 'bottom center',
          scrub: 1
        }
      })
      .from(section.querySelector('.feature-content'), {
        opacity: 0,
        scale: 0.9,
        y: 100
      })
      .to(section.querySelector('.feature-content'), {
        opacity: i === sections.length - 1 ? 1 : 0,
        scale: i === sections.length - 1 ? 1 : 1.1,
        y: i === sections.length - 1 ? 0 : -100
      })
    })
  }, [])
  
  return (
    <div ref={containerRef} className="bg-black">
      {features.map((feature, index) => (
        <section 
          key={index}
          className="feature-panel h-screen flex items-center justify-center relative"
        >
          <div className="feature-content max-w-7xl mx-auto px-4 grid md:grid-cols-2 gap-12 items-center">
            <div className="text-white">
              <h2 className="text-6xl font-bold mb-4">{feature.title}</h2>
              <p className="text-3xl text-gray-400 mb-6">{feature.subtitle}</p>
              <p className="text-xl text-gray-500">{feature.description}</p>
            </div>
            <div className="relative">
              <img 
                src={feature.image} 
                alt={feature.title}
                className="w-full h-auto rounded-3xl shadow-2xl"
              />
            </div>
          </div>
        </section>
      ))}
    </div>
  )
}
```

#### Horizontal Scroll Gallery
```tsx
// components/sections/HorizontalGallery.tsx
'use client'

import { useEffect, useRef } from 'react'
import { gsap } from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'

const screenshots = [
  '/screenshots/home.png',
  '/screenshots/fire.png',
  '/screenshots/community.png',
  '/screenshots/city.png',
  '/screenshots/asset.png'
]

export default function HorizontalGallery() {
  const containerRef = useRef<HTMLDivElement>(null)
  const scrollRef = useRef<HTMLDivElement>(null)
  
  useEffect(() => {
    const sections = gsap.utils.toArray('.gallery-item')
    
    gsap.to(sections, {
      xPercent: -100 * (sections.length - 1),
      ease: 'none',
      scrollTrigger: {
        trigger: containerRef.current,
        pin: true,
        scrub: 1,
        snap: 1 / (sections.length - 1),
        end: () => `+=${scrollRef.current!.offsetWidth}`
      }
    })
  }, [])
  
  return (
    <section 
      ref={containerRef}
      className="h-screen bg-white overflow-hidden"
    >
      <div className="h-full flex items-center">
        <div 
          ref={scrollRef}
          className="flex gap-12 px-12"
        >
          {screenshots.map((src, index) => (
            <div 
              key={index}
              className="gallery-item flex-shrink-0 w-[400px] h-[800px]"
            >
              <img 
                src={src}
                alt={`Screenshot ${index + 1}`}
                className="w-full h-full object-cover rounded-3xl shadow-2xl"
              />
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}
```

---

## 6. 项目结构

```
young-portal/
├── app/                          # Next.js App Router
│   ├── layout.tsx               # 根布局
│   ├── page.tsx                 # 首页
│   ├── features/
│   │   └── page.tsx            # 功能页
│   ├── cities/
│   │   ├── page.tsx            # 城市列表
│   │   └── [slug]/page.tsx     # 城市详情
│   ├── knowledge/
│   │   ├── page.tsx            # 知识中心
│   │   └── [slug]/page.tsx     # 文章详情
│   ├── pricing/
│   │   └── page.tsx            # 定价页
│   ├── about/
│   │   └── page.tsx            # 关于我们
│   └── api/                     # API路由
│       └── cities/route.ts
├── components/
│   ├── sections/                # 页面区块
│   │   ├── Hero.tsx
│   │   ├── FeatureShowcase.tsx
│   │   ├── HorizontalGallery.tsx
│   │   ├── Stats.tsx
│   │   ├── Pricing.tsx
│   │   └── DownloadCTA.tsx
│   ├── ui/                      # UI组件
│   │   ├── Button.tsx
│   │   ├── Card.tsx
│   │   ├── Navbar.tsx
│   │   └── Footer.tsx
│   └── animations/              # 动画组件
│       ├── TextReveal.tsx
│       ├── FadeIn.tsx
│       └── ParallaxImage.tsx
├── lib/
│   ├── gsap/                    # GSAP工具
│   │   ├── animations.ts       # 动画函数
│   │   ├── scrollTrigger.ts    # ScrollTrigger配置
│   │   └── utils.ts            # 工具函数
│   ├── api.ts                   # API调用
│   └── utils.ts                 # 通用工具
├── styles/
│   └── globals.css              # 全局样式
├── public/
│   ├── hero-bg.mp4
│   ├── features/
│   ├── screenshots/
│   └── sequence/                # 图片序列
├── hooks/
│   ├── useGsap.ts
│   └── useScrollTrigger.ts
├── types/
│   └── index.ts
├── package.json
├── tsconfig.json
├── tailwind.config.js
└── next.config.js
```

---

## 7. 关键配置文件

### 7.1 package.json
```json
{
  "name": "young-portal",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint"
  },
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "next": "^14.1.0",
    "gsap": "^3.12.5",
    "three": "^0.161.0",
    "@react-three/fiber": "^8.15.0",
    "lucide-react": "^0.323.0",
    "clsx": "^2.1.0",
    "tailwind-merge": "^2.2.1"
  },
  "devDependencies": {
    "@types/node": "^20",
    "@types/react": "^18",
    "@types/react-dom": "^18",
    "typescript": "^5",
    "tailwindcss": "^3.4.0",
    "postcss": "^8",
    "autoprefixer": "^10",
    "eslint": "^8",
    "eslint-config-next": "14.1.0",
    "prettier": "^3.2.0",
    "@gsap/react": "^2.1.0"
  }
}
```

### 7.2 tailwind.config.js
```javascript
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './pages/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
    './app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        primary: '#FFD93D',
        success: '#00D9A3',
        danger: '#FF4D4D',
        dark: {
          900: '#0A0E27',
          800: '#1A1F3A'
        }
      },
      fontFamily: {
        sans: ['Inter', 'SF Pro Display', '-apple-system', 'sans-serif'],
        display: ['SF Pro Display', '-apple-system', 'sans-serif']
      },
      animation: {
        'bounce-slow': 'bounce 3s infinite'
      }
    },
  },
  plugins: [],
}
```

### 7.3 next.config.js
```javascript
/** @type {import('next').NextConfig} */
const nextConfig = {
  images: {
    remotePatterns: [
      {
        protocol: 'https',
        hostname: '**',
      },
    ],
  },
  // Vercel 部署优化
  output: 'standalone',
  // GSAP 优化
  webpack: (config) => {
    config.module.rules.push({
      test: /\.svg$/,
      use: ['@svgr/webpack']
    })
    return config
  }
}

module.exports = nextConfig
```

### 7.4 globals.css
```css
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap');

@tailwind base;
@tailwind components;
@tailwind utilities;

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

html {
  scroll-behavior: smooth;
}

body {
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  overflow-x: hidden;
}

/* 禁用移动端点击高亮 */
* {
  -webkit-tap-highlight-color: transparent;
}

/* 自定义滚动条 */
::-webkit-scrollbar {
  width: 8px;
}

::-webkit-scrollbar-track {
  background: #0A0E27;
}

::-webkit-scrollbar-thumb {
  background: #FFD93D;
  border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
  background: #E5C235;
}

/* Apple 风格渐变 */
.gradient-text {
  background: linear-gradient(135deg, #FFD93D 0%, #FF9F43 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

/* 玻璃态效果 */
.glass {
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
}
```

---

## 8. 动画性能优化

### 8.1 优化策略

```typescript
// lib/gsap/optimize.ts

// 1. 使用 will-change 提示浏览器
export const optimizeElement = (element: HTMLElement) => {
  element.style.willChange = 'transform, opacity'
}

// 2. 批量动画使用 timeline
export const batchAnimations = (elements: Element[]) => {
  const tl = gsap.timeline()
  elements.forEach((el, i) => {
    tl.from(el, {
      opacity: 0,
      y: 50,
      duration: 0.6,
      ease: 'power3.out'
    }, i * 0.1)
  })
  return tl
}

// 3. 防抖 resize 事件
export const debounce = (fn: Function, ms: number) => {
  let timer: NodeJS.Timeout
  return function(this: any, ...args: any[]) {
    clearTimeout(timer)
    timer = setTimeout(() => fn.apply(this, args), ms)
  }
}

// 4. Intersection Observer 延迟加载动画
export const lazyLoadAnimation = (elements: Element[]) => {
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        gsap.from(entry.target, {
          opacity: 0,
          y: 50,
          duration: 1,
          ease: 'power3.out'
        })
        observer.unobserve(entry.target)
      }
    })
  }, { threshold: 0.1 })
  
  elements.forEach(el => observer.observe(el))
}

// 5. RAF 优化
export const rafThrottle = (fn: Function) => {
  let rafId: number | null = null
  return function(this: any, ...args: any[]) {
    if (rafId) return
    rafId = requestAnimationFrame(() => {
      fn.apply(this, args)
      rafId = null
    })
  }
}
```

### 8.2 移动端优化

```typescript
// lib/gsap/mobile.ts

export const mobileOptimizations = () => {
  const isMobile = /iPhone|iPad|iPod|Android/i.test(navigator.userAgent)
  
  if (isMobile) {
    // 禁用某些复杂动画
    return {
      reduceMotion: true,
      disableParallax: true,
      simpleTransitions: true
    }
  }
  
  return {
    reduceMotion: false,
    disableParallax: false,
    simpleTransitions: false
  }
}

// 检测用户偏好
export const prefersReducedMotion = () => {
  return window.matchMedia('(prefers-reduced-motion: reduce)').matches
}
```

---

## 9. SEO 优化

### 9.1 Metadata 配置

```typescript
// app/layout.tsx
import type { Metadata } from 'next'

export const metadata: Metadata = {
  title: '养Young - 为年轻规划，为自由而生',
  description: '科学计算FIRE目标，连接同路人，探索理想生活城市。养老规划、社区社交、城市发现、AI理财顾问一站式平台。',
  keywords: ['FIRE', '财务自由', '养老规划', '数字游民', '城市发现', '理财顾问'],
  authors: [{ name: '养Young团队' }],
  openGraph: {
    title: '养Young - 为年轻规划，为自由而生',
    description: '科学计算FIRE目标，连接同路人，探索理想生活城市',
    url: 'https://young.com',
    siteName: '养Young',
    images: [
      {
        url: 'https://young.com/og-image.jpg',
        width: 1200,
        height: 630,
        alt: '养Young App'
      }
    ],
    locale: 'zh_CN',
    type: 'website',
  },
  twitter: {
    card: 'summary_large_image',
    title: '养Young - 为年轻规划，为自由而生',
    description: '科学计算FIRE目标，连接同路人',
    images: ['https://young.com/twitter-image.jpg'],
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      'max-video-preview': -1,
      'max-image-preview': 'large',
      'max-snippet': -1,
    },
  },
  verification: {
    google: 'your-google-verification-code',
  }
}
```

### 9.2 结构化数据

```typescript
// components/StructuredData.tsx
export default function StructuredData() {
  const schema = {
    '@context': 'https://schema.org',
    '@type': 'SoftwareApplication',
    name: '养Young',
    applicationCategory: 'FinanceApplication',
    operatingSystem: 'iOS',
    offers: {
      '@type': 'Offer',
      price: '0',
      priceCurrency: 'CNY'
    },
    aggregateRating: {
      '@type': 'AggregateRating',
      ratingValue: '4.8',
      ratingCount: '1000'
    }
  }
  
  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(schema) }}
    />
  )
}
```

---

## 10. 部署与性能

### 10.1 Vercel 部署配置

```json
// vercel.json
{
  "framework": "nextjs",
  "buildCommand": "pnpm build",
  "devCommand": "pnpm dev",
  "installCommand": "pnpm install",
  "regions": ["hkg1"],
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        {
          "key": "X-Content-Type-Options",
          "value": "nosniff"
        },
        {
          "key": "X-Frame-Options",
          "value": "DENY"
        },
        {
          "key": "X-XSS-Protection",
          "value": "1; mode=block"
        }
      ]
    }
  ]
}
```

### 10.2 性能指标目标

```
核心 Web Vitals:
- LCP (Largest Contentful Paint): < 2.5s
- FID (First Input Delay): < 100ms
- CLS (Cumulative Layout Shift): < 0.1

其他指标:
- FCP (First Contentful Paint): < 1.5s
- TTI (Time to Interactive): < 3.5s
- Speed Index: < 3.0s
- Total Blocking Time: < 200ms

Lighthouse Score:
- Performance: > 95
- Accessibility: 100
- Best Practices: 100
- SEO: 100
```

### 10.3 图片优化

```typescript
// components/OptimizedImage.tsx
import Image from 'next/image'

interface Props {
  src: string
  alt: string
  width?: number
  height?: number
  priority?: boolean
}

export default function OptimizedImage({ 
  src, 
  alt, 
  width = 1200, 
  height = 630,
  priority = false 
}: Props) {
  return (
    <Image
      src={src}
      alt={alt}
      width={width}
      height={height}
      priority={priority}
      quality={90}
      placeholder="blur"
      blurDataURL="data:image/jpeg;base64,/9j/4AAQSkZJRg..."
      loading={priority ? 'eager' : 'lazy'}
      sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 33vw"
    />
  )
}
```

---

## 11. 开发计划

### Phase 1: 基础框架 (2天)

**Day 1**:
- [x] Next.js 14 项目初始化
- [x] Tailwind CSS 配置
- [x] GSAP 集成
- [x] 项目结构搭建
- [x] 基础组件开发(Button/Card/Navbar)

**Day 2**:
- [x] 布局组件(Layout/Header/Footer)
- [x] 路由配置
- [x] 全局样式
- [x] 字体配置

### Phase 2: 首页开发 (4天)

**Day 3**:
- [x] Hero Section
  - 主标题动画
  - CTA 按钮
  - 背景视频
  - 视差效果

**Day 4**:
- [x] Feature Showcase
  - 固定容器动画
  - 内容切换效果
  - 3个核心功能展示

**Day 5**:
- [x] Horizontal Gallery
  - 横向滚动动画
  - App 截图展示
  - Snap 效果

**Day 6**:
- [x] Stats Section
  - 数字滚动动画
  - 数据可视化
- [x] Pricing Section
  - 卡片 3D 倾斜
  - 悬停效果

### Phase 3: 其他页面 (3天)

**Day 7**:
- [x] 功能页 (/features)
- [x] 城市数据页 (/cities)

**Day 8**:
- [x] 知识中心 (/knowledge)
- [x] 定价页 (/pricing)

**Day 9**:
- [x] 关于我们 (/about)
- [x] 页面转场动画

### Phase 4: 优化与测试 (2天)

**Day 10**:
- [x] 性能优化
- [x] 移动端适配
- [x] SEO 优化
- [x] 图片优化

**Day 11**:
- [x] 浏览器兼容性测试
- [x] 响应式测试
- [x] 动画流畅度测试
- [x] Lighthouse 测试
- [x] 部署到 Vercel

**总时长**: 11天

---

## 12. 质量检查清单

### 12.1 动画质量

- [ ] 所有动画 60fps 流畅运行
- [ ] 滚动动画无卡顿
- [ ] 页面转场自然
- [ ] 移动端动画正常
- [ ] 无过度动画导致眩晕
- [ ] 支持 prefers-reduced-motion

### 12.2 性能指标

- [ ] Lighthouse Performance > 95
- [ ] LCP < 2.5s
- [ ] FID < 100ms
- [ ] CLS < 0.1
- [ ] 首屏加载 < 2s
- [ ] 图片懒加载正常

### 12.3 响应式设计

- [ ] 适配 iPhone (375px-430px)
- [ ] 适配 iPad (768px-1024px)
- [ ] 适配桌面 (1280px+)
- [ ] 适配 4K 显示器 (2560px+)
- [ ] 触摸交互正常
- [ ] 横屏显示正常

### 12.4 SEO

- [ ] Meta 标签完整
- [ ] OpenGraph 配置
- [ ] 结构化数据
- [ ] Sitemap 生成
- [ ] Robots.txt 配置
- [ ] 语义化 HTML

### 12.5 可访问性

- [ ] ARIA 标签正确
- [ ] 键盘导航支持
- [ ] 色彩对比度达标
- [ ] 屏幕阅读器友好
- [ ] 焦点可见

---

## 13. 维护与迭代

### 13.1 持续优化

- 根据用户反馈优化动画效果
- 监控性能指标，持续优化
- 更新内容(城市数据、文章)
- A/B 测试下载转化率

### 13.2 功能扩展

- 添加博客系统
- 集成用户评价
- 添加视频介绍
- 集成在线客服
- 添加多语言支持

---

**文档版本**: v1.0  
**创建时间**: 2026-03-15  
**最后更新**: 2026-03-15  
**维护人**: 晨曦

**相关文档**:
- [产品需求文档](./PRD_产品需求文档.md)
- [技术设计文档](./TECH_技术设计文档.md)
- [迭代规划总览](./SPRINT_迭代规划总览.md)
