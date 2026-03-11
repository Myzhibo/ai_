# 启动后端
NODE_ENV=development MONGODB_URI="mongodb://127.0.0.1:27017/fire_app" node src/server.js

# 启动前端
open /Users/doubo/Desktop/gate/ai_/frontend/FIREAdvisor.xcodeproj

# xcode项目
1. Create a new Xcode project
2. 在窗口上方的标签里点 iOS（现在在 Multiplatform，换到 iOS）。
3. 在下面的 Application 区域里，点第一个图标 App。右下角点 Next。
4. 
按下面一行一行填：

Product Name：输入 FIREAdvisor
Team：保持 Add account…（不管它也行）
Organization Identifier：可以用 com.doubo（随便，但别有空格）
Interface：保持 SwiftUI
Language：保持 Swift
Use Core Data：不要勾
Include Tests：可以先保留勾选
然后点右下角的 Next。
5. 进入项目
6. 在左边导航栏里，展开蓝色 FIREAdvisor 下的第一个同名文件夹 FIREAdvisor。
删掉FIREAdvisorApp.swift 、 ContentView.swift
7. finder打开选中：复制
ContentView.swift
FIREAdvisorApp.swift
DesignSystem 文件夹
Models 文件夹
Services 文件夹
ViewModels 文件夹
Views 文件夹
8. 打开xcode finder 贴进去
9. 回到xcode，FIREAdvisor 上 右键 → 选 Add Files to "FIREAdvisor"...。
10. 把刚才贴进去的那些文件add即可。
11. 运行: 点开 FIREAdvisorApp.swift，