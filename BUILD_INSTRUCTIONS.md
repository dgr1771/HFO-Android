# HFO-Android APK 构建说明

## 方法一：使用 Android Studio（推荐）

### 步骤：

1. **安装 Android Studio**
   - 下载：https://developer.android.com/studio
   - 安装时确保安装 Android SDK

2. **打开项目**
   ```
   文件 → 打开 → 选择 HFO-Android 文件夹
   ```

3. **同步 Gradle**
   - 点击 "Sync Now" 或 "Sync Project with Gradle Files"

4. **构建 APK**
   - 菜单：Build → Build Bundle(s) / APK(s) → Build APK(s)
   - 等待构建完成
   - 点击通知中的 "locate" 查看APK位置

5. **APK 位置**
   ```
   app/build/outputs/apk/debug/app-debug.apk
   ```

---

## 方法二：使用命令行（Windows）

### 前置条件：

1. **安装 JDK 17 或更高版本**
   - 推荐：Eclipse Temurin (AdoptOpenJDK)
   - 下载：https://adoptium.net/
   - 安装后配置 JAVA_HOME 环境变量

2. **配置环境变量**
   ```
   JAVA_HOME = C:\Program Files\Eclipse Adoptium\jdk-17.x.x
   Path 添加：%JAVA_HOME%\bin
   ```

3. **验证安装**
   ```cmd
   java -version
   ```

### 构建步骤：

在 `HFO-Android` 目录下打开命令提示符，运行：

```cmd
build-apk.bat
```

或手动执行：

```cmd
gradlew assembleDebug
```

---

## 方法三：在线构建（无需安装）

### 使用 GitHub Actions（自动）

由于项目已在 GitHub 上，可以添加 GitHub Actions 工作流自动构建：

1. 访问：https://github.com/dgr1771/HFO-Android

2. 我可以帮你配置自动构建，每次推送代码时自动生成 APK

---

## 方法四：使用我的云端构建

如果你无法在本地构建，我可以帮你设置云端构建。

---

## 安装 APK 到手机

### 方法 1：通过 USB
```cmd
adb install app\build\outputs\apk\debug\app-debug.apk
```

### 方法 2：直接传输
1. 将 APK 文件复制到手机
2. 在手机上点击 APK 文件
3. 允许安装未知来源应用
4. 安装

---

## 常见问题

### Q1: "Unsupported class file major version 61"
**解决**：安装 JDK 17，不要使用 JDK 21 或更高版本

### Q2: "SDK not found"
**解决**：
- 安装 Android Studio
- 或设置 ANDROID_HOME 环境变量

### Q3: 构建很慢
**说明**：首次构建会下载依赖（约 200MB），后续构建会快很多

### Q4: 没有电脑
**解决**：我可以配置 GitHub Actions 自动构建，你直接下载 APK

---

## 需要帮助？

选择你需要的方式：
1. 配置 GitHub Actions 自动构建（推荐，最简单）
2. 提供更详细的本地构建指导
3. 使用云端构建服务
