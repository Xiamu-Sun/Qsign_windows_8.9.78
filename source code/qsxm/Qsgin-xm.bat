@echo off

cd /d %~dp0
set "api_cmd=bin\unidbg-fetch-qsign --basePath=txlib\8.9.78"
set "api_title=Qsign-Xm"
set "api_window_cmd=title %api_title% && %api_cmd%"

:: 启用延迟变量扩展
setlocal EnableDelayedExpansion

:: 读取 qsadr.txt 的地址（本地签名API地址）
set "local_api_address="
if exist qsadr.txt (
    for /f "delims=" %%a in (qsadr.txt) do set "local_api_address=%%a"
    if not defined local_api_address (
        echo 警告: qsadr.txt 文件为空。
    ) else (
        echo 本地签名API地址:
        echo !local_api_address!
    )
) else (
    echo 警告: 未找到 qsadr.txt 文件，无法读取本地签名API地址。
)

:: 读取 qsadr2.txt 的地址（外网签名API地址）
set "public_api_address="
if exist qsadr2.txt (
    for /f "delims=" %%b in (qsadr2.txt) do set "public_api_address=%%b"
    if not defined public_api_address (
        echo 警告: qsadr2.txt 文件为空。
    ) else (
        echo 外网签名API地址:
        echo !public_api_address!
    )
) else (
    echo 警告: 未找到 qsadr2.txt 文件，无法读取外网签名API地址。
)

:restart_api_loop
tasklist /v | findstr /i "%api_title%" >nul
if errorlevel 1 (
    echo 未检测到 '%api_title%' 的API窗口。正在尝试启动API...
    start "" cmd /c "%api_window_cmd%"
    echo API启动命令已发送。将在15秒后进行下一次检查。
)

timeout /t 15 >nul
goto restart_api_loop