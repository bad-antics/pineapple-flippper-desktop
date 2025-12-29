# Bad-Antics Device Manager - Desktop Edition

<div align="center">

![GitHub](https://img.shields.io/badge/platform-Windows-blue)
![Python](https://img.shields.io/badge/python-3.10+-green)
![License](https://img.shields.io/badge/license-MIT-brightgreen)

A native Windows desktop application for managing **Flipper Zero** and **WiFi Pineapple** devices.

[Features](#features) • [Installation](#installation) • [Quick Start](#quick-start) • [Documentation](#documentation)

</div>

## 🎯 Overview

Bad-Antics Device Manager is a feature-rich desktop application that provides an intuitive interface for managing and monitoring Flipper Zero and WiFi Pineapple devices. Built with **PyQt6** for a modern, responsive user experience.

### Why This Over Web Interface?

- ✅ **Native Desktop App** - No web server needed, no browser required
- ✅ **Instant Startup** - Single executable or Python script
- ✅ **Better Performance** - Direct device communication
- ✅ **Rich UI** - Professional desktop interface with real-time updates
- ✅ **Background Operations** - Auto-connect and monitoring run in background threads
- ✅ **Windows Integration** - System notifications and tray integration ready

## ✨ Features

### Flipper Zero Management

- 🔌 **Auto-Connect** - Automatically detects and connects to Flipper Zero via USB
- 📊 **Device Monitor** - Real-time display of:
  - Device information (model, firmware version)
  - System uptime
  - Memory usage
  - Serial port details

- 🎮 **CLI Commands** - Execute any Flipper CLI command directly:
  ```
  info device
  uptime
  free
  subghz tx <parameters>
  storage list <path>
  ```

- 📁 **File Explorer**
  - Browse Flipper's internal and external storage
  - Read file contents
  - Delete files
  - Download files to computer

- 📡 **Sub-GHz Transmission**
  - Carrier transmission
  - Static signal transmission
  - Custom frequency and modulation
  - Load from files
  - Raw data transmission

### WiFi Pineapple Management

- 🌐 **Auto-Discovery** - Automatically locates Pineapple on network
- 🔐 **Authentication** - Secure login with token-based API access
- 📈 **Status Monitoring** - View:
  - Device status and uptime
  - Connected clients
  - System logs
  - Notifications

- ⚙️ **Configuration** - Manage device settings
- 📝 **Logs** - Access detailed operation logs

## 🚀 Quick Start

### Option 1: Run as Python Script (Recommended for Development)

**Requirements:** Python 3.10+

```bash
# Clone or download the repository
git clone https://github.com/yourusername/pineflip-desktop-app.git
cd pineflip-desktop-app

# Install dependencies
pip install -r requirements.txt

# Run the application
python desktop_app.py
```

### Option 2: Run Standalone Executable (Recommended for Users)

**Requirements:** Windows 10/11

1. Download the latest `.exe` from [Releases](https://github.com/yourusername/pineflip-desktop-app/releases)
2. Double-click to run - no installation needed!

### Option 3: Build Your Own Executable

```bash
# Install PyInstaller
pip install PyInstaller

# Build
python build_exe.py

# Run the executable
dist\Bad-Antics_Device_Manager.exe
```

## 📋 Requirements

### For Running from Source
- Windows 10 or later
- Python 3.10 or higher
- PyQt6 6.6+
- pyserial 3.5+
- requests 2.32+

### For Running Executable
- Windows 10 or later
- No additional dependencies needed!

### Hardware
- USB connection to Flipper Zero
- Network connection to WiFi Pineapple (optional)

## 🛠️ Installation

### From Source

```bash
git clone https://github.com/yourusername/pineflip-desktop-app.git
cd pineflip-desktop-app
pip install -r requirements.txt
python desktop_app.py
```

### From Executable

Download the latest release from the [Releases page](https://github.com/yourusername/pineflip-desktop-app/releases) and run it directly.

### Building Custom Executable

```bash
pip install PyInstaller
python build_exe.py
```

The executable will be created in the `dist/` folder.

## 📖 Usage Guide

### Connecting to Flipper Zero

1. Connect your Flipper Zero to your computer via USB
2. Launch the application
3. Switch to the **"Flipper Zero"** tab
4. The app will auto-detect the serial port
5. Click **"Connect"** button
6. Status indicator will turn **green** when connected

### Monitoring Device Status

The device monitor displays:
- **Port**: Serial port in use (e.g., COM3)
- **Device Info**: Manufacturer, model, firmware
- **Uptime**: How long the device has been running
- **Memory**: RAM and storage usage

### Sending Commands

1. Enter a Flipper CLI command in the command input field
2. Click **"Send"** or press Enter
3. Results appear in the monitor panel

**Common Commands:**
```
info device          # Show device information
uptime              # Show system uptime
free                # Show memory usage
storage list /ext   # List external storage files
storage read /ext/file.txt  # Read file contents
```

### File Explorer

1. Enter a path (e.g., `/ext`, `/int`, `/data`)
2. Click **"List Files"**
3. Browse the file listing
4. Click on a file to view or delete it

### Connecting to WiFi Pineapple

1. Ensure Pineapple is powered on and on your network
2. Switch to the **"WiFi Pineapple"** tab
3. Enter connection details:
   - **URL**: Device address (auto-detected as `http://172.16.42.1`)
   - **Username**: Usually `root`
   - **Password**: Device password
4. Click **"Connect"**
5. Status indicator will turn **green** when authenticated

### Viewing Pineapple Status

1. Once connected, click **"Refresh Status"**
2. View current device status, logs, and notifications
3. Logs update automatically in the background

## 🏗️ Project Structure

```
pineflip-desktop-app/
├── device_manager.py          # Core device communication library
├── desktop_app.py              # PyQt6 GUI application
├── build_exe.py                # Build executable script
├── requirements.txt            # Python dependencies
├── .gitignore                  # Git ignore rules
├── README.md                   # This file
├── LICENSE                     # MIT License
└── docs/
    ├── ARCHITECTURE.md         # System architecture
    ├── API.md                  # API documentation
    └── DEVELOPMENT.md          # Development guide
```

## 🔧 Architecture

### device_manager.py

Core business logic - no UI dependencies. Provides:

- `FlipperDevice` - Serial communication with Flipper Zero
  - Auto-detection of available ports
  - Command sending and response parsing
  - File system operations
  - Sub-GHz transmission control

- `PineappleDevice` - WiFi Pineapple API interface
  - Auto-discovery on network
  - Authentication and token management
  - API calls for status, logs, settings
  - Automatic reconnection

### desktop_app.py

PyQt6 desktop GUI. Provides:

- `MainWindow` - Main application window
- `FlipperTab` - Flipper device management interface
- `PineappleTab` - Pineapple management interface
- `DeviceWorker` - Background thread for auto-connect and monitoring

## 🔌 Configuration

### Environment Variables

```bash
# Flipper configuration
FLIPPER_PORT=COM3              # Serial port (auto-detect if not set)
FLIPPER_BAUD=230400           # Baud rate (default)

# Pineapple configuration
PINEAPPLE_URL=http://172.16.42.1
PINEAPPLE_USER=root
PINEAPPLE_PASS=your_password
```

### Example: Setting Environment Variables

**Windows PowerShell:**
```powershell
$env:PINEAPPLE_USER = "root"
$env:PINEAPPLE_PASS = "flooding"
python desktop_app.py
```

**Windows Command Prompt:**
```cmd
set PINEAPPLE_USER=root
set PINEAPPLE_PASS=flooding
python desktop_app.py
```

## 🐛 Troubleshooting

### Flipper Zero Won't Connect

**Issue**: Connection status stays "Not Connected"

**Solutions:**
1. Check USB cable is properly connected
2. Verify port in Device Manager (Settings → Device Manager → Ports)
3. Try different USB port on computer
4. Restart Flipper Zero
5. Update Flipper firmware

**Debug:**
```python
from device_manager import FlipperDevice
f = FlipperDevice()
print(f.connect())  # Should return True if connected
```

### Pineapple Won't Connect

**Issue**: Can't authenticate with Pineapple

**Solutions:**
1. Ensure Pineapple is powered on
2. Check it's connected to your network
3. Verify username/password (default: `root`/`flooding`)
4. Check IP address with `ipconfig` (should be `172.16.42.x`)
5. Try accessing `http://172.16.42.1` in browser

**Debug:**
```python
from device_manager import PineappleDevice
p = PineappleDevice()
p.discover_url()        # Should find the device
p.authenticate()        # Should return True
```

### Application Won't Start

**Issue**: "ModuleNotFoundError: No module named 'PyQt6'"

**Solution:**
```bash
pip install -r requirements.txt
```

### PyInstaller Executable Won't Run

**Issue**: Executable crashes on startup

**Solutions:**
1. Ensure Python 3.10+ is installed
2. Rebuild executable:
   ```bash
   pip install --upgrade PyInstaller
   python build_exe.py
   ```
3. Check Windows Defender isn't blocking it
4. Run with administrator privileges

## 📚 Documentation

- **[ARCHITECTURE.md](docs/ARCHITECTURE.md)** - System design and components
- **[API.md](docs/API.md)** - Device API documentation
- **[DEVELOPMENT.md](docs/DEVELOPMENT.md)** - Contributing and development guide

## 🤝 Contributing

Contributions are welcome! Here's how:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Add tests if applicable
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

See [DEVELOPMENT.md](docs/DEVELOPMENT.md) for detailed development instructions.

## 📦 Building Releases

To create a release:

```bash
# Build executable
python build_exe.py

# Test the executable
dist\Bad-Antics_Device_Manager.exe

# Create GitHub release with the .exe file
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⚖️ Disclaimer

This tool is provided for authorized use only. Users are responsible for:
- Ensuring they own or have permission to use devices
- Complying with all applicable laws and regulations
- Using this tool responsibly and ethically

## 🙏 Acknowledgments

- **Flipper Devices** - For creating the awesome Flipper Zero
- **WiFi Pineapple** - For the incredible WiFi Pineapple platform
- **PyQt6 Team** - For the excellent Python GUI framework
- **Community** - For feedback and contributions

## 📞 Support

- **Issues**: Report bugs on [GitHub Issues](https://github.com/yourusername/pineflip-desktop-app/issues)
- **Discussions**: Ask questions in [GitHub Discussions](https://github.com/yourusername/pineflip-desktop-app/discussions)
- **Security**: Report security issues to [security email]

---

<div align="center">

**[⬆ Back to Top](#bad-antics-device-manager---desktop-edition)**

Made with ❤️ by the Bad-Antics team

</div>
