@echo off
title Creating shortcut
chcp 65001 > nul

echo ===================================================
echo   Creating shortcut on desktop...
echo ===================================================

set "GAME_EXE=%~dp0dist\Core.exe"
set "WORKING_DIR=%~dp0dist"
set "ICON_FILE=%~dp0game.ico"
set "SHORTCUT_NAME=Stickman Parkour.lnk"
set "DESKTOP_DIR=%USERPROFILE%\Desktop"

:: 2. Core.exe va Icon fayllari bor-yo'qligini tekshirish
if not exist "%GAME_EXE%" (
    echo [Error]: Core.exe file not found. Please check dist/Core.exe file
    pause
    exit /b
)

if not exist "%ICON_FILE%" (
    echo [WARN]: game.ico file not found. Please check icon file
)

set "VBS_SCRIPT=%TEMP%\create_shortcut.vbs"

echo Set oWS = WScript.CreateObject("WScript.Shell") > "%VBS_SCRIPT%"
echo sLinkFile = "%DESKTOP_DIR%\%SHORTCUT_NAME%" >> "%VBS_SCRIPT%"
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%VBS_SCRIPT%"
echo oLink.TargetPath = "%GAME_EXE%" >> "%VBS_SCRIPT%"
echo oLink.WorkingDirectory = "%WORKING_DIR%" >> "%VBS_SCRIPT%"
echo oLink.Description = "Stickman Parkour" >> "%VBS_SCRIPT%"

if exist "%ICON_FILE%" (
    echo oLink.IconLocation = "%ICON_FILE%" >> "%VBS_SCRIPT%"
)

echo oLink.Save >> "%VBS_SCRIPT%"

cscript //nologo "%VBS_SCRIPT%"
del "%VBS_SCRIPT%"

echo.
echo [ OK ]: Game link has sucsess fully created. You can play it now!
echo.
pause