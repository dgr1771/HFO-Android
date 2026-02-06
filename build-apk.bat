@echo off
REM ========================================
REM HFO-Android APK 构建脚本
REM 在 Windows 命令提示符中运行此脚本
REM ========================================

echo.
echo ========================================
echo   HFO-Android APK 构建工具
echo ========================================
echo.

REM 设置项目路径
set PROJECT_DIR=%~dp0
cd /d "%PROJECT_DIR%"

echo [1/4] 检查环境...
where java >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   [错误] 未找到 Java JDK
    echo.
    echo 请先安装 JDK 17 或更高版本：
    echo https://adoptium.net/  ^(推荐^)
    echo.
    pause
    exit /b 1
)
echo   [OK] Java 已安装

where gradlew >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo   [OK] 将使用 Gradle Wrapper
) else (
    echo   [OK] Gradle Wrapper 已存在
)

echo.
echo [2/4] 下载 Gradle Wrapper（如果需要）...
if not exist "gradlew" (
    echo 正在初始化 Gradle...
    gradle wrapper --gradle-version 8.5
)

echo.
echo [3/4] 构建 Debug APK...
echo 这可能需要几分钟，请耐心等待...
echo.

call gradlew assembleDebug

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo   [成功] APK 构建完成！
    echo ========================================
    echo.
    echo APK 文件位置：
    echo   %PROJECT_DIR%app\build\outputs\apk\debug\app-debug.apk
    echo.
    echo 文件大小：
    dir "%PROJECT_DIR%app\build\outputs\apk\debug\app-debug.apk" | find "app-debug.apk"
    echo.

    REM 打开输出目录
    explorer "%PROJECT_DIR%app\build\outputs\apk\debug\"

    echo.
    echo 现在可以在手机上安装 APK 文件了！
    echo.
) else (
    echo.
    echo ========================================
    echo   [失败] APK 构建失败
    echo ========================================
    echo.
    echo 可能的原因：
    echo 1. Java 版本不兼容（需要 JDK 17+）
    echo 2. Android SDK 未安装或路径未配置
    echo 3. 网络连接问题（下载依赖时）
    echo.
    echo 请检查错误信息并重试
    echo.
)

pause
