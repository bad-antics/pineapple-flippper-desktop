# 🔨 Bad-Antics Installer Build System

**One-Click Professional Windows Installer & Executable Builder**

```
📦 pineflip-installers/
├── build-scripts/          ← Build automation tools
│   ├── build_exe_advanced.py
│   ├── build_installer.bat
│   ├── BUILD_QUICK_REFERENCE.bat
│   └── Bad-Antics_Device_Manager.iss
│
└── documentation/          ← Complete guides
    ├── INSTALLER_GUIDE.md
    └── INSTALLER_BUILD_SUMMARY.md
```

---

## 🚀 Quick Start (2 minutes)

### Prerequisites (One-Time Setup)

1. **Python 3.10+** → https://www.python.org
2. **Inno Setup 6** → https://jrsoftware.org/isdl.php

### Build the Installer

```bash
cd build-scripts
build_installer.bat
```

**Output:** `dist\Bad-Antics_Device_Manager_Setup.exe` (Professional Windows installer)

---

## 📂 What's Here

### build-scripts/

**Automated builders for creating Windows installers and executables**

| File | Purpose |
|------|---------|
| `build_exe_advanced.py` | Enhanced PyInstaller with auto icon generation |
| `build_installer.bat` | **ONE-CLICK builder** - builds everything automatically |
| `BUILD_QUICK_REFERENCE.bat` | Quick help menu and reference |
| `Bad-Antics_Device_Manager.iss` | Inno Setup installer configuration |

### documentation/

**Complete guides for building, customizing, and distributing**

| File | Purpose |
|------|---------|
| `INSTALLER_BUILD_SUMMARY.md` | Quick start guide and overview |
| `INSTALLER_GUIDE.md` | Complete technical documentation |

---

## 🎯 Build Options

### Option 1: Full Release (Recommended)
```bash
cd build-scripts
build_installer.bat
```
Creates both:
- `dist\Bad-Antics_Device_Manager.exe` (portable, 150-200 MB)
- `dist\Bad-Antics_Device_Manager_Setup.exe` (installer, 60-80 MB)

### Option 2: Just the Executable
```bash
cd build-scripts
python build_exe_advanced.py
```
Creates: `dist\Bad-Antics_Device_Manager.exe`

### Option 3: Quick Help
```bash
cd build-scripts
BUILD_QUICK_REFERENCE.bat
```
Shows all options and prerequisites

---

## 🎨 Hacker-Themed Branding

The installer features **Matrix-style green on black** branding:

- **Primary Color**: `#00ff00` (Matrix green)
- **Background**: `#0a0a0a` (Deep black)
- **Professional installer wizard**
- **Desktop and Start Menu shortcuts**
- **File associations**
- **Installation logging**

### Customize Branding

1. Edit: `build-scripts/Bad-Antics_Device_Manager.iss`
2. Create custom graphics:
   - `installer_banner.bmp` (164×314 pixels)
   - `installer_icon.bmp` (55×57 pixels)
3. Run: `build_installer.bat`

---

## 📊 Output Files

After building, find releases in:
```
dist/
├── Bad-Antics_Device_Manager.exe          ← Portable (no install)
└── Bad-Antics_Device_Manager_Setup.exe    ← Professional installer
```

---

## 🔧 System Requirements

| Component | Requirement |
|-----------|-------------|
| **OS** | Windows 10 or later |
| **Python** | 3.10 or higher |
| **Disk Space** | 500 MB free |
| **Inno Setup** | 6.x (for installers) |

---

## 📚 Documentation

### For Quick Start
→ See `documentation/INSTALLER_BUILD_SUMMARY.md`

### For Complete Guide
→ See `documentation/INSTALLER_GUIDE.md`

Topics covered:
- Building executables
- Creating installers
- Customizing branding
- Troubleshooting
- Distribution strategies
- Release checklist

---

## 💡 Pro Tips

1. **Test First**: Always test on a clean Windows install
2. **Keep Both**: Provide both portable .exe and Setup.exe
3. **Version Control**: Update version in `.iss` file before each release
4. **Custom Graphics**: Use hacker theme colors (#00ff00 on #0a0a0a)
5. **Distribution**: Share Setup.exe with users for professional releases

---

## 🎯 Typical Workflow

```
1. Edit application code
   └─ pineflip-desktop-app/

2. Build installer
   └─ cd pineflip-installers/build-scripts
   └─ build_installer.bat

3. Test releases
   └─ dist/Bad-Antics_Device_Manager_Setup.exe
   └─ dist/Bad-Antics_Device_Manager.exe

4. Distribute
   └─ Upload Setup.exe to GitHub Releases
   └─ Share with users
```

---

## 🐛 Troubleshooting

### Python Not Found
Install Python 3.10+ from https://www.python.org with PATH enabled

### Inno Setup Not Found
Install Inno Setup 6 from https://jrsoftware.org/isdl.php

### Build Takes Too Long
Normal for first build (3-5 minutes). Bundles Python runtime + all libraries.

### File Size Too Large
Expected (60-80 MB). Includes Python + PyQt6 + dependencies. Can be reduced with UPX compression.

For more troubleshooting, see `documentation/INSTALLER_GUIDE.md`

---

## 📞 Quick Reference

| Task | Command |
|------|---------|
| **Build everything** | `build_installer.bat` |
| **Build just .exe** | `python build_exe_advanced.py` |
| **See help** | `BUILD_QUICK_REFERENCE.bat` |
| **Read guide** | Open `documentation/INSTALLER_GUIDE.md` |
| **Edit installer** | Edit `Bad-Antics_Device_Manager.iss` |

---

## ✨ Features

✅ One-click automated builds
✅ Icon generation
✅ Dependency checking
✅ Professional hacker-themed installer
✅ Start Menu integration
✅ Desktop shortcuts
✅ File associations
✅ Uninstall support
✅ Installation logging
✅ Customizable branding

---

## 📦 Distribution

### For End Users (Recommended)
Share: `Bad-Antics_Device_Manager_Setup.exe`
- Professional installer
- Easy installation
- System integration
- Clean uninstall

### For Developers
Share: `Bad-Antics_Device_Manager.exe`
- No installation needed
- Works from USB
- Portable deployment
- Faster startup

### For Flexibility
Share both files and let users choose!

---

## 🎓 Learning Resources

- **Inno Setup**: https://jrsoftware.org/isinfo.php
- **PyInstaller**: https://pyinstaller.org
- **PyQt6**: https://www.riverbankcomputing.com/software/pyqt
- **Hacker Aesthetics**: Green (#00ff00) on black (#0a0a0a)

---

Made with ❤️ by Bad-Antics
