@echo off
setlocal enabledelayedexpansion

set "CURRENT_VERSION=1.2.2"
set "MIN_MC_VERSION=26.1"
set "MAX_MC_VERSION=26.2"
set "FILE_NAME=BendersMC_Tweaks-%CURRENT_VERSION%-%MIN_MC_VERSION%_%MAX_MC_VERSION%.zip"
set "FILE_DESTINATION=zipped_packs"

echo Zipping BendersMC Tweaks v%CURRENT_VERSION% for Minecraft %MIN_MC_VERSION%-%MAX_MC_VERSION%...

where 7z >nul 2>nul
if %errorlevel% equ 0 (
    7z a -tzip -mx=9 "%FILE_NAME%" assets\ LICENSE NOTICE.md pack.mcmeta pack.png >nul
) else (
    powershell -NoProfile -Command "Compress-Archive -Path 'assets','LICENSE','NOTICE.md','pack.mcmeta','pack.png' -DestinationPath '%FILE_NAME%' -Force"
)

if %errorlevel% neq 0 (
    echo Zipping failed...
    echo Re-clone this repository and re-run this script...
    exit /b 1
)

if not exist "%FILE_DESTINATION%" mkdir "%FILE_DESTINATION%"

move /y "%FILE_NAME%" "%FILE_DESTINATION%\" >nul
if %errorlevel% neq 0 (
    echo Moving file to %FILE_DESTINATION% failed...
    exit /b 1
) else (
    echo BendersMC Tweaks was zipped and moved into the %FILE_DESTINATION% folder!
)

endlocal