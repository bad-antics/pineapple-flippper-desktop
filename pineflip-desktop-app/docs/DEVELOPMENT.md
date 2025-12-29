# Development Guide

## Getting Started

### Prerequisites

- Windows 10 or later
- Python 3.10+
- Git
- A text editor or IDE (VS Code, PyCharm, etc.)

### Setup Development Environment

1. Clone the repository:
```bash
git clone https://github.com/yourusername/pineflip-desktop-app.git
cd pineflip-desktop-app
```

2. Create virtual environment (recommended):
```bash
python -m venv venv
venv\Scripts\activate
```

3. Install dependencies:
```bash
pip install -r requirements.txt
pip install pytest black pylint
```

4. Run the application:
```bash
python desktop_app.py
```

## Code Structure

```
pineflip-desktop-app/
├── device_manager.py       # Device communication library
├── desktop_app.py          # PyQt6 GUI application
├── build_exe.py            # Executable builder
├── requirements.txt        # Dependencies
└── docs/
    ├── ARCHITECTURE.md     # System design
    ├── API.md              # API documentation
    └── DEVELOPMENT.md      # This file
```

## Making Changes

### Adding a Device Type

Example: Adding support for a new device

1. **In device_manager.py:**

```python
class NewDeviceClass:
    def __init__(self, *args, **kwargs):
        self.connected = False
        self._lock = threading.Lock()
    
    def connect(self) -> bool:
        """Connect to device"""
        with self._lock:
            # Implementation here
            pass
    
    def get_status(self) -> Dict:
        """Get device status"""
        if not self.connected:
            return {}
        # Implementation here
```

2. **In desktop_app.py:**

```python
class NewDeviceTab(QWidget):
    def __init__(self, device: NewDeviceClass):
        super().__init__()
        self.device = device
        self.init_ui()
    
    def init_ui(self):
        # Create UI controls
        pass

# In MainWindow.__init__:
self.new_device = NewDeviceClass()
self.new_device_tab = NewDeviceTab(self.new_device)
self.tabs.addTab(self.new_device_tab, "New Device")
```

### Adding a Flipper Command

1. **Add to FlipperDevice (device_manager.py):**

```python
def custom_command(self, param1, param2) -> str:
    """Execute custom command with parameters"""
    if not self.connected:
        raise RuntimeError("Flipper not connected")
    
    cmd = f"custom_command {param1} {param2}"
    return self.send_command(cmd)
```

2. **Add UI control (desktop_app.py, FlipperTab):**

```python
def custom_command_action(self):
    """Handle custom command button click"""
    try:
        param1 = self.param1_input.text()
        param2 = self.param2_input.text()
        result = self.flipper.custom_command(param1, param2)
        self.monitor_text.append(f"Command result: {result}")
    except Exception as e:
        QMessageBox.critical(self, "Error", str(e))
```

### Modifying the UI

1. Edit the relevant tab class in `desktop_app.py`
2. Use Qt Designer for complex layouts (optional)
3. Connect signals to slots
4. Update status indicators as needed

Example:
```python
# In FlipperTab.__init__:
self.custom_button = QPushButton("Custom Action")
self.custom_button.clicked.connect(self.on_custom_action)
layout.addWidget(self.custom_button)

def on_custom_action(self):
    # Handle button click
    pass
```

## Testing

### Unit Tests

Create `tests/test_device_manager.py`:

```python
import pytest
from device_manager import FlipperDevice, PineappleDevice

def test_flipper_init():
    f = FlipperDevice()
    assert f.connected == False
    assert f.port is None

def test_pineapple_init():
    p = PineappleDevice()
    assert p.token is None
```

Run tests:
```bash
pytest tests/
```

### Manual Testing

1. Connect Flipper Zero via USB
2. Run the application
3. Test each feature:
   - Connection
   - Status monitoring
   - Command execution
   - File browsing
   - Error handling

### Integration Testing

```bash
# Build and test executable
python build_exe.py
dist\Bad-Antics_Device_Manager.exe
```

## Code Style

### Format Code

```bash
black device_manager.py desktop_app.py
```

### Lint Code

```bash
pylint device_manager.py desktop_app.py
```

### Style Guidelines

- Use type hints:
```python
def connect(self, port: str = None) -> bool:
    pass
```

- Use docstrings:
```python
def custom_method(self, param: str) -> Dict:
    """
    Do something with param.
    
    Args:
        param: Parameter description
    
    Returns:
        Dictionary with results
    """
    pass
```

- Keep lines under 100 characters
- Use snake_case for functions/variables
- Use PascalCase for classes

## Debugging

### Enable Debug Logging

```python
import logging

logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)
logger.debug("Debug message")
```

### Debug Device Communication

```python
from device_manager import FlipperDevice

f = FlipperDevice()
if f.connect():
    print("Connected to:", f.port)
    result = f.send_command("info device")
    print("Response:", result)
else:
    print("Connection failed")
```

### Inspect Qt Application State

```python
# In desktop_app.py before main():
import sys
print(sys.argv)
print(f"Qt Application state: {app.applicationState()}")
```

## Building for Release

### Create Executable

```bash
python build_exe.py
```

The executable will be in `dist/` folder.

### Testing Release Build

```bash
dist\Bad-Antics_Device_Manager.exe
```

### Creating GitHub Release

1. Push code to GitHub
2. Create a tag: `git tag v1.0.0`
3. Push tag: `git push origin v1.0.0`
4. On GitHub, create release from tag
5. Upload the `.exe` file from `dist/`

## Performance Optimization

### Profile Application

```python
import cProfile
import pstats

profiler = cProfile.Profile()
profiler.enable()

# ... application code ...

profiler.disable()
stats = pstats.Stats(profiler)
stats.sort_stats('cumulative')
stats.print_stats(10)
```

### Reduce Startup Time

- Defer imports: Only import when needed
- Cache results: Use threading and caching
- Optimize UI: Pre-create widgets, use QSS for styling

### Memory Optimization

- Use `__slots__` for classes with many instances
- Clear caches periodically
- Avoid circular references

## Common Issues

### ImportError: No module named 'PyQt6'

```bash
pip install PyQt6
```

### Serial Port Not Found

```python
from serial.tools import list_ports
for port in list_ports.comports():
    print(f"Found: {port.device}")
```

### Pineapple Won't Connect

- Check network connectivity
- Verify credentials
- Try accessing URL in browser
- Check firewall settings

### Application Won't Start from Executable

```bash
# Run in terminal to see error messages
dist\Bad-Antics_Device_Manager.exe
```

## Contributing Guidelines

1. Fork the repository
2. Create feature branch: `git checkout -b feature/my-feature`
3. Make changes and test
4. Format code: `black *.py`
5. Commit: `git commit -m "Add my feature"`
6. Push: `git push origin feature/my-feature`
7. Create Pull Request

## Code Review Checklist

- [ ] Code follows style guidelines
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] No debug code left in
- [ ] Performance acceptable
- [ ] Error handling complete
- [ ] Works on Windows 10/11
- [ ] Thread-safe if multi-threaded

## Resources

- **PyQt6 Documentation**: https://www.riverbankcomputing.com/static/Docs/PyQt6/
- **Python Docs**: https://docs.python.org/3/
- **Flipper Zero Docs**: https://docs.flipperzero.one/
- **WiFi Pineapple Docs**: https://docs.hak5.org/

## Support

- **Issues**: Report on GitHub
- **Questions**: Use GitHub Discussions
- **Security**: Report to maintainer privately
