# Windows Installer Guide

## 🚀 Quick Start

Build a professional Windows installer for Bad-Antics Device Manager in 3 easy steps:

### Step 1: Install Inno Setup (One-Time Setup)

Download and install Inno Setup 6 from: **https://jrsoftware.org/isdl.php**

This creates a professional Windows installer with hacker-themed branding.

### Step 2: Build the Installer

```bash
build_installer.bat
```

The script will:
1. ✓ Check Python and install PyInstaller
2. ✓ Create application icon
3. ✓ Build the executable
4. ✓ Create a Windows installer
5. ✓ Verify all files

### Step 3: Distribute

Share `dist\Bad-Antics_Device_Manager_Setup.exe` with users!

---

## 📦 What Gets Created

### dist\Bad-Antics_Device_Manager.exe
- **Type**: Standalone executable (portable)
- **Size**: ~150-200 MB
- **Usage**: Run directly without installation
- **Features**: No Python needed, works offline

### dist\Bad-Antics_Device_Manager_Setup.exe
- **Type**: Windows installer (.msi-style)
- **Size**: ~60-80 MB (compressed)
- **Installation**: Professional installer wizard
- **Features**:
  - Desktop shortcuts
  - Start Menu integration
  - File associations
  - Uninstall support
  - Installation logging

---

## 🎨 Customizing the Installer

### Change Installer Information

Edit `Bad-Antics_Device_Manager.iss`:

```ini
#define MyAppName "Bad-Antics Device Manager"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "Bad-Antics"
```

### Add Custom Branding Graphics

Create or download these images and save to the same folder as the script:

1. **installer_banner.bmp** (164×314 pixels)
   - Displayed on the left side of installer
   - Hacker theme: dark background with green/cyan accents

2. **installer_icon.bmp** (55×57 pixels)
   - Small icon for installer steps
   - Simple, minimal design

**Hacker Theme Colors:**
- Primary: `#00ff00` (Matrix green)
- Secondary: `#0a0a0a` (Deep black)
- Accent: `#00ff00` (Bright green)
- Text: `#00ff00` on `#000000`

### Example Python Script to Create Custom Graphics

```python
from PIL import Image, ImageDraw, ImageFont

# Create banner (164x314)
banner = Image.new('RGB', (164, 314), color='#0a0a0a')
draw = ImageDraw.Draw(banner)

# Add green lines for hacker style
for i in range(0, 164, 10):
    draw.line([(i, 0), (i, 314)], fill='#003300', width=1)

# Add text or patterns
# ... customize as needed ...

banner.save('installer_banner.bmp')

# Create icon (55x57)
icon = Image.new('RGB', (55, 57), color='#0a0a0a')
draw = ImageDraw.Draw(icon)
# ... customize ...
icon.save('installer_icon.bmp')
```

---

## 🔧 Build Scripts Explained

### build_exe_advanced.py

Advanced PyInstaller wrapper that:
- Creates a professional icon
- Bundles all dependencies
- Generates a single executable
- Cleans up build artifacts
- Verifies the output

**Usage:**
```bash
python build_exe_advanced.py
```

### build_installer.bat

Complete automation script that:
1. Checks Python installation
2. Installs PyInstaller and Pillow
3. Runs the advanced build script
4. Locates Inno Setup
5. Creates the installer
6. Verifies all outputs

**Usage:**
```bash
build_installer.bat
```

---

## 🔒 Installer Features

### Security
- ✓ Signed executable recommendations
- ✓ Installation logging for audit trails
- ✓ Registry cleanup on uninstall
- ✓ Safe extraction to protected directories

### User Experience
- ✓ Professional installer wizard
- ✓ Welcome screen with system requirements
- ✓ Installation progress bar
- ✓ Desktop and Start Menu shortcuts
- ✓ Optional Quick Launch icon
- ✓ File associations (.badc files)
- ✓ Post-install launch option

### Uninstall
- ✓ Complete removal of files
- ✓ Shortcut cleanup
- ✓ Registry cleanup
- ✓ Optional log file preservation

---

## 📋 Installer Configuration Details

### Directories
```
Default: C:\Program Files\Bad-Antics\Device Manager\
Portable: Run directly from any location
```

### Start Menu
```
Start Menu\
└── Bad-Antics\
    ├── Bad-Antics Device Manager (main app)
    ├── Documentation (README.md)
    ├── License (LICENSE file)
    └── Uninstall
```

### File Types
- `.badc` files associated with Device Manager (optional)

### Registry Keys
```
HKEY_LOCAL_MACHINE\SOFTWARE\Bad-Antics\Device Manager
```

---

## 🐛 Troubleshooting

### Issue: Inno Setup Not Found

**Solution:**
1. Download from https://jrsoftware.org/isdl.php
2. Install to default location
3. Ensure you install Inno Setup 6 (not 5)

### Issue: Python Not Found

**Solution:**
1. Install Python 3.10+ from https://www.python.org
2. Check "Add Python to PATH" during installation
3. Restart command prompt

### Issue: Build Takes Too Long

**Expected time:** 3-5 minutes for first build
- PyInstaller bundles all dependencies
- Subsequent builds may be faster if cached

### Issue: Installer .exe is Large

**Normal size:** 60-80 MB
- Includes Python runtime
- Includes all PyQt6 libraries
- Includes dependencies

**Reduce size:**
- Use UPX compression (if willing to sacrifice compatibility)
- Split into portable + installer versions

### Issue: Application Won't Launch from Installer

**Troubleshooting:**
1. Check installation log: `%APPDATA%\Bad-Antics\DeviceManager_Setup.log`
2. Try running as Administrator
3. Check Windows Event Viewer for errors
4. Verify USB drivers are installed

---

## 📊 Distribution Options

### Option 1: Installer Only (Recommended for Users)
- **File**: `Bad-Antics_Device_Manager_Setup.exe`
- **Pros**: Professional, integrates with Windows, easy uninstall
- **Cons**: Larger file size, requires admin rights

### Option 2: Portable Executable (Recommended for Developers)
- **File**: `Bad-Antics_Device_Manager.exe`
- **Pros**: No installation needed, runs from USB, faster launch
- **Cons**: Doesn't integrate with Windows, leaves files on disk

### Option 3: Both (Flexible for All Users)
- Include both files in release
- Let users choose their preferred method

---

## 🎯 Release Checklist

Before releasing your installer:

- [ ] Test on clean Windows 10 installation
- [ ] Test on clean Windows 11 installation
- [ ] Verify all shortcuts work
- [ ] Test uninstall completely removes files
- [ ] Verify no errors in installation log
- [ ] Test running with admin privileges
- [ ] Test running without admin privileges
- [ ] Verify Flipper connection works post-install
- [ ] Verify Pineapple connection works post-install

---

## 🚀 Advanced Customization

### Create Custom Installer Wizard

Modify these sections in `.iss` file:

```ini
[Setup]
WizardImageFile=your_custom_banner.bmp
WizardSmallImageFile=your_custom_icon.bmp

[Code]
procedure CurPageChanged(CurPageID: Integer);
begin
  if CurPageID = wpWelcome then
  begin
    WizardForm.WelcomeLabel2.Caption := 'Your custom welcome message here';
  end;
end;
```

### Add License Agreement Screen

```ini
[Setup]
LicenseFile=LICENSE
LicenseAcceptance=yes
```

### Add Installation Components

```ini
[Components]
Name: "core"; Description: "Core Application"; Types: full compact custom; Flags: fixed
Name: "docs"; Description: "Documentation"; Types: full
Name: "source"; Description: "Source Code"; Types: full
```

---

## 📚 Resources

- **Inno Setup Documentation**: https://jrsoftware.org/isinfo.php
- **PyInstaller Documentation**: https://pyinstaller.org
- **Hacker Aesthetics Guide**: Green on black, circuit patterns, minimal text

---

## 💡 Pro Tips

1. **Icon Creation**: Use `build_exe_advanced.py` to auto-generate hacker-themed icons
2. **Testing**: Always test installer on a fresh Windows VM
3. **Signing**: Add code signing certificate for trust warnings
4. **Updates**: Inno Setup supports auto-updates
5. **Localization**: Inno Setup supports multiple languages

---

## 📝 Example Release

```
v1.0.0 - Initial Release

📦 Downloads:
  • Bad-Antics_Device_Manager_Setup.exe (Recommended - 72 MB)
  • Bad-Antics_Device_Manager.exe (Portable - 168 MB)

📋 System Requirements:
  • Windows 10 or later
  • 500 MB free disk space
  • USB connection for Flipper Zero (optional)

✨ Features:
  • Flipper Zero management and monitoring
  • WiFi Pineapple discovery and control
  • Sub-GHz transmission support
  • Real-time device status
  • Professional Windows installer

🔗 GitHub: https://github.com/bad-antics/pineflip
```

---

Made with ❤️ by Bad-Antics
