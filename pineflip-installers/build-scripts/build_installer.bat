@echo off
REM Bad-Antics Device Manager - Complete Build and Installer Script
REM Hacker-Styled Windows Installer Builder

setlocal enabledelayedexpansion

echo.
echo ████████████████████████████████████████████████████████████
echo ██  Bad-Antics Device Manager - Build and Installer  ██
echo ████████████████████████████████████████████████████████████
echo.

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo [!] Python 3 not found in PATH
    echo [*] Please install Python 3.10+ from https://www.python.org
    echo [*] Make sure to check "Add Python to PATH" during installation
    pause
    exit /b 1
)

echo [+] Python detected: 
python --version

REM Step 1: Install/Update PyInstaller
echo.
echo [*] Step 1: Installing PyInstaller...
pip install --upgrade PyInstaller >nul 2>&1
if errorlevel 1 (
    echo [!] Failed to install PyInstaller
    pause
    exit /b 1
)
echo [+] PyInstaller ready

REM Step 2: Install Pillow for icon creation
echo.
echo [*] Step 2: Installing Pillow for icon generation...
pip install Pillow >nul 2>&1
if errorlevel 1 (
    echo [!] Failed to install Pillow (optional, continuing...)
)
echo [+] Pillow ready

REM Step 3: Build the executable
echo.
echo [*] Step 3: Building executable...
echo [*] This may take 2-5 minutes, please wait...
python build_exe_advanced.py
if errorlevel 1 (
    echo [!] Build failed!
    pause
    exit /b 1
)
echo [+] Executable built successfully

REM Step 4: Check for Inno Setup
echo.
echo [*] Step 4: Checking for Inno Setup...
if exist "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" (
    set ISCC_PATH=C:\Program Files (x86)\Inno Setup 6\ISCC.exe
) else if exist "C:\Program Files\Inno Setup 6\ISCC.exe" (
    set ISCC_PATH=C:\Program Files\Inno Setup 6\ISCC.exe
) else (
    echo [!] Inno Setup 6 not found
    echo [*] Download from: https://jrsoftware.org/isdl.php
    echo [*] Install and run this script again
    pause
    exit /b 1
)
echo [+] Inno Setup found: !ISCC_PATH!

REM Step 5: Create installer graphics (placeholder)
echo.
echo [*] Step 5: Preparing installer graphics...
if not exist "installer_banner.bmp" (
    echo [*] Note: Custom installer graphics not found
    echo [*] Using default Inno Setup graphics
)

REM Step 6: Build the installer
echo.
echo [*] Step 6: Building Windows installer...
"!ISCC_PATH!" /Q "Bad-Antics_Device_Manager.iss"
if errorlevel 1 (
    echo [!] Installer creation failed!
    pause
    exit /b 1
)
echo [+] Installer created successfully

REM Step 7: Verification
echo.
echo [*] Step 7: Verifying build artifacts...
if exist "dist\Bad-Antics_Device_Manager.exe" (
    for /f %%A in ('cd') do set "CURRENT_DIR=%%A"
    echo [+] Executable: dist\Bad-Antics_Device_Manager.exe
    dir "dist\Bad-Antics_Device_Manager.exe" | find ".exe"
)
if exist "dist\Bad-Antics_Device_Manager_Setup.exe" (
    echo [+] Installer: dist\Bad-Antics_Device_Manager_Setup.exe
    dir "dist\Bad-Antics_Device_Manager_Setup.exe" | find "Setup"
)

REM Success message
echo.
echo ████████████████████████████████████████████████████████████
echo ██  ✓ BUILD COMPLETE!                                  ██
echo ████████████████████████████████████████████████████████████
echo.
echo [+] Created Files:
echo     • dist\Bad-Antics_Device_Manager.exe (Portable executable)
echo     • dist\Bad-Antics_Device_Manager_Setup.exe (Installer)
echo.
echo [*] Next Steps:
echo     1. Distribute the Setup.exe to users
echo     2. Users can run the installer to install the application
echo     3. The installer creates Start Menu shortcuts and desktop icons
echo.
echo [*] For custom installer branding:
echo     • Edit: Bad-Antics_Device_Manager.iss
echo     • Replace installer_banner.bmp and installer_icon.bmp with custom images
echo     • Run this script again to rebuild
echo.
echo [*] Installer features:
echo     ✓ Professional hacker-themed installer
echo     ✓ Desktop shortcuts
echo     ✓ Start Menu integration
echo     ✓ File association support
echo     ✓ Automatic file associations
echo     ✓ Installation logging
echo     ✓ Clean uninstall with registry cleanup
echo.
pause
