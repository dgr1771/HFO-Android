# 如何添加 GitHub Actions 自动构建

由于API限制，需要手动在GitHub网页上添加工作流文件。请按照以下步骤操作：

## 📝 步骤（2分钟完成）

### 1. 访问你的GitHub仓库
打开：https://github.com/dgr1771/HFO-Android

### 2. 创建 .github/workflows 目录
1. 点击仓库中的 **"Add file"** → **"Create new file"**
2. 在文件名输入框中输入：`.github/workflows/build.yml`
   （会自动创建目录结构）

### 3. 复制以下内容到文件

```yaml
name: Build Android APK

on:
  push:
    branches: [ main, master ]
  pull_request:
    branches: [ main, master ]
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v4

    - name: Set up JDK 17
      uses: actions/setup-java@v4
      with:
        java-version: '17'
        distribution: 'temurin'

    - name: Grant execute permission for gradlew
      run: chmod +x gradlew

    - name: Build Debug APK
      run: ./gradlew assembleDebug --no-daemon

    - name: Upload Debug APK
      uses: actions/upload-artifact@v4
      with:
        name: HFO-Debug-APK
        path: app/build/outputs/apk/debug/app-debug.apk
        retention-days: 90

    - name: Build Release APK
      run: ./gradlew assembleRelease --no-daemon

    - name: Upload Release APK
      uses: actions/upload-artifact@v4
      with:
        name: HFO-Release-APK
        path: app/build/outputs/apk/release/app-release.apk
        retention-days: 90

    - name: Get APK size
      run: |
        echo "### 📦 APK 构建完成" >> $GITHUB_STEP_SUMMARY
        echo "" >> $GITHUB_STEP_SUMMARY
        echo "**Debug APK:**" >> $GITHUB_STEP_SUMMARY
        ls -lh app/build/outputs/apk/debug/app-debug.apk | awk '{print "`" $5 "`"}' >> $GITHUB_STEP_SUMMARY
        echo "" >> $GITHUB_STEP_SUMMARY
        echo "**Release APK:**" >> $GITHUB_STEP_SUMMARY
        ls -lh app/build/outputs/apk/release/app-release.apk | awk '{print "`" $5 "`"}' >> $GITHUB_STEP_SUMMARY
        echo "" >> $GITHUB_STEP_SUMMARY
        echo "📥 下载 APK: 点击下方的 Artifacts" >> $GITHUB_STEP_SUMMARY
```

### 4. 提交文件
1. 滚动到页面底部
2. 在 "Commit new file" 处填写：
   - **Commit message**: `Add GitHub Actions workflow for automatic APK building`
3. 点击 **"Commit new file"** 按钮

### 5. 等待构建完成
1. 点击仓库顶部的 **"Actions"** 标签
2. 你会看到 "Build Android APK" 工作流正在运行
3. 等待约 3-5 分钟

### 6. 下载 APK
1. 构建完成后，点击进入该工作流
2. 滚动到页面底部的 **"Artifacts"** 区域
3. 下载：
   - **HFO-Debug-APK** - 测试版（可以直接安装）
   - **HFO-Release-APK** - 正式版（优化过，体积更小）

---

## ✅ 完成！

以后每次你推送代码到GitHub，都会自动构建新的APK！

### 本地文件已准备好
项目目录中已经有以下文件：
- `build-apk.bat` - Windows本地构建脚本
- `BUILD_INSTRUCTIONS.md` - 详细构建说明

需要帮助？查看 BUILD_INSTRUCTIONS.md
