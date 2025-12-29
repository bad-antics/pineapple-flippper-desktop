# Bad-Antics Device Manager - Web Edition

<div align="center">

![Flask](https://img.shields.io/badge/Flask-3.0+-blue)
![Python](https://img.shields.io/badge/python-3.10+-green)
![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20Linux%20%7C%20macOS-blue)
![License](https://img.shields.io/badge/license-MIT-brightgreen)

A powerful web-based application for managing **Flipper Zero** and **WiFi Pineapple** devices.

[Features](#features) • [Installation](#installation) • [Quick Start](#quick-start) • [Usage](#usage) • [Documentation](#documentation)

</div>

---

## 🎯 Overview

Bad-Antics Device Manager Web Edition is a Flask-based web application that provides a powerful, browser-accessible interface for managing and monitoring Flipper Zero and WiFi Pineapple devices. Access your devices from anywhere on your network!

### Why Web Interface?

- ✅ **Browser-Based** - Access from any device on your network (phone, tablet, laptop, desktop)
- ✅ **Remote Access** - Manage devices from other computers on the same network
- ✅ **Cross-Platform** - Runs on Windows, Linux, and macOS
- ✅ **Easy Deployment** - Run on any machine with Python
- ✅ **Multi-User** - Share access with team members
- ✅ **Responsive Design** - Works beautifully on desktop and mobile
- ✅ **Zero Installation** - Just install Python packages and run

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

### Option 1: Run with Python (Recommended)

**Requirements:** Python 3.10+

```bash
# Navigate to the web app folder
cd pineflip-web-app

# Install dependencies
pip install -r requirements.txt

# Run the Flask server
python app.py
```

The application will be available at: **http://localhost:5000**

### Option 2: Run with Custom Configuration

**PowerShell:**
```powershell
$env:FLASK_DEBUG = "1"
$env:PINEAPPLE_USER = "root"
$env:PINEAPPLE_PASS = "flooding"
$env:AUTO_CONNECT_FLIPPER = "1"
python app.py
```

**Command Prompt:**
```cmd
set FLASK_DEBUG=1
set PINEAPPLE_USER=root
set PINEAPPLE_PASS=flooding
set AUTO_CONNECT_FLIPPER=1
python app.py
```

### Option 3: Run on Different Port

```bash
python app.py --port 5001
```

## 📋 Requirements

### Minimum Requirements
- Windows 10+, Linux, or macOS
- Python 3.10 or higher
- pip (Python package manager)
- USB cable for Flipper Zero
- Network connection to WiFi Pineapple (optional)

### Python Packages
- Flask 3.0+
- requests 2.32+
- pyserial 3.5+
- WTForms 1.2+
- Flask-Limiter 4.1+
- bcrypt 5.0+

## 🛠️ Installation

### From Source

```bash
git clone https://github.com/yourusername/pineflip-web-app.git
cd pineflip-web-app
pip install -r requirements.txt
python app.py
```

The application will be available at `http://localhost:5000`

## 📖 Usage Guide

### Connecting to Flipper Zero

1. Connect Flipper Zero via USB
2. Open the Flipper tab in the web interface
3. The app auto-detects the serial port
4. Click "Connect"
5. Status indicator will show when connected

### Monitoring Device Status

The device monitor displays:
- **Port**: Serial port in use (e.g., COM3)
- **Device Info**: Manufacturer, model, firmware
- **Uptime**: How long the device has been running
- **Memory**: RAM and storage usage

### Sending Commands to Flipper

1. Go to the Flipper tab
2. Enter a CLI command (e.g., `info device`, `uptime`, `free`)
3. Click "Send"
4. View results in the output panel

**Common Commands:**
```
info device          # Show device information
uptime              # Show system uptime
free                # Show memory usage
storage list /ext   # List external storage files
storage read /ext/file.txt  # Read file contents
```

### Browsing Device Files

1. Go to the File Explorer section
2. Enter a path (e.g., `/ext`, `/int`, `/data`)
3. Click "List Files"
4. Browse the file listing
5. Click on a file to view or delete it

### Connecting to WiFi Pineapple

1. Ensure Pineapple is powered on and on your network
2. Open the Pineapple tab
3. Enter connection details:
   - **URL**: Auto-detected or manual IP (typically `http://172.16.42.1`)
   - **Username**: Usually `root`
   - **Password**: Device password
4. Click "Connect"
5. Status indicator will show when authenticated

### Viewing Pineapple Status

1. Once connected, click "Refresh Status"
2. View current device status, connected clients, and logs
3. Logs update automatically in the background

## 🏗️ Project Structure

```
pineflip-web-app/
├── app.py                      # Flask application
├── requirements.txt            # Python dependencies
├── README.md                   # This file
├── README.txt                  # Original documentation
├── LICENSE                     # MIT License
├── templates/                  # HTML templates
│   ├── base.html              # Base template
│   ├── home.html              # Home page
│   ├── flipper.html           # Flipper management
│   ├── pineapple.html         # Pineapple management
│   ├── nav.html               # Navigation
│   └── footer.html            # Footer
└── tests/                      # Test files
    ├── test_flipper_monitor.py
    └── test_status_devices.py
```

## ⚙️ Configuration

### Environment Variables

```bash
# Flask configuration
FLASK_ENV=development          # development or production
FLASK_DEBUG=1                  # Enable debug mode (dev only)
SECRET_KEY=your_secret_key     # Flask secret key

# Device configuration
FLIPPER_PORT=COM3              # Serial port (auto-detect if not set)
FLIPPER_BAUD=230400           # Baud rate (default)

# Pineapple configuration
PINEAPPLE_URL=http://172.16.42.1
PINEAPPLE_USER=root
PINEAPPLE_PASS=your_password

# Auto-connect options
AUTO_CONNECT_FLIPPER=1        # Auto-connect to Flipper on startup
AUTO_CONNECT_PINEAPPLE=0      # Auto-connect to Pineapple on startup
```

### Example: Setting Environment Variables

**Windows PowerShell:**
```powershell
$env:FLASK_DEBUG = "1"
$env:PINEAPPLE_USER = "root"
$env:PINEAPPLE_PASS = "flooding"
python app.py
```

**Windows Command Prompt:**
```cmd
set FLASK_DEBUG=1
set PINEAPPLE_USER=root
set PINEAPPLE_PASS=flooding
python app.py
```

### Running with Configuration

**PowerShell:**
```powershell
$env:FLASK_DEBUG = "1"
$env:PINEAPPLE_USER = "root"
$env:PINEAPPLE_PASS = "flooding"
python app.py
```

**Command Prompt:**
```cmd
set FLASK_DEBUG=1
set PINEAPPLE_USER=root
set PINEAPPLE_PASS=flooding
python app.py
```

## 🐛 Troubleshooting

### Application Won't Start

**Issue**: "ModuleNotFoundError: No module named 'Flask'"

**Solution:**
```bash
pip install -r requirements.txt --upgrade
```

### Port Already in Use

**Issue**: "Address already in use" error

**Solutions:**
1. Run on a different port:
   ```bash
   python app.py --port 5001
   ```
2. Or find and stop the process using port 5000

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

### Pineapple Connection Failed

**Issue**: Can't connect to Pineapple / Authentication fails

**Solutions:**
1. Ensure Pineapple is powered on and on your network
2. Check network connectivity (try ping `172.16.42.1`)
3. Verify credentials (default: `root`/`flooding`)
4. Check IP address with `ipconfig` (should be `172.16.x.x`)
5. Try accessing `http://172.16.42.1` in browser

**Debug:**
```python
from device_manager import PineappleDevice
p = PineappleDevice()
p.discover_url()        # Should find the device
p.authenticate()        # Should return True
```

### Browser Can't Access Application

**Issue**: "Cannot reach localhost:5000"

**Solutions:**
1. Ensure Flask is running:
   ```bash
   python app.py
   ```
2. Try `http://127.0.0.1:5000` instead
3. Check firewall isn't blocking port 5000
4. Try a different port (5001, 5002, etc.)

## 📚 API Endpoints

### Flipper Zero Endpoints

- `GET /flipper` - Flipper management interface
- `POST /flipper/connect` - Connect to device
- `POST /flipper/disconnect` - Disconnect from device
- `POST /flipper/command` - Send CLI command
- `GET /flipper_status` - Get real-time device status

### WiFi Pineapple Endpoints

- `GET /pineapple` - Pineapple management interface
- `POST /pineapple/connect` - Authenticate with device
- `POST /pineapple/disconnect` - Disconnect from device
- `GET /pineapple_status` - Get device status
- `GET /pineapple/logs` - Get device operation logs

### Status Endpoints

- `GET /status` - Overall application status
- `GET /status/flipper_network` - Flipper network and connection status
- `GET /status/pineapple_network` - Pineapple network and connection status

## 📦 Production Deployment

### Using Waitress (Recommended)

```bash
pip install waitress
waitress-serve --port=5000 --host=0.0.0.0 app:app
```

### Using Gunicorn (Linux/macOS)

```bash
pip install gunicorn
gunicorn -w 4 -b 0.0.0.0:5000 app:app
```

### Using Nginx (Advanced)

1. Install Nginx
2. Configure reverse proxy to localhost:5000
3. Run Flask app:
   ```bash
   waitress-serve --port=5000 app:app
   ```
4. Access via Nginx (typically http://your-domain)

## 🤝 Contributing

Contributions are welcome! Here's how:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Add tests if applicable
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⚖️ Disclaimer

This tool is provided for authorized use only. Users are responsible for:
- Ensuring they own or have permission to use devices
- Complying with all applicable laws and regulations
- Using this tool responsibly and ethically

## 🙏 Acknowledgments

- **Flipper Devices** - For the awesome Flipper Zero
- **WiFi Pineapple** - For the incredible platform
- **Flask Team** - For the excellent web framework
- **Community** - For feedback and contributions

---

<div align="center">

**[⬆ Back to Top](#bad-antics-device-manager---web-edition)**

Made with ❤️ by the Bad-Antics team

</div>
