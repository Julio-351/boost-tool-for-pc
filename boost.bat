@echo off
chcp 65001 >nul
echo Applying safe cleanup actions...
:: Clear temp folders
echo Clearing temp folders...
rd /s /q "%temp%" 2>nul
md "%temp%" 2>nul

rd /s /q "%windir%\Temp" 2>nul
md "%windir%\Temp" 2>nul

:: Empty recycle bin (using PowerShell)
powershell -NoProfile -Command "([void][Windows.Forms.SendKeys])" 2>nul
powershell -NoProfile -Command "Clear-RecycleBin -Force" 2>nul

:: Flush DNS
ipconfig /flushdns >nul

:: Stop common heavy services temporarily (non-destructive): Superfetch/SysMain, Windows Search
echo Stopping some optional services temporarily...
sc stop SysMain >nul 2>&1
sc stop WSearch >nul 2>&1

echo Done. It is recommended to reboot the PC after running this script.
pause
