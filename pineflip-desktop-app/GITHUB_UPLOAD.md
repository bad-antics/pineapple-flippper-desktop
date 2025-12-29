# GitHub Setup Instructions

## 📋 Prerequisites

- GitHub account (create at https://github.com if needed)
- Git installed on your computer
- SSH key or personal access token configured

## 🚀 Steps to Upload to GitHub

### Option 1: Create Repository via GitHub Web (Easiest)

1. **Go to GitHub:**
   - Visit https://github.com/new
   - Sign in with your account

2. **Create Repository:**
   - Repository name: `pineflip-desktop-app`
   - Description: "Native Windows desktop app for Flipper Zero and WiFi Pineapple management using PyQt6"
   - Choose "Public" to share with community
   - **DO NOT** initialize with README (we already have one)
   - Click "Create repository"

3. **Copy Repository URL:**
   - Copy the HTTPS or SSH URL shown (e.g., `https://github.com/yourusername/pineflip-desktop-app.git`)

4. **In PowerShell, add remote and push:**
   ```powershell
   cd 'C:\Users\pc123\OneDrive\Documents\pineflip-desktop-app'
   git remote add origin https://github.com/yourusername/pineflip-desktop-app.git
   git branch -M main
   git push -u origin main
   ```

### Option 2: Push Existing Repository via Command Line

```powershell
cd 'C:\Users\pc123\OneDrive\Documents\pineflip-desktop-app'
git remote add origin https://github.com/yourusername/pineflip-desktop-app.git
git branch -M main
git push -u origin main
```

## 🔐 Authentication

### Using HTTPS (Easier for Beginners)

1. **First Push:**
   - You may be prompted for credentials
   - Enter your GitHub username
   - For password, create a Personal Access Token (not your GitHub password):
     - Go to https://github.com/settings/tokens
     - Click "Generate new token"
     - Select `repo` scope
     - Copy the token and paste it as the password

### Using SSH (More Secure)

1. **Generate SSH Key** (if not already done):
   ```powershell
   ssh-keygen -t ed25519 -C "your-email@example.com"
   # Press Enter for all prompts to use defaults
   ```

2. **Add SSH Key to GitHub:**
   - Copy the public key: `Get-Content $HOME\.ssh\id_ed25519.pub | Set-Clipboard`
   - Go to https://github.com/settings/keys
   - Click "New SSH key"
   - Paste the key
   - Click "Add SSH key"

3. **Push using SSH:**
   ```powershell
   cd 'C:\Users\pc123\OneDrive\Documents\pineflip-desktop-app'
   git remote add origin git@github.com:yourusername/pineflip-desktop-app.git
   git branch -M main
   git push -u origin main
   ```

## ✅ Verify Upload

1. Go to `https://github.com/yourusername/pineflip-desktop-app`
2. You should see:
   - All files listed
   - README.md displayed
   - License file visible
   - Full commit history

## 📝 Add Topics (Tags)

1. On your GitHub repo page
2. Find "About" section on the right
3. Click the gear icon
4. Add topics:
   - `flipper-zero`
   - `wifi-pineapple`
   - `hacking-tools`
   - `pyqt6`
   - `desktop-application`
   - `windows`

## 🎯 Next Steps

### Make it Discoverable

1. **Add to GitHub Topics:**
   - Topics: flipper-zero, wifi-pineapple, hacking-tools

2. **Share on Social Media:**
   - Tweet the link
   - Post in Flipper Zero communities
   - Share in security/hacking forums

3. **Submit to GitHub Trending:**
   - Ensure quality README
   - Get stars from community
   - Regular updates

### Create Releases

1. **Build executable locally:**
   ```powershell
   cd 'C:\Users\pc123\OneDrive\Documents\pineflip-desktop-app'
   python build_exe.py
   ```

2. **Create GitHub Release:**
   - Go to https://github.com/yourusername/pineflip-desktop-app/releases
   - Click "Create a new release"
   - Tag: `v1.0.0`
   - Title: "Initial Release - Bad-Antics Device Manager"
   - Description: Add release notes (see template below)
   - Upload `dist/Bad-Antics_Device_Manager.exe`
   - Click "Publish release"

### Release Notes Template

```markdown
## Bad-Antics Device Manager v1.0.0

### ✨ Features

- **Flipper Zero Management**
  - Auto-connect to Flipper Zero via USB
  - Real-time device monitoring
  - CLI command execution
  - File explorer and storage management

- **WiFi Pineapple Management**
  - Auto-discovery on network
  - Device status monitoring
  - Log viewing and notification management

### 📦 Downloads

- **Bad-Antics_Device_Manager.exe** - Standalone Windows executable (no installation needed)

### 🚀 Getting Started

1. Download the `.exe` file above
2. Double-click to run
3. Connect your Flipper Zero via USB
4. The app will auto-detect your device

### 📋 System Requirements

- Windows 10 or later
- USB connection to Flipper Zero
- Network connection for WiFi Pineapple (optional)

### 🐛 Known Issues

None at this time. Please report any issues on the Issues page.

### 📚 Documentation

- [README.md](../README.md) - Full documentation
- [ARCHITECTURE.md](../docs/ARCHITECTURE.md) - Technical details
- [DEVELOPMENT.md](../docs/DEVELOPMENT.md) - Developer guide
```

## 🔄 Future Updates

After initial upload, to push updates:

```powershell
cd 'C:\Users\pc123\OneDrive\Documents\pineflip-desktop-app'
git add .
git commit -m "Your commit message"
git push
```

## 🎨 Enhance Your Repository

### Add a Badge to README

In your README.md, add at the top:

```markdown
![GitHub Stars](https://img.shields.io/github/stars/yourusername/pineflip-desktop-app?style=social)
![GitHub Forks](https://img.shields.io/github/forks/yourusername/pineflip-desktop-app?style=social)
![License](https://img.shields.io/badge/license-MIT-brightgreen)
```

### Add GitHub Actions (CI/CD)

Create `.github/workflows/build.yml`:

```yaml
name: Build Executable

on: [push, pull_request]

jobs:
  build:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-python@v2
        with:
          python-version: '3.13'
      - run: pip install -r requirements.txt PyInstaller
      - run: python build_exe.py
      - uses: actions/upload-artifact@v2
        with:
          name: Bad-Antics_Device_Manager
          path: dist/Bad-Antics_Device_Manager.exe
```

## 💡 Tips

1. **Protect main branch:**
   - Settings → Branches
   - Add branch protection rule for `main`
   - Require pull requests before merging

2. **Enable Issues:**
   - Settings → Features
   - Enable "Issues"
   - Users can report bugs

3. **Create Issue Templates:**
   - `.github/ISSUE_TEMPLATE/bug_report.md`
   - `.github/ISSUE_TEMPLATE/feature_request.md`

4. **Add Code of Conduct:**
   - Create `CODE_OF_CONDUCT.md`
   - Sets community expectations

## 📞 Support

**If push fails:**

```powershell
# Check remote
git remote -v

# Verify credentials
git config --list

# Test connection
ssh -T git@github.com
# Should output: "Hi yourusername! You've successfully authenticated..."
```

## 🎉 Success!

Your repository is now live on GitHub! Next steps:

- [ ] Verify all files uploaded
- [ ] Check README displays properly
- [ ] Build and test executable from source
- [ ] Create first release with .exe
- [ ] Share the link with community
- [ ] Monitor for issues and feature requests

---

**Your Repository URL:** `https://github.com/yourusername/pineflip-desktop-app`

Replace `yourusername` with your actual GitHub username!
