@echo off

cd /d %~dp0
set "api_cmd=bin\unidbg-fetch-qsign --basePath=txlib\8.9.78"
set "api_title=Qsign-Xm"
set "api_window_cmd=title %api_title% && %api_cmd%"

:: �����ӳٱ�����չ
setlocal EnableDelayedExpansion

:: ��ȡ qsadr.txt �ĵ�ַ������ǩ��API��ַ��
set "local_api_address="
if exist qsadr.txt (
    for /f "delims=" %%a in (qsadr.txt) do set "local_api_address=%%a"
    if not defined local_api_address (
        echo ����: qsadr.txt �ļ�Ϊ�ա�
    ) else (
        echo ����ǩ��API��ַ:
        echo !local_api_address!
    )
) else (
    echo ����: δ�ҵ� qsadr.txt �ļ����޷���ȡ����ǩ��API��ַ��
)

:: ��ȡ qsadr2.txt �ĵ�ַ������ǩ��API��ַ��
set "public_api_address="
if exist qsadr2.txt (
    for /f "delims=" %%b in (qsadr2.txt) do set "public_api_address=%%b"
    if not defined public_api_address (
        echo ����: qsadr2.txt �ļ�Ϊ�ա�
    ) else (
        echo ����ǩ��API��ַ:
        echo !public_api_address!
    )
) else (
    echo ����: δ�ҵ� qsadr2.txt �ļ����޷���ȡ����ǩ��API��ַ��
)

:restart_api_loop
tasklist /v | findstr /i "%api_title%" >nul
if errorlevel 1 (
    echo δ��⵽ '%api_title%' ��API���ڡ����ڳ�������API...
    start "" cmd /c "%api_window_cmd%"
    echo API���������ѷ��͡�����15��������һ�μ�顣
)

timeout /t 15 >nul
goto restart_api_loop