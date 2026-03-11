# FIRE AI 财务顾问应用 - 产品需求文档 (PRD)

## 项目概述

### 产品定位
**FIRE (Financial Independence, Retire Early) AI 顾问应用**

这是一款专注于帮助用户实现**财务独立和提前退休**目标的智能财务顾问应用。通过 AI 对话、个性化规划、数据分析和社区支持,帮助用户:
- 📊 制定个性化的 FIRE 计划
- 💰 优化储蓄和投资策略
- 🎯 追踪财务独立进度
- 🤖 获得 AI 驱动的实时建议
- 👥 与 FIRE 社区互动交流

### FIRE 核心概念
- **4% 规则**: 退休后每年可安全提取投资组合的 4%,维持 30 年以上的退休生活
- **FIRE 数字**: 实现财务独立所需的总资产(年支出 × 25)
- **储蓄率**: 收入中用于储蓄和投资的比例(越高越早实现 FIRE)
- **被动收入**: 无需主动工作即可获得的收入(投资、租金等)

### 技术栈
- **前端**: Swift (SwiftUI)
- **后端**: Node.js (Express/Fastify)
- **数据库**: MongoDB + Redis (缓存)
- **AI/LLM**: LangChain + OpenAI/Claude
- **RAG**: LangChain Vector Store (Pinecone/Chroma)

### 核心功能分析(基于 UI)
从 Figma 设计中识别出以下核心模块:

1. **顶部导航栏 (Header)**
   - FIRE AI Advisor 标题
   - 在线状态指示器
   - 返回按钮
   - 更多操作按钮

2. **智能对话区域 (Chat History)**
   - AI 消息(带头像、时间戳、消息内容)
   - 用户消息(带头像、时间戳、消息内容)
   - FIRE 相关建议(如 4% 规则、储蓄率计算、提前退休规划)
   - 附件显示(FIRE 计划 PDF、投资报告等)
   - 关键词高亮(如 "4% rule", "FIRE number", "savings rate")

3. **输入区域 (Input Area)**
   - 附件按钮
   - 文本输入框(placeholder: "Ask anything about your FIRE journey...")
   - 语音输入按钮
   - 发送按钮

4. **底部导航栏 (Bottom Navigation)**
   - Home(首页 - FIRE 进度仪表盘)
   - Plan(计划 - FIRE 路线图)
   - AI 顾问(中央大按钮,带阴影)
   - Community(社区 - FIRE 同行交流)
   - Me(个人中心)

---

## 分期迭代计划

### 第一期:MVP 核心功能 (4-6 周)

#### 1.1 基础架构搭建 (Week 1)

**后端任务:**
- [ ] 初始化 Node.js 项目(Express/Fastify)
- [ ] 配置 MongoDB 数据库
- [ ] 配置 Redis 缓存
- [ ] 设计数据库 Schema (MongoDB Collections):
  ```javascript
  // users 集合
  {
    _id: ObjectId,
    username: String,
    email: String, // 唯一索引
    password: String, // bcrypt 加密
    avatar_url: String,
    fire_profile: {
      current_age: Number,
      target_fire_age: Number,
      current_savings: Number,
      monthly_income: Number,
      monthly_expenses: Number,
      savings_rate: Number, // 百分比
      fire_number: Number, // 目标资产总额
      risk_tolerance: String, // 'conservative', 'moderate', 'aggressive'
    },
    created_at: Date,
    updated_at: Date
  }

  // conversations 集合
  {
    _id: ObjectId,
    user_id: ObjectId, // 引用 users._id
    title: String,
    topic: String, // 'fire_planning', 'investment', 'savings', 'general'
    created_at: Date,
    updated_at: Date
  }

  // messages 集合
  {
    _id: ObjectId,
    conversation_id: ObjectId, // 引用 conversations._id
    role: String, // 'user' or 'assistant'
    content: String,
    attachments: [{
      type: String, // 'pdf', 'image', 'csv'
      url: String,
      filename: String,
      size: Number
    }],
    metadata: {
      highlighted_keywords: [String], // 如 ["4% rule", "FIRE number"]
      generated_report: Boolean,
      report_url: String
    },
    created_at: Date
  }

  // fire_plans 集合 (用户的 FIRE 计划)
  {
    _id: ObjectId,
    user_id: ObjectId,
    plan_name: String,
    target_fire_date: Date,
    required_portfolio: Number, // FIRE 数字
    current_portfolio: Number,
    progress_percentage: Number,
    monthly_savings_goal: Number,
    projected_fire_date: Date, // 基于当前进度的预测
    milestones: [{
      name: String,
      target_amount: Number,
      target_date: Date,
      achieved: Boolean,
      achieved_date: Date
    }],
    created_at: Date,
    updated_at: Date
  }

  // savings_records 集合
  {
    _id: ObjectId,
    user_id: ObjectId,
    amount: Number,
    category: String, // 'salary', 'investment_return', 'side_income', 'other'
    date: Date,
    note: String,
    created_at: Date
  }

  // expenses_records 集合
  {
    _id: ObjectId,
    user_id: ObjectId,
    amount: Number,
    category: String, // 'housing', 'food', 'transport', 'entertainment', 'other'
    date: Date,
    note: String,
    created_at: Date
  }

  // investment_portfolio 集合
  {
    _id: ObjectId,
    user_id: ObjectId,
    asset_type: String, // 'stocks', 'bonds', 'real_estate', 'crypto', 'cash'
    ticker_symbol: String, // 可选,股票代码
    amount: Number,
    cost_basis: Number, // 成本
    current_value: Number,
    allocation_percentage: Number,
    last_updated: Date,
    created_at: Date
  }
  ```
- [ ] 设置 MongoDB 索引:
  ```javascript
  // 用户邮箱唯一索引
  db.users.createIndex({ email: 1 }, { unique: true });
  
  // 会话查询索引
  db.conversations.createIndex({ user_id: 1, created_at: -1 });
  
  // 消息查询索引
  db.messages.createIndex({ conversation_id: 1, created_at: 1 });
  
  // FIRE 计划查询索引
  db.fire_plans.createIndex({ user_id: 1 });
  
  // 财务记录时间范围查询索引
  db.savings_records.createIndex({ user_id: 1, date: -1 });
  db.expenses_records.createIndex({ user_id: 1, date: -1 });
  ```
- [ ] 搭建 RESTful API 基础结构
- [ ] 配置环境变量管理

**前端任务:**
- [ ] 初始化 SwiftUI 项目
- [ ] 配置项目结构(MVVM 架构)
- [ ] 设置网络请求层(Alamofire/URLSession)
- [ ] 配置主题颜色和设计系统:
  ```swift
  // Colors.swift
  extension Color {
    static let primaryGreen = Color(hex: "#13EC5B")
    static let backgroundDark = Color(hex: "#102216")
    static let cardBackground = Color(hex: "#23482F")
    static let borderColor = Color(hex: "#1E293B")
    static let textPrimary = Color(hex: "#F1F5F9")
    static let textSecondary = Color(hex: "#64748B")
  }
  ```

**AI/RAG 任务:**
- [ ] 初始化 LangChain 项目
- [ ] 配置 OpenAI/Claude API
- [ ] 搭建基础 RAG 架构
- [ ] 准备 FIRE 初始知识库:
  - FIRE 运动基础知识
  - 4% 规则详解
  - 储蓄率与退休年龄关系
  - 投资组合配置策略
  - 税务优化策略
  - Coast FIRE、Lean FIRE、Fat FIRE 等变体
  - 常见问答

#### 1.2 聊天功能实现 (Week 2-3)

**后端 API:**
- [ ] `POST /api/conversations` - 创建新会话
- [ ] `GET /api/conversations/:id` - 获取会话详情
- [ ] `GET /api/conversations/:id/messages` - 获取消息列表
- [ ] `POST /api/conversations/:id/messages` - 发送消息
- [ ] `WebSocket /ws` - 实时消息推送

**前端界面:**
- [ ] 实现聊天界面 UI(基于 Figma 设计)
  - [ ] Header 组件(标题、在线状态、按钮)
  - [ ] 消息列表组件(AI/用户消息气泡)
  - [ ] 输入框组件
  - [ ] 底部导航栏
- [ ] 实现消息发送逻辑
- [ ] 实现消息接收和展示
- [ ] 实现自动滚动到最新消息
- [ ] 实现打字指示器(AI 正在回复...)

**AI 对话逻辑:**
- [ ] 实现基础对话流程(LangChain)
- [ ] 配置 FIRE 专用 Prompt Templates:
  ```javascript
  const FIRE_SYSTEM_PROMPT = `你是一个专业的 FIRE (Financial Independence, Retire Early) 财务顾问 AI。

你的专长领域:
1. FIRE 运动和提前退休规划
2. 4% 安全提取规则和变体(3.5%, 3.25% 等)
3. 储蓄率优化(目标 50%+ 储蓄率)
4. 投资组合配置(股债比例、指数基金、被动投资)
5. 税务优化策略(401k, IRA, Roth IRA 等)
6. 被动收入构建(股息、租金、版税)
7. Coast FIRE、Lean FIRE、Fat FIRE、Barista FIRE 等不同路径

你的职责:
- 帮助用户计算 FIRE 数字(年支出 × 25)
- 分析当前财务状况与 FIRE 目标的差距
- 提供个性化的储蓄和投资建议
- 生成详细的 FIRE 计划和时间线
- 解释复杂的财务概念(使用简单语言)
- 标记重要概念(使用 **概念** 格式)

注意事项:
- 提供具体的数字和计算过程
- 考虑通货膨胀(2-3%)
- 强调风险管理和应急基金
- 鼓励持续学习和社区参与`;
  ```
- [ ] 实现流式响应(Streaming)
- [ ] 添加对话历史管理

#### 1.3 用户认证系统 (Week 3-4)

**后端:**
- [ ] 实现 JWT 认证
- [ ] `POST /api/auth/register` - 用户注册
- [ ] `POST /api/auth/login` - 用户登录
- [ ] `POST /api/auth/logout` - 用户登出
- [ ] `GET /api/auth/me` - 获取当前用户信息

**前端:**
- [ ] 登录/注册界面
- [ ] Token 存储和管理(Keychain)
- [ ] 自动登录逻辑
- [ ] 登出功能

#### 1.4 基础 RAG 实现 (Week 4-5)

**RAG 系统:**
- [ ] 配置向量数据库(Pinecone/Chroma)
- [ ] 实现文档向量化(Embeddings)
- [ ] 实现语义搜索
- [ ] 集成到对话流程:
  ```javascript
  // 伪代码
  async function handleFIREQuery(query, userData) {
    // 1. 检索 FIRE 相关知识
    const relevantDocs = await vectorStore.similaritySearch(query, k=3);
    
    // 2. 计算用户的 FIRE 指标
    const fireMetrics = {
      fireNumber: userData.annualExpenses * 25,
      currentProgress: (userData.currentSavings / (userData.annualExpenses * 25)) * 100,
      yearsToFIRE: calculateYearsToFIRE(userData),
      savingsRate: (userData.monthlySavings / userData.monthlyIncome) * 100
    };
    
    // 3. 构建个性化 Prompt
    const prompt = buildFIREPrompt(query, relevantDocs, conversationHistory, userData, fireMetrics);
    
    // 4. 调用 LLM
    const response = await llm.stream(prompt);
    
    return response;
  }
  
  function calculateYearsToFIRE(userData) {
    // 使用储蓄率计算 FIRE 时间
    // 公式: Years = log(1 + (FV/PV) * (r / PMT)) / log(1 + r)
    // 简化版: 基于储蓄率的经验公式
    const savingsRate = userData.monthlySavings / userData.monthlyIncome;
    if (savingsRate >= 0.70) return 8.5;  // 70% 储蓄率
    if (savingsRate >= 0.60) return 12.5; // 60% 储蓄率
    if (savingsRate >= 0.50) return 17;   // 50% 储蓄率
    if (savingsRate >= 0.40) return 22;   // 40% 储蓄率
    if (savingsRate >= 0.30) return 28;   // 30% 储蓄率
    return 37; // 25% 储蓄率
  }
  ```
- [ ] 准备 FIRE 知识库内容:
  - **基础概念**: FIRE 运动历史、核心原则
  - **4% 规则**: Trinity Study 研究、安全提取率
  - **储蓄率表**: 不同储蓄率对应的 FIRE 年限
  - **投资策略**: 三基金组合、全市场指数基金
  - **FIRE 类型**: 
    * Lean FIRE: 极简生活,低支出
    * Coast FIRE: 提前储蓄够本金,让复利增长
    * Barista FIRE: 半退休,兼职覆盖生活开支
    * Fat FIRE: 高质量退休生活
  - **税务优化**: 401k, IRA, Roth IRA, HSA 等账户
  - **常见误区和风险**

#### 1.5 测试和优化 (Week 5-6)

**测试:**
- [ ] 单元测试(后端 API)
- [ ] UI 测试(前端界面)
- [ ] 集成测试(端到端)
- [ ] 性能测试

**优化:**
- [ ] API 响应速度优化
- [ ] UI 动画优化
- [ ] 内存管理优化

---

### 第二期:高级功能 (4-6 周)

#### 2.1 文件附件功能 (Week 7-8)

**后端:**
- [ ] 配置文件存储(AWS S3/阿里云 OSS)
- [ ] `POST /api/files/upload` - 上传文件
- [ ] `GET /api/files/:id` - 获取文件
- [ ] `GET /api/files/:id/download` - 下载文件
- [ ] 文件类型验证(PDF, PNG, JPG 等)
- [ ] 文件大小限制(最大 10MB)

**前端:**
- [ ] 实现附件上传 UI
- [ ] 实现文件选择器
- [ ] 实现附件预览卡片(如设计中的 PDF 卡片)
- [ ] 实现文件下载功能
- [ ] 实现上传进度显示

**AI 功能:**
- [ ] PDF 解析和内容提取
- [ ] 将上传文档加入 RAG 知识库
- [ ] 实现文档问答功能(分析用户的财务报表、工资单等)

#### 2.2 AI 生成 FIRE 报告 (Week 8-9)

**后端:**
- [ ] `POST /api/fire-reports/generate` - 生成 FIRE 计划报告
- [ ] `GET /api/fire-reports/:id` - 获取报告
- [ ] 报告模板管理

**AI 功能:**
- [ ] 实现 FIRE 报告生成逻辑:
  ```javascript
  async function generateFIREReport(userData) {
    const prompt = `
      基于以下用户数据生成完整的 FIRE (财务独立,提前退休) 规划报告:
      
      【基本信息】
      - 当前年龄: ${userData.age} 岁
      - 目标 FIRE 年龄: ${userData.targetFIREAge} 岁
      - 当前储蓄: $${userData.currentSavings}
      - 月收入: $${userData.monthlyIncome}
      - 月支出: $${userData.monthlyExpenses}
      - 年支出: $${userData.annualExpenses}
      - 储蓄率: ${userData.savingsRate}%
      
      【计算指标】
      - FIRE 数字: $${userData.annualExpenses * 25} (年支出 × 25)
      - 当前进度: ${(userData.currentSavings / (userData.annualExpenses * 25)) * 100}%
      - 预计 FIRE 年限: ${calculateYearsToFIRE(userData)} 年
      
      请生成详细的 FIRE 规划报告,包括:
      
      ## 1. 执行摘要
      - 你的 FIRE 目标和当前进度
      - 关键发现和建议
      
      ## 2. FIRE 数字分析
      - 基于 4% 规则计算所需资产
      - 考虑通货膨胀调整
      - 安全边际建议
      
      ## 3. 储蓄率优化
      - 当前储蓄率分析
      - 提高储蓄率的具体方法
      - 不同储蓄率下的 FIRE 时间表
      
      ## 4. 投资策略建议
      - 资产配置建议(股债比例)
      - 推荐的指数基金
      - 再平衡策略
      
      ## 5. 税务优化
      - 税优账户利用(401k, IRA, Roth IRA, HSA)
      - 提取顺序策略
      
      ## 6. 里程碑和行动计划
      - 短期目标(1 年)
      - 中期目标(3-5 年)
      - 长期目标(FIRE 达成)
      
      ## 7. 风险管理
      - 应急基金建议
      - 保险配置
      - 市场波动应对
      
      ## 8. FIRE 后的生活规划
      - 支出结构调整
      - 医疗保险安排
      - 生活方式建议
    `;
    
    const report = await llm.invoke(prompt);
    const pdf = await generatePDF(report, {
      title: `FIRE 规划报告 - ${userData.username}`,
      subtitle: `生成日期: ${new Date().toLocaleDateString()}`,
      theme: 'fire' // 使用 FIRE 主题色(绿色)
    });
    
    return pdf;
  }
  ```
- [ ] PDF 生成(使用 puppeteer/pdfkit)
- [ ] 报告内容优化和可视化(图表、进度条等)

**前端:**
- [ ] 实现"生成报告"触发按钮
- [ ] 实现报告生成进度提示
- [ ] 实现报告预览和下载

#### 2.3 语音输入功能 (Week 9-10)

**后端:**
- [ ] 配置语音转文字服务(OpenAI Whisper)
- [ ] `POST /api/voice/transcribe` - 语音转文字

**前端:**
- [ ] 实现语音录制功能
- [ ] 实现录音动画效果
- [ ] 实现语音转文字逻辑
- [ ] 实现音频上传

#### 2.4 FIRE 关键词高亮 (Week 10-11)

**前端:**
- [ ] 实现文本解析逻辑
- [ ] 识别 FIRE 重要关键词:
  - "4% rule" (4% 规则)
  - "FIRE number" (FIRE 数字)
  - "savings rate" (储蓄率)
  - "Coast FIRE", "Lean FIRE", "Fat FIRE", "Barista FIRE"
  - "Trinity Study" (三一研究)
  - "safe withdrawal rate" (安全提取率)
  - "passive income" (被动收入)
  - "index fund" (指数基金)
  - "tax-advantaged accounts" (税优账户)
- [ ] 应用高亮样式(绿色加粗)
- [ ] 实现点击关键词查看详细解释

**AI 功能:**
- [ ] 返回消息时标记关键概念
- [ ] 提供关键词解释 API

#### 2.5 底部导航功能 (Week 11-12)

**前端页面:**
- [ ] **Home 页面** - FIRE 仪表盘
  - FIRE 进度环形图(当前资产/FIRE 数字)
  - 关键指标卡片:
    * 当前净资产
    * FIRE 数字
    * 储蓄率
    * 预计 FIRE 日期
  - 本月储蓄/支出趋势
  - 快捷操作(记录支出、记录收入、生成报告)
  
- [ ] **Plan 页面** - FIRE 路线图
  - 时间线视图(里程碑)
  - 储蓄计划:
    * 月度储蓄目标
    * 年度储蓄目标
    * 进度追踪
  - 投资组合:
    * 资产配置饼图
    * 各类资产详情
    * 再平衡建议
  - 目标设置和调整
  
- [ ] **Community 页面** - FIRE 社区
  - 热门话题讨论
  - 成功案例分享
  - 每月储蓄挑战
  - 用户排行榜(储蓄率、FIRE 进度)
  - FIRE 里程碑庆祝
  
- [ ] **Me 页面** - 个人中心
  - 个人信息和 FIRE 档案
  - FIRE 类型测试(Lean/Coast/Barista/Fat)
  - 历史对话记录
  - 生成的报告列表
  - 财务数据管理
  - 设置和隐私
  - 订阅管理

**后端 API:**
- [ ] 对应页面的数据接口

---

### 第三期:数据分析和个性化 (4-6 周)

#### 3.1 用户 FIRE 数据收集 (Week 13-14)

**数据模型 (MongoDB):**
```javascript
// fire_profiles 集合(已整合到 users 集合中)
// 追加到 users 文档的 fire_profile 字段

// net_worth_snapshots 集合 - 净资产快照
{
  _id: ObjectId,
  user_id: ObjectId,
  date: Date,
  assets: {
    cash: Number,
    checking_account: Number,
    savings_account: Number,
    investment_accounts: Number,
    retirement_accounts: Number, // 401k, IRA 等
    real_estate: Number,
    other: Number
  },
  liabilities: {
    mortgage: Number,
    student_loans: Number,
    credit_cards: Number,
    other_debt: Number
  },
  net_worth: Number, // assets 总和 - liabilities 总和
  fire_progress: Number, // (net_worth / fire_number) * 100
  created_at: Date
}

// income_streams 集合 - 收入来源
{
  _id: ObjectId,
  user_id: ObjectId,
  stream_type: String, // 'salary', 'dividend', 'rental', 'side_business', 'royalty'
  source_name: String,
  monthly_amount: Number,
  is_active: Boolean,
  is_passive: Boolean, // 是否被动收入
  created_at: Date,
  updated_at: Date
}

// fire_milestones 集合 - FIRE 里程碑
{
  _id: ObjectId,
  user_id: ObjectId,
  milestone_type: String, // 'first_10k', 'first_50k', 'first_100k', 'coast_fire', 'half_way', 'fire_achieved'
  title: String,
  target_amount: Number,
  achieved: Boolean,
  achieved_date: Date,
  celebration_message: String,
  created_at: Date
}
```

**后端 API:**
- [ ] `POST /api/fire/profile` - 更新 FIRE 档案
- [ ] `GET /api/fire/profile` - 获取 FIRE 档案
- [ ] `POST /api/fire/net-worth-snapshot` - 记录净资产快照
- [ ] `GET /api/fire/net-worth-history` - 获取净资产历史
- [ ] `POST /api/fire/income-stream` - 添加收入来源
- [ ] `GET /api/fire/income-streams` - 获取所有收入来源
- [ ] `GET /api/fire/milestones` - 获取里程碑列表
- [ ] `GET /api/fire/progress` - 获取 FIRE 进度综合数据

**前端:**
- [ ] FIRE 档案收集表单
- [ ] 数据可视化图表:
  - FIRE 进度环形图
  - 净资产增长折线图
  - 储蓄率趋势图
  - 收入 vs 支出堆叠柱状图
  - 资产配置饼图
- [ ] FIRE 进度追踪仪表盘
- [ ] 里程碑成就展示

#### 3.2 个性化 FIRE AI 建议 (Week 14-15)

**AI 功能:**
- [ ] 基于用户 FIRE 数据的个性化 Prompt
- [ ] 实现 FIRE AI Agent:
  ```javascript
  class FIREAdvisorAgent {
    constructor(llm, vectorStore, userData) {
      this.llm = llm;
      this.vectorStore = vectorStore;
      this.userData = userData;
    }
    
    async generatePersonalizedAdvice(query) {
      // 1. 计算用户 FIRE 指标
      const fireMetrics = this.calculateFIREMetrics();
      
      // 2. 检索知识库
      const context = await this.vectorStore.search(query);
      
      // 3. 分析用户财务状况
      const financialAnalysis = this.analyzeFinancialSituation();
      
      // 4. 生成个性化建议
      const advice = await this.llm.invoke({
        context,
        fireMetrics,
        financialAnalysis,
        query,
        conversationHistory: this.userData.conversationHistory
      });
      
      return advice;
    }
    
    calculateFIREMetrics() {
      const annualExpenses = this.userData.monthlyExpenses * 12;
      const fireNumber = annualExpenses * 25; // 4% 规则
      const currentNetWorth = this.userData.currentSavings; // 简化,实际应包含所有资产
      const progress = (currentNetWorth / fireNumber) * 100;
      const savingsRate = (this.userData.monthlySavings / this.userData.monthlyIncome) * 100;
      const yearsToFIRE = this.calculateYearsToFIRE(savingsRate);
      
      return {
        fireNumber,
        currentNetWorth,
        progress,
        savingsRate,
        yearsToFIRE,
        monthlyGap: (fireNumber - currentNetWorth) / (yearsToFIRE * 12)
      };
    }
    
    analyzeFinancialSituation() {
      const metrics = this.calculateFIREMetrics();
      const analysis = {
        strengths: [],
        weaknesses: [],
        opportunities: [],
        recommendations: []
      };
      
      // 储蓄率分析
      if (metrics.savingsRate >= 50) {
        analysis.strengths.push('极高的储蓄率,FIRE 速度很快');
      } else if (metrics.savingsRate >= 30) {
        analysis.strengths.push('良好的储蓄率');
      } else {
        analysis.weaknesses.push('储蓄率偏低,需要提高');
        analysis.recommendations.push('尝试将储蓄率提高到至少 30%');
      }
      
      // 进度分析
      if (metrics.progress >= 75) {
        analysis.strengths.push('已接近 FIRE 目标');
      } else if (metrics.progress >= 50) {
        analysis.strengths.push('已完成一半的 FIRE 旅程');
      } else if (metrics.progress >= 25) {
        analysis.opportunities.push('Coast FIRE 可能性');
      }
      
      // 支出分析
      const expenseRatio = this.userData.monthlyExpenses / this.userData.monthlyIncome;
      if (expenseRatio > 0.7) {
        analysis.weaknesses.push('支出占收入比例过高');
        analysis.recommendations.push('审查并减少非必要支出');
      }
      
      return analysis;
    }
  }
  ```
- [ ] 多轮对话记忆优化
- [ ] 建议质量评估和反馈循环

#### 3.3 FIRE 数据分析仪表盘 (Week 15-16)

**前端:**
- [ ] 实现图表库集成(Charts/SwiftUI Charts)
- [ ] **FIRE 进度可视化**:
  - 环形进度图(当前净资产/FIRE 数字)
  - 完成百分比和倒计时
- [ ] **净资产增长图表**:
  - 历史净资产折线图
  - 趋势预测线
  - 里程碑标记
- [ ] **储蓄率趋势**:
  - 月度储蓄率折线图
  - 目标储蓄率基准线
  - 不同储蓄率下的 FIRE 时间对比
- [ ] **收入 vs 支出**:
  - 堆叠柱状图(月度对比)
  - 储蓄金额可视化
- [ ] **投资组合分布**:
  - 资产配置饼图
  - 股债比例
  - 再平衡提醒
- [ ] **FIRE 类型分析**:
  - Lean/Coast/Barista/Fat FIRE 对比
  - 各类型所需资产和时间
- [ ] **被动收入追踪**:
  - 各收入来源占比
  - 被动收入覆盖支出比例

**后端:**
- [ ] 数据聚合 API:
  - `GET /api/analytics/fire-progress` - FIRE 进度综合数据
  - `GET /api/analytics/net-worth-trend` - 净资产趋势
  - `GET /api/analytics/savings-rate-history` - 储蓄率历史
  - `GET /api/analytics/income-expense-breakdown` - 收支明细
  - `GET /api/analytics/passive-income-ratio` - 被动收入比例
- [ ] 统计分析逻辑:
  ```javascript
  // 计算 FIRE 预测
  async function predictFIREDate(userId) {
    const user = await User.findById(userId);
    const history = await NetWorthSnapshot.find({ user_id: userId })
      .sort({ date: -1 })
      .limit(12); // 最近 12 个月
    
    // 计算月均增长率
    const monthlyGrowthRate = calculateGrowthRate(history);
    
    // 基于当前储蓄率和投资回报预测
    const fireNumber = user.fire_profile.fire_number;
    const currentNetWorth = history[0].net_worth;
    const gap = fireNumber - currentNetWorth;
    
    // 使用复利公式预测
    const monthsToFIRE = predictMonths(gap, monthlyGrowthRate);
    const fireDate = new Date();
    fireDate.setMonth(fireDate.getMonth() + monthsToFIRE);
    
    return {
      fireDate,
      monthsToFIRE,
      confidenceLevel: calculateConfidence(history),
      assumptions: {
        monthlyGrowthRate,
        expectedReturn: 0.07, // 7% 年化回报
        inflationRate: 0.03 // 3% 通胀
      }
    };
  }
  ```

#### 3.4 智能提醒和激励系统 (Week 16-18)

**后端:**
- [ ] 配置推送通知服务(APNs)
- [ ] 实现提醒调度器
- [ ] `POST /api/reminders` - 创建提醒
- [ ] `GET /api/reminders` - 获取提醒列表

**提醒类型:**
- [ ] **储蓄提醒**: 
  - 月度储蓄目标追踪
  - "距离本月储蓄目标还差 $500"
- [ ] **记账提醒**:
  - 提醒记录每日支出
  - "今天还没记录支出哦"
- [ ] **里程碑庆祝**:
  - 达成净资产里程碑
  - "恭喜!你的净资产突破 $50,000!"
- [ ] **投资提醒**:
  - 再平衡提醒
  - "你的股票比例已达 85%,考虑再平衡"
- [ ] **学习提醒**:
  - FIRE 知识每日一条
  - "今日 FIRE 小知识: Trinity Study"
- [ ] **社区活动**:
  - 月度储蓄挑战
  - "本月储蓄挑战已开始,快来参加!"

**前端:**
- [ ] 推送权限请求
- [ ] 提醒设置界面
- [ ] 通知处理逻辑
- [ ] 应用内通知中心

**AI 功能:**
- [ ] 智能提醒内容生成(个性化、鼓励性)
- [ ] 最佳提醒时间预测(基于用户行为)
- [ ] 激励语生成:
  ```javascript
  async function generateMotivationalMessage(user, milestone) {
    const progress = user.fire_profile.current_savings / user.fire_profile.fire_number;
    
    const prompt = `
      用户刚达成了一个 FIRE 里程碑: ${milestone.title}
      当前 FIRE 进度: ${(progress * 100).toFixed(1)}%
      
      请生成一条鼓励性的消息,要求:
      1. 庆祝这个成就
      2. 提醒他们已经走了多远
      3. 鼓励继续前进
      4. 简短有力(50 字以内)
      5. 体现 FIRE 精神
    `;
    
    return await llm.invoke(prompt);
  }
  ```

---

### 第四期:高级 RAG 和优化 (4-6 周)

#### 4.1 多源 FIRE 知识库 (Week 19-20)

**RAG 优化:**
- [ ] 支持多种文档类型:
  - **FIRE 博客和书籍**: 
    * "Your Money or Your Life" by Vicki Robin
    * "The Simple Path to Wealth" by JL Collins
    * Mr. Money Mustache 博客
    * Financial Samurai
    * Choose FI
  - **财经新闻**: 
    * 市场行情
    * 经济政策
    * 税法变化
  - **投资指南**: 
    * Vanguard, Fidelity 投资指南
    * Bogleheads 投资哲学
    * 指数基金介绍
  - **FIRE 案例研究**:
    * 成功 FIRE 人士访谈
    * 不同年龄段 FIRE 策略
    * 各国 FIRE 实践
  - **用户上传文档**:
    * 工资单
    * 投资账户对账单
    * 税务文件
    
- [ ] 实现文档分类和标签系统
- [ ] 实现知识库管理后台(CMS)
- [ ] 优化检索策略:
  - 混合检索(Hybrid Search): 关键词 + 语义
  - 重排序(Reranking)
  - 上下文窗口扩展
- [ ] 知识图谱构建(FIRE 概念关联)

#### 4.2 高级 FIRE AI Agent (Week 20-21)

**AI Agent 优化:**
- [ ] 实现多专家 Agent 协作:
  ```javascript
  // FIRE 专家 Agents
  const savingsOptimizationAgent = new SavingsOptimizationAgent(llm, {
    expertise: ['budget_reduction', 'savings_rate_increase', 'expense_tracking']
  });
  
  const investmentStrategyAgent = new InvestmentStrategyAgent(llm, {
    expertise: ['asset_allocation', 'index_funds', 'rebalancing', 'tax_optimization']
  });
  
  const taxOptimizationAgent = new TaxOptimizationAgent(llm, {
    expertise: ['401k', 'ira', 'roth_ira', 'hsa', 'tax_loss_harvesting']
  });
  
  const firePathAgent = new FIREPathAgent(llm, {
    expertise: ['coast_fire', 'lean_fire', 'fat_fire', 'barista_fire', 'timeline_planning']
  });
  
  const retirementSpendingAgent = new RetirementSpendingAgent(llm, {
    expertise: ['4_percent_rule', 'withdrawal_strategies', 'healthcare', 'inflation']
  });
  
  // 协调器 - 根据问题路由到合适的专家
  const fireCoordinator = new FIREAgentCoordinator([
    savingsOptimizationAgent,
    investmentStrategyAgent,
    taxOptimizationAgent,
    firePathAgent,
    retirementSpendingAgent
  ]);
  
  // 智能路由
  async function handleFIREQuery(query, userData) {
    // 1. 分析问题类型
    const queryType = await fireCoordinator.classifyQuery(query);
    
    // 2. 路由到对应专家
    const response = await fireCoordinator.route(query, queryType, userData);
    
    return response;
  }
  ```
  
- [ ] 实现 ReAct 模式(推理 + 行动):
  ```javascript
  // FIRE 计算器工具
  const fireCalculatorTool = {
    name: 'fire_calculator',
    description: '计算 FIRE 相关指标',
    execute: async (params) => {
      const { annualExpenses, currentSavings, monthlySavings, expectedReturn } = params;
      
      const fireNumber = annualExpenses * 25; // 4% 规则
      const gap = fireNumber - currentSavings;
      const monthsToFIRE = calculateMonthsToFIRE(gap, monthlySavings, expectedReturn);
      
      return {
        fireNumber,
        currentProgress: (currentSavings / fireNumber) * 100,
        monthsToFIRE,
        yearsToFIRE: monthsToFIRE / 12,
        projectedFIREDate: new Date(Date.now() + monthsToFIRE * 30 * 24 * 60 * 60 * 1000)
      };
    }
  };
  
  // 储蓄率优化工具
  const savingsRateOptimizerTool = {
    name: 'savings_rate_optimizer',
    description: '分析不同储蓄率对 FIRE 时间的影响',
    execute: async (params) => {
      const { income, expenses } = params;
      const scenarios = [];
      
      for (let rate = 20; rate <= 70; rate += 10) {
        const savings = income * (rate / 100);
        const newExpenses = income - savings;
        const fireNumber = newExpenses * 12 * 25;
        const yearsToFIRE = getYearsToFIRE(rate);
        
        scenarios.push({
          savingsRate: rate,
          monthlySavings: savings,
          monthlyExpenses: newExpenses,
          fireNumber,
          yearsToFIRE
        });
      }
      
      return scenarios;
    }
  };
  
  // Agent 使用工具
  const agentWithTools = new Agent({
    llm,
    tools: [fireCalculatorTool, savingsRateOptimizerTool],
    systemPrompt: `你是一个 FIRE 顾问,可以使用计算器工具来提供精确的建议。
    
当需要计算时,使用 fire_calculator 工具。
当需要分析不同储蓄率方案时,使用 savings_rate_optimizer 工具。

始终先思考(Thought),再决定行动(Action),最后总结(Observation)。`
  });
  ```
  
- [ ] 添加更多工具能力:
  - [ ] 复利计算器
  - [ ] 通胀调整器
  - [ ] 退休支出规划器
  - [ ] 税后收益计算器
  - [ ] 社保收益估算器

#### 4.3 对话质量优化 (Week 21-22)

**优化点:**
- [ ] 添加对话评分系统
- [ ] 实现 RLHF(人类反馈强化学习)
- [ ] 优化 Prompt Engineering
- [ ] 添加安全检查(防止有害建议)
- [ ] 实现 Fallback 策略

#### 4.4 性能优化 (Week 22-24)

**后端优化:**
- [ ] API 缓存策略(Redis)
- [ ] 数据库查询优化
- [ ] 实现 API 限流
- [ ] 添加 CDN(静态资源)

**前端优化:**
- [ ] 图片懒加载
- [ ] 消息虚拟滚动
- [ ] 本地缓存优化
- [ ] 网络请求优化

**AI 优化:**
- [ ] 向量检索优化
- [ ] 模型推理加速
- [ ] 批处理优化
- [ ] 成本优化(使用更便宜的模型处理简单问题)

---

## 技术架构详细设计

### 系统架构图

```
┌─────────────────────────────────────────────────────────────┐
│                   iOS App (SwiftUI) - FIRE UI               │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐   │
│  │   FIRE   │  │   FIRE   │  │ AI FIRE  │  │    Me    │   │
│  │Dashboard │  │ Roadmap  │  │ Advisor  │  │ Profile  │   │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘   │
│         │              │             │              │        │
│         └──────────────┴─────────────┴──────────────┘        │
│                         │                                    │
│                    Network Layer                             │
└─────────────────────────┬───────────────────────────────────┘
                          │ HTTPS/WSS
                          ▼
┌─────────────────────────────────────────────────────────────┐
│                API Gateway (Node.js/Express)                 │
��  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐   │
│  │   Auth   │  │   FIRE   │  │   Chat   │  │   File   │   │
│  │ Service  │  │ Service  │  │ Service  │  │ Service  │   │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘   │
└─────────────────────────┬───────────────────────────────────┘
                          │
         ┌────────────────┼────────────────┐
         ▼                ▼                ▼
┌──────────────┐  ┌──────────────┐  ┌──────────────┐
│   MongoDB    │  │    Redis     │  │   S3/OSS     │
│(主数据库,文档)│  │   (缓存)     │  │ (文件存储)    │
│  - users     │  │  - sessions  │  │  - reports   │
│  - messages  │  │  - fire_calc │  │  - uploads   │
│  - fire_plans│  │              │  │              │
└──────────────┘  └──────────────┘  └──────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│              AI/RAG Service (Python/LangChain)               │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                    LangChain                          │  │
│  │  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐│  │
│  │  │  LLM    │  │ Vector  │  │ Memory  │  │ FIRE    ││  │
│  │  │(GPT-4)  │  │ Store   │  │ Manager │  │ Tools   ││  │
│  │  │         │  │(Pinecone│  │         │  │         ││  │
│  │  └─────────┘  └─────────┘  └─────────┘  └─────────┘│  │
│  │                                                       │  │
│  │  FIRE Expert Agents:                                 │  │
│  │  - Savings Optimization Agent                        │  │
│  │  - Investment Strategy Agent                         │  │
│  │  - Tax Optimization Agent                            │  │
│  │  - FIRE Path Agent                                   │  │
│  │  - Retirement Spending Agent                         │  │
│  └──────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

### 数据流程

#### 用户询问 FIRE 问题流程:
```
1. 用户在 iOS App 输入 FIRE 相关问题
   例: "我现在 30 岁,想 40 岁退休,需要存多少钱?"

2. App 通过 WebSocket 发送到后端
   {
     query: "我现在 30 岁,想 40 岁退休,需要存多少钱?",
     user_id: "xxx",
     conversation_id: "yyy"
   }

3. 后端接收并存储消息到 MongoDB

4. 后端调用 FIRE AI Service

5. AI Service 处理流程:
   a. 查询用户 FIRE 档案(MongoDB)
      - 年龄: 30
      - 月收入: $5000
      - 月支出: $2500
      - 当前储蓄: $50000
      
   b. 检索 FIRE 知识库(Pinecone)
      - 搜索 "4% 规则"
      - 搜索 "FIRE 数字计算"
      - 搜索 "储蓄率与年限关系"
      
   c. 使用 FIRE Calculator Tool 计算
      fireNumber = $2500 * 12 * 25 = $750,000
      gap = $750,000 - $50,000 = $700,000
      需要 10 年达成(基于当前储蓄率)
      
   d. 构建个性化 Prompt
      ```
      用户档案: 30岁,月收入$5000,月支出$2500,已有$50000储蓄
      FIRE目标: 40岁(10年内)
      计算结果: 需要$750,000,当前缺口$700,000
      知识库: [4%规则, 储蓄率表, 投资策略]
      
      请提供详细的 FIRE 规划建议...
      ```
      
   e. 调用 LLM 生成回复(流式)
   
6. 流式回复通过 WebSocket 实时返回前端
   - 检测关键词("FIRE number", "4% rule")并高亮
   - 实时渲染 AI 回复

7. 完整回复保存到 MongoDB

8. 更新用户 FIRE 档案和里程碑
```

### LangChain FIRE RAG 实现示例

```javascript
// fire-rag-service.js
const { ChatOpenAI } = require("@langchain/openai");
const { ChatPromptTemplate } = require("@langchain/core/prompts");
const { PineconeStore } = require("@langchain/pinecone");
const { OpenAIEmbeddings } = require("@langchain/openai");
const { Tool } = require("@langchain/core/tools");

class FIRERAGService {
  constructor() {
    this.llm = new ChatOpenAI({
      modelName: "gpt-4-turbo",
      temperature: 0.7,
      streaming: true,
    });
    
    this.embeddings = new OpenAIEmbeddings();
    this.vectorStore = null;
    
    // FIRE 计算工具
    this.fireCalculatorTool = new Tool({
      name: "fire_calculator",
      description: "计算 FIRE 相关指标,包括 FIRE 数字、所需年限、储蓄目标等",
      func: async (input) => {
        const params = JSON.parse(input);
        return JSON.stringify(this.calculateFIREMetrics(params));
      }
    });
  }
  
  async initialize() {
    // 初始化 FIRE 知识库向量数据库
    this.vectorStore = await PineconeStore.fromExistingIndex(
      this.embeddings,
      { 
        indexName: "fire-knowledge",
        namespace: "fire-documents" // FIRE 专用命名空间
      }
    );
  }
  
  calculateFIREMetrics(params) {
    const {
      currentAge,
      targetFIREAge,
      annualExpenses,
      currentSavings,
      monthlyIncome,
      monthlySavings,
      expectedReturn = 0.07, // 7% 年化回报
      inflationRate = 0.03   // 3% 通胀
    } = params;
    
    // 1. 计算 FIRE 数字(4% 规则)
    const fireNumber = annualExpenses * 25;
    
    // 2. 当前进度
    const currentProgress = (currentSavings / fireNumber) * 100;
    
    // 3. 缺口
    const gap = fireNumber - currentSavings;
    
    // 4. 储蓄率
    const savingsRate = (monthlySavings / monthlyIncome) * 100;
    
    // 5. 预计年限(考虑投资回报)
    const monthlyReturn = Math.pow(1 + expectedReturn, 1/12) - 1;
    let months = 0;
    let portfolio = currentSavings;
    
    while (portfolio < fireNumber && months < 600) { // 最多 50 年
      portfolio = portfolio * (1 + monthlyReturn) + monthlySavings;
      months++;
    }
    
    const yearsToFIRE = months / 12;
    const projectedFIREAge = currentAge + yearsToFIRE;
    
    // 6. 通胀调整后的 FIRE 数字
    const inflationAdjustedFIRENumber = fireNumber * Math.pow(1 + inflationRate, yearsToFIRE);
    
    return {
      fireNumber: Math.round(fireNumber),
      inflationAdjustedFIRENumber: Math.round(inflationAdjustedFIRENumber),
      currentProgress: Math.round(currentProgress * 10) / 10,
      gap: Math.round(gap),
      savingsRate: Math.round(savingsRate * 10) / 10,
      yearsToFIRE: Math.round(yearsToFIRE * 10) / 10,
      monthsToFIRE: months,
      projectedFIREAge: Math.round(projectedFIREAge),
      onTrack: projectedFIREAge <= targetFIREAge,
      monthlyShortfall: projectedFIREAge > targetFIREAge 
        ? Math.round((inflationAdjustedFIRENumber - currentSavings) / ((targetFIREAge - currentAge) * 12) - monthlySavings)
        : 0
    };
  }
  
  async chat(query, conversationHistory, userData) {
    // 1. 检索 FIRE 知识库
    const relevantDocs = await this.vectorStore.similaritySearch(query, 3);
    
    // 2. 计算用户 FIRE 指标
    const fireMetrics = this.calculateFIREMetrics({
      currentAge: userData.fire_profile.current_age,
      targetFIREAge: userData.fire_profile.target_fire_age,
      annualExpenses: userData.fire_profile.monthly_expenses * 12,
      currentSavings: userData.fire_profile.current_savings,
      monthlyIncome: userData.fire_profile.monthly_income,
      monthlySavings: userData.fire_profile.monthly_income - userData.fire_profile.monthly_expenses,
    });
    
    // 3. 构建系统 Prompt
    const systemPrompt = this.buildFIRESystemPrompt(userData, fireMetrics);
    
    // 4. 构建用户 Prompt
    const userPrompt = this.buildUserPrompt(query, relevantDocs, conversationHistory);
    
    // 5. 创建 Prompt Template
    const prompt = ChatPromptTemplate.fromMessages([
      ["system", systemPrompt],
      ["user", userPrompt]
    ]);
    
    // 6. 生成流式回复
    const chain = prompt.pipe(this.llm);
    const stream = await chain.stream({
      query,
      context: relevantDocs.map(doc => doc.pageContent).join("\n\n"),
      fireMetrics: JSON.stringify(fireMetrics, null, 2),
    });
    
    return stream;
  }
  
  buildFIRESystemPrompt(userData, fireMetrics) {
    return `你是一个专业的 FIRE (Financial Independence, Retire Early) 财务顾问 AI。

【用户 FIRE 档案】
- 姓名: ${userData.username}
- 当前年龄: ${userData.fire_profile.current_age} 岁
- 目标 FIRE 年龄: ${userData.fire_profile.target_fire_age} 岁
- 距离目标: ${userData.fire_profile.target_fire_age - userData.fire_profile.current_age} 年
- 月收入: $${userData.fire_profile.monthly_income.toLocaleString()}
- 月支出: $${userData.fire_profile.monthly_expenses.toLocaleString()}
- 当前储蓄: $${userData.fire_profile.current_savings.toLocaleString()}
- 风险偏好: ${userData.fire_profile.risk_tolerance}

【FIRE 指标分析】
- FIRE 数字: $${fireMetrics.fireNumber.toLocaleString()} (年支出 × 25)
- 通胀调整后: $${fireMetrics.inflationAdjustedFIRENumber.toLocaleString()}
- 当前进度: ${fireMetrics.currentProgress}%
- 储蓄率: ${fireMetrics.savingsRate}%
- 预计 FIRE 年限: ${fireMetrics.yearsToFIRE} 年
- 预计 FIRE 年龄: ${fireMetrics.projectedFIREAge} 岁
- 是否按计划: ${fireMetrics.onTrack ? '✅ 是' : '❌ 否'}
${!fireMetrics.onTrack ? `- 每月需增加储蓄: $${fireMetrics.monthlyShortfall.toLocaleString()}` : ''}

【你的职责】
1. 基于用户的 FIRE 档案提供个性化建议
2. 解释 FIRE 核心概念(4% 规则、储蓄率、被动收入等)
3. 分析用户当前进度并给出改进建议
4. 提供具体的行动计划和里程碑
5. 考虑风险管理和应急基金
6. 推荐适合的 FIRE 类型(Lean/Coast/Barista/Fat)

【重要概念标记】
使用 **概念** 格式标记重要的 FIRE 概念,例如:
- **4% 规则**
- **FIRE 数字**
- **储蓄率**
- **Coast FIRE**
- **被动收入**

【语气和风格】
- 友好、鼓励、专业
- 使用简洁清晰的语言
- 提供具体数字和计算过程
- 保持乐观但现实的态度
- 适时庆祝用户的进步`;
  }
  
  buildUserPrompt(query, relevantDocs, history) {
    const historyText = history
      .slice(-5) // 最近 5 轮对话
      .map(msg => `${msg.role === 'user' ? '用户' : 'FIRE AI'}: ${msg.content}`)
      .join('\n');
    
    return `【FIRE 知识库参考】
${relevantDocs.map((doc, i) => `
参考 ${i + 1}:
${doc.pageContent}
---
`).join('\n')}

${historyText ? `【对话历史】\n${historyText}\n` : ''}

【用户问题】
${query}

请基于用户的 FIRE 档案、知识库参考和对话历史,提供详细、个性化的回答。`;
  }
}

module.exports = FIRERAGService;
```

### MongoDB 与 LangChain 集成

```javascript
// mongodb-memory.js
const { BufferMemory } = require("langchain/memory");
const { MongoDBChatMessageHistory } = require("@langchain/mongodb");

class FIREChatMemory {
  constructor(mongoClient, userId, conversationId) {
    this.memory = new BufferMemory({
      chatHistory: new MongoDBChatMessageHistory({
        collection: mongoClient.db("fire_app").collection("messages"),
        sessionId: conversationId,
        userId: userId,
      }),
      returnMessages: true,
      memoryKey: "chat_history",
      inputKey: "input",
      outputKey: "output",
    });
  }
  
  async loadMemory() {
    return await this.memory.loadMemoryVariables({});
  }
  
  async saveContext(input, output) {
    await this.memory.saveContext({ input }, { output });
  }
}

module.exports = FIREChatMemory;
```

---

## 关键指标 (KPI)

### 第一期目标 (MVP):
- [ ] 注册用户数: 100+
- [ ] 日活用户(DAU): 20+
- [ ] 平均对话轮次: 5+
- [ ] AI 响应时间: < 3s
- [ ] 用户满意度: 80%+
- [ ] FIRE 档案完成率: 60%+

### 第二期目标 (高级功能):
- [ ] 注册用户数: 500+
- [ ] 日活用户(DAU): 100+
- [ ] FIRE 报告生成数: 50+
- [ ] 文件上传数: 100+
- [ ] 用户留存率(7 天): 40%+
- [ ] 关键词点击率: 20%+

### 第三期目标 (个性化):
- [ ] 注册用户数: 2000+
- [ ] 日活用户(DAU): 500+
- [ ] 月活用户(MAU): 1200+
- [ ] 个性化建议采纳率: 60%+
- [ ] 推送点击率: 30%+
- [ ] 净资产记录频率: 每月 80%+ 用户
- [ ] 里程碑达成数: 100+

### 第四期目标 (成熟产品):
- [ ] 注册用户数: 5000+
- [ ] 日活用户(DAU): 1500+
- [ ] 月活用户(MAU): 3500+
- [ ] AI 回答准确率: 95%+
- [ ] 系统可用性: 99.9%+
- [ ] 成本优化: -30% (通过缓存和模型选择)
- [ ] 社区活跃度: 500+ 月活跃用户
- [ ] 成功 FIRE 案例: 5+

### FIRE 专属指标:
- [ ] 平均用户储蓄率: 35%+
- [ ] 平均 FIRE 进度增长: +5% 每季度
- [ ] FIRE 知识测试平均分: 80+
- [ ] 用户推荐 FIRE 类型分布:
  * Coast FIRE: 30%
  * Lean FIRE: 20%
  * Barista FIRE: 25%
  * Fat FIRE: 25%

---

## 风险和挑战

### 技术风险:
1. **LLM API 成本过高**
   - 影响: FIRE 计算需要频繁调用 LLM,成本可能较高
   - 缓解: 
     * 对简单计算使用本地算法,不调用 LLM
     * 缓存常见 FIRE 问题的答案
     * 使用 GPT-3.5 处理简单问题,GPT-4 处理复杂咨询
     * 实现智能路由(根据问题复杂度选择模型)
   
2. **RAG 检索质量不稳定**
   - 影响: 可能返回不相关的 FIRE 知识
   - 缓解: 
     * 优化 Embedding 策略,使用 FIRE 专用微调模型
     * 实现混合检索(关键词 + 语义)
     * 添加人工审核和反馈循环
     * 定期更新知识库
   
3. **实时性能问题**
   - 影响: 复杂 FIRE 计算可能导致响应延迟
   - 缓解: 
     * 使用流式响应,先展示部分结果
     * 优化数据库查询(MongoDB 索引)
     * Redis 缓存用户 FIRE 档案
     * 异步处理报告生成

4. **数据一致性(MongoDB)**
   - 影响: 文档数据库可能出现不一致
   - 缓解:
     * 使用 MongoDB 事务(Transaction)
     * 实现乐观锁
     * 定期数据校验和修复

### 业务风险:
1. **FIRE 建议准确性**
   - 影响: 错误建议可能影响用户财务决策
   - 缓解: 
     * 添加明确的免责声明
     * 所有计算结果附带假设说明
     * 鼓励用户咨询专业理财顾问
     * 人工审核关键建议(如大额资产配置)
     * 实现建议评分和用户反馈系统
   
2. **用户数据安全和隐私**
   - 影响: 财务数据泄露风险高
   - 缓解: 
     * 所有财务数据加密存储(MongoDB 加密)
     * 传输使用 HTTPS/TLS
     * 严格的权限控制(RBAC)
     * 定期安全审计
     * GDPR/CCPA 合规
     * 支持数据导出和删除
   
3. **法律合规性**
   - 影响: 财务建议可能涉及金融监管
   - 缓解: 
     * 咨询法律顾问,确保合规
     * 明确产品定位为"教育工具"而非"投资建议"
     * 避免推荐具体股票/基金
     * 遵守各地金融监管要求
   
4. **FIRE 理念认知差异**
   - 影响: 不同地区/文化对 FIRE 的接受度不同
   - 缓解:
     * 提供多种 FIRE 路径(Lean/Coast/Barista/Fat)
     * 支持多币种和地区化
     * 尊重用户个人选择
     * 提供现实的期望管理

### 产品风险:
1. **用户留存挑战**
   - 影响: FIRE 是长期目标,用户可能失去动力
   - 缓解:
     * 设计里程碑和成就系统
     * 提供每日/每周内容更新
     * 构建活跃社区
     * 推送个性化激励消息
     * 游戏化设计(徽章、排行榜)
   
2. **竞品竞争**
   - 影响: 可能存在类似 FIRE 应用
   - 缓解:
     * 强化 AI 对话体验
     * 提供独特的个性化建议
     * 构建高质量 FIRE 知识库
     * 打造活跃的 FIRE 社区
     * 持续功能创新

### 技术债务风险:
1. **快速迭代导致代码质量下降**
   - 缓解:
     * 代码审查制度
     * 单元测试覆盖率 > 80%
     * 定期重构
     * 技术文档完善
   
2. **MongoDB Schema 演化**
   - 缓解:
     * 使用 Schema 版本控制
     * 数据迁移脚本
     * 向后兼容设计

---

## 下一步行动

### 立即开始 (Week 1):
1. **技术准备**:
   - [ ] 申请 OpenAI API Key
   - [ ] 配置 MongoDB Atlas(或本地 MongoDB)
   - [ ] 配置 Redis(云服务或本地)
   - [ ] 申请 Pinecone/Chroma 账号(向量数据库)
   - [ ] 配置 AWS S3/阿里云 OSS(文件存储)
   - [ ] 申请 APNs 证书(iOS 推送)

2. **组建团队**:
   - iOS 开发工程师 1 人(SwiftUI 经验)
   - 后端开发工程师 1-2 人(Node.js + MongoDB 经验)
   - AI/ML 工程师 1 人(LangChain + RAG 经验)
   - UI/UX 设计师 1 人(兼职,已有 Figma 设计)
   - 可选: FIRE 领域专家(顾问)

3. **初始化项目**:
   - [ ] 创建 Git 仓库
   - [ ] 初始化前端项目(SwiftUI)
   - [ ] 初始化后端项目(Node.js + Express)
   - [ ] 初始化 AI 服务(Python + LangChain)
   - [ ] 配置 CI/CD 流程

4. **准备 FIRE 知识库**:
   - [ ] 收集 FIRE 相关文档:
     * "Your Money or Your Life" 核心内容
     * "The Simple Path to Wealth" 摘要
     * Mr. Money Mustache 精选文章
     * Trinity Study 论文
     * 4% 规则详解
     * 各类 FIRE 路径介绍
   - [ ] 整理成结构化文档(Markdown/PDF)
   - [ ] 准备向量化入库

5. **环境配置**:
   ```bash
   # 后端环境变量(.env)
   MONGODB_URI=mongodb://localhost:27017/fire_app
   REDIS_URL=redis://localhost:6379
   OPENAI_API_KEY=sk-...
   PINECONE_API_KEY=...
   AWS_S3_BUCKET=fire-app-files
   JWT_SECRET=...
   
   # AI 服务环境变量
   OPENAI_API_KEY=sk-...
   PINECONE_API_KEY=...
   PINECONE_INDEX_NAME=fire-knowledge
   ```

### 第一周任务分配:

**iOS 开发**:
- [ ] 搭建 SwiftUI 项目结构(MVVM)
- [ ] 实现设计系统(颜色、字体、组件)
- [ ] 创建底部导航栏框架
- [ ] 配置网络请求层

**后端开发**:
- [ ] 搭建 Express 项目
- [ ] 配置 MongoDB 连接和 Schema
- [ ] 实现用户认证(JWT)
- [ ] 创建基础 API 端点
- [ ] 配置 WebSocket

**AI/ML 工程师**:
- [ ] 搭建 LangChain 环境
- [ ] 配置 OpenAI API
- [ ] 初始化 Pinecone 向量数据库
- [ ] 准备 FIRE 知识库向量化脚本
- [ ] 实现基础对话流程

### 进度追踪:
- 每周举行 2 次站会(周一、周四)
- 使用项目管理工具(Jira/Trello/Linear)
- 每两周进行 Sprint Review
- 保持文档更新(技术文档、API 文档)

### 里程碑时间表:
| 里程碑 | 时间 | 目标 |
|--------|------|------|
| M1: 项目搭建完成 | Week 1 | 开发环境就绪,项目框架搭建完毕 |
| M2: 基础聊天功能 | Week 3 | 用户可以与 FIRE AI 进行简单对话 |
| M3: 用户认证和档案 | Week 4 | 用户注册、登录、FIRE 档案管理 |
| M4: MVP 完成 | Week 6 | 第一期所有功能完成,开始内测 |
| M5: 高级功能 | Week 12 | 第二期完成,附件、报告、导航功能 |
| M6: 个性化推荐 | Week 18 | 第三期完成,数据分析和个性化 |
| M7: 生产就绪 | Week 24 | 第四期完成,性能优化,准备上线 |

---

## 附录

### A. FIRE 核心概念词汇表

| 概念 | 英文 | 解释 |
|------|------|------|
| FIRE | Financial Independence, Retire Early | 财务独立,提前退休 |
| FIRE 数字 | FIRE Number | 实现 FIRE 所需的总资产,通常为年支出 × 25 |
| 4% 规则 | 4% Rule | 每年提取投资组合的 4%,可维持 30 年以上 |
| 储蓄率 | Savings Rate | 储蓄金额占收入的百分比 |
| Coast FIRE | Coast FIRE | 已有足够本金让复利增长,无需再额外储蓄 |
| Lean FIRE | Lean FIRE | 极简生活方式,低支出实现 FIRE |
| Fat FIRE | Fat FIRE | 高质量退休生活,需要更大的资产规模 |
| Barista FIRE | Barista FIRE | 半退休状态,兼职工作覆盖基本开支 |
| Trinity Study | Trinity Study | 1998 年的研究,4% 规则的理论基础 |
| 安全提取率 | Safe Withdrawal Rate (SWR) | 可持续提取的年化比例,通常为 3.5%-4% |
| 被动收入 | Passive Income | 无需主动工作即可获得的收入 |
| 财务独立 | Financial Independence (FI) | 被动收入覆盖生活开支,不必为钱工作 |
| 指数基金 | Index Fund | 追踪市场指数的被动投资基金 |
| 资产配置 | Asset Allocation | 投资组合中不同资产类型的比例 |
| 再平衡 | Rebalancing | 调整投资组合回到目标配置 |
| 复利 | Compound Interest | 利息产生的利息,长期增长的核心 |
| 通货膨胀 | Inflation | 货币购买力下降,通常为年 2-3% |
| 税优账户 | Tax-Advantaged Account | 401k, IRA, Roth IRA 等延税或免税账户 |
| 应急基金 | Emergency Fund | 3-6 个月生活费的现金储备 |
| 净资产 | Net Worth | 总资产 - 总负债 |

### B. 储蓄率与 FIRE 年限对照表

| 储蓄率 | 工作年限 | 说明 |
|--------|----------|------|
| 10% | 51 年 | 传统退休路径 |
| 15% | 43 年 | 略高于平均水平 |
| 20% | 37 年 | 良好的储蓄习惯 |
| 25% | 32 年 | FIRE 入门级别 |
| 30% | 28 年 | 认真的 FIRE 追求者 |
| 35% | 25 年 | 较快的 FIRE 进度 |
| 40% | 22 年 | 激进的 FIRE 路径 |
| 45% | 19 年 | 非常高的纪律性 |
| 50% | 17 年 | FIRE 社区常见目标 |
| 55% | 14.5 年 | 极高的储蓄率 |
| 60% | 12.5 年 | 需要大幅削减支出 |
| 65% | 10.5 年 | 精简生活 |
| 70% | 8.5 年 | Lean FIRE 领域 |
| 75% | 7 年 | 极端储蓄 |
| 80% | 5.5 年 | 接近理论极限 |

*注: 假设 5% 投资回报率,3% 通胀率*

### C. FIRE 类型详细对比

| FIRE 类型 | 资产需求 | 年支出 | 生活方式 | 适合人群 |
|-----------|----------|--------|----------|----------|
| **Lean FIRE** | $500K-$750K | $20K-$30K | 极简主义,低消费 | 追求自由胜过物质 |
| **Coast FIRE** | 变化 | 工作覆盖支出 | 无压力工作,本金增长 | 30 岁左右已有基础 |
| **Barista FIRE** | $300K-$600K | $30K-$40K | 兼职 + 投资收入 | 喜欢半退休状态 |
| **Regular FIRE** | $750K-$1.5M | $30K-$60K | 中等舒适生活 | 大多数 FIRE 追求者 |
| **Fat FIRE** | $2.5M+ | $100K+ | 高质量退休生活 | 高收入人士 |
| **Chubby FIRE** | $1.5M-$2.5M | $60K-$100K | 舒适但不奢侈 | 中高收入家庭 |

### D. 推荐的 FIRE 资源

**书籍:**
1. "Your Money or Your Life" - Vicki Robin
2. "The Simple Path to Wealth" - JL Collins
3. "Early Retirement Extreme" - Jacob Lund Fisker
4. "Financial Freedom" - Grant Sabatier

**博客/网站:**
1. Mr. Money Mustache (mrmoneymustache.com)
2. Financial Samurai
3. Physician on FIRE
4. Choose FI
5. Bogleheads Forum

**播客:**
1. Choose FI Podcast
2. BiggerPockets Money
3. Afford Anything
4. The Mad Fientist

**Reddit 社区:**
- r/financialindependence
- r/leanfire
- r/fatFIRE
- r/coastFIRE

### E. UI 设计规范(基于 Figma)

#### 颜色系统:
```swift
// Colors.swift
extension Color {
    // Primary
    static let fireGreen = Color(hex: "#13EC5B")
    static let fireGreenLight = Color(hex: "#13EC5B").opacity(0.2)
    static let fireGreenBorder = Color(hex: "#13EC5B").opacity(0.3)
    
    // Background
    static let backgroundDark = Color(hex: "#102216")
    static let backgroundCard = Color(hex: "#23482F")
    static let backgroundInput = Color(hex: "#1A2E21")
    
    // Border
    static let borderPrimary = Color(hex: "#1E293B")
    static let borderLight = Color.white.opacity(0.05)
    static let borderGlow = Color(hex: "#13EC5B").opacity(0.1)
    
    // Text
    static let textPrimary = Color(hex: "#F1F5F9")
    static let textSecondary = Color(hex: "#64748B")
    static let textMuted = Color(hex: "#94A3B8")
    
    // Status
    static let statusOnline = Color(hex: "#13EC5B")
    static let statusOffline = Color(hex: "#64748B")
}
```

#### 字体系统:
```swift
// Typography.swift
extension Font {
    // Heading
    static let fireHeading1 = Font.custom("Manrope-Bold", size: 14).weight(.bold)
    
    // Body
    static let fireBody = Font.custom("Manrope-Regular", size: 14)
    static let fireBodyMedium = Font.custom("Manrope-Medium", size: 14).weight(.medium)
    static let fireBodySemiBold = Font.custom("Manrope-SemiBold", size: 14).weight(.semibold)
    
    // Caption
    static let fireCaption = Font.custom("Manrope-Bold", size: 11).weight(.bold)
    static let fireCaptionSmall = Font.custom("Manrope-Bold", size: 10).weight(.bold)
}
```

#### 间距系统:
```swift
// Spacing.swift
struct FIRESpacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
    static let xl: CGFloat = 24
    static let xxl: CGFloat = 32
}
```

#### 圆角系统:
```swift
// Corner Radius.swift
struct FIRERadius {
    static let small: CGFloat = 8
    static let medium: CGFloat = 12
    static let large: CGFloat = 16
    static let pill: CGFloat = 9999
}
```

#### 阴影系统:
```swift
// Shadow.swift
extension View {
    func fireGlow() -> some View {
        self.shadow(
            color: Color(hex: "#13EC5B").opacity(0.2),
            radius: 15,
            x: 0,
            y: 0
        )
    }
    
    func fireButtonShadow() -> some View {
        self.shadow(
            color: Color(hex: "#13EC5B").opacity(0.2),
            radius: 10,
            x: 0,
            y: 10
        )
    }
}
```

### F. API 端点快速参考

**认证 API:**
- `POST /api/auth/register` - 用户注册
- `POST /api/auth/login` - 用户登录
- `POST /api/auth/logout` - 用户登出
- `GET /api/auth/me` - 获取当前用户

**FIRE API:**
- `GET /api/fire/profile` - 获取 FIRE 档案
- `POST /api/fire/profile` - 更新 FIRE 档案
- `GET /api/fire/progress` - 获取 FIRE 进度
- `GET /api/fire/milestones` - 获取里程碑
- `POST /api/fire/calculate` - FIRE 计算器

**对话 API:**
- `GET /api/conversations` - 获取会话列表
- `POST /api/conversations` - 创建新会话
- `GET /api/conversations/:id/messages` - 获取消息
- `POST /api/conversations/:id/messages` - 发送消息
- `WS /ws` - WebSocket 连接

**财务数据 API:**
- `POST /api/net-worth/snapshot` - 记录净资产
- `GET /api/net-worth/history` - 获取历史数据
- `POST /api/income-streams` - 添加收入来源
- `POST /api/expenses` - 记录支出
- `GET /api/analytics/overview` - 综合分析

**报告 API:**
- `POST /api/reports/generate` - 生成 FIRE 报告
- `GET /api/reports/:id` - 获取报告
- `GET /api/reports` - 获取报告列表

---

**文档版本**: v2.0 - FIRE 专版  
**最后更新**: 2026-03-10  
**产品定位**: FIRE (Financial Independence, Retire Early) AI 顾问应用  
**技术栈**: Swift + Node.js + MongoDB + LangChain  
**负责人**: [待定]  
**审批人**: [待定]  

---

**变更日志:**
- v2.0 (2026-03-10): 
  * 更新产品定位为 FIRE 应用
  * 数据库从 PostgreSQL 改为 MongoDB
  * 增加 FIRE 专属功能和指标
  * 完善知识库内容和 AI Agent 设计
- v1.0 (2026-03-10): 初始版本(养老金应用)
