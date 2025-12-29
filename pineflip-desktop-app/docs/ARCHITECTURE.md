# Architecture Documentation

## System Overview

Bad-Antics Device Manager is built with a clear separation between device communication logic and user interface.

```
┌─────────────────────────────────────────────┐
│       PyQt6 Desktop GUI (desktop_app.py)    │
├─────────────────────────────────────────────┤
│                                             │
│  ┌──────────────────┐  ┌─────────────────┐ │
│  │  Flipper Tab    │  │ Pineapple Tab   │ │
│  │  - Monitor      │  │ - Status        │ │
│  │  - Commands     │  │ - Configuration │ │
│  │  - File Browser │  │ - Logs          │ │
│  │  - SubGHz       │  │ - Notifications │ │
│  └──────────────────┘  └─────────────────┘ │
│                                             │
│  Device Worker (Background Thread)          │
│  - Auto-connect                             │
│  - Status updates                           │
│                                             │
└─────────────────────────────────────────────┘
           ↓            ↓            ↓
┌──────────────────────────────────────────────┐
│   Device Communication Library (device_manager.py) │
├──────────────────────────────────────────────┤
│                                              │
│  ┌─────────────────────────────────────┐   │
│  │    FlipperDevice                    │   │
│  │  ├─ connect(port)                   │   │
│  │  ├─ send_command(cmd)               │   │
│  │  ├─ get_monitor_info()              │   │
│  │  ├─ list_files(path)                │   │
│  │  ├─ read_file(path)                 │   │
│  │  └─ delete_file(path)               │   │
│  └─────────────────────────────────────┘   │
│                                              │
│  ┌─────────────────────────────────────┐   │
│  │    PineappleDevice                  │   │
│  │  ├─ discover_url()                  │   │
│  │  ├─ authenticate()                  │   │
│  │  ├─ api_call(endpoint)              │   │
│  │  ├─ get_status()                    │   │
│  │  ├─ get_logs()                      │   │
│  │  └─ get_notifications()             │   │
│  └─────────────────────────────────────┘   │
│                                              │
└──────────────────────────────────────────────┘
           ↓            ↓            ↓
    ┌────────────┐ ┌──────────┐ ┌────────┐
    │ Serial USB │ │ Network  │ │  HTTP  │
    └────────────┘ └──────────┘ └────────┘
           ↓            ↓            ↓
    ┌────────────────────────────────────┐
    │   Hardware (Flipper/Pineapple)     │
    └────────────────────────────────────┘
```

## Component Details

### device_manager.py

Pure Python library with no UI dependencies. Can be used in other projects.

#### FlipperDevice Class

```python
class FlipperDevice:
    def __init__(self, port=None, baud=230400, timeout=2.0)
    def connect(port=None) -> bool
    def disconnect()
    def send_command(command) -> str
    def get_monitor_info() -> Dict
    def list_files(path) -> List[str]
    def read_file(path) -> str
    def delete_file(path) -> bool
```

**Features:**
- Auto-detection of available serial ports
- Connection pooling and state management
- Thread-safe operations with locking
- Automatic reconnection attempts
- Error handling and logging

#### PineappleDevice Class

```python
class PineappleDevice:
    def __init__(self, url, username, password)
    def discover_url(force=False) -> str
    def authenticate() -> bool
    def api_call(endpoint, method, data) -> Dict
    def get_status() -> Dict
    def get_logs() -> Dict
    def get_notifications() -> Dict
```

**Features:**
- Automatic network discovery of Pineapple
- Token-based authentication
- Caching of discovery results (30s)
- RESTful API interaction
- Error handling with fallback mechanisms

### desktop_app.py

PyQt6-based graphical interface with multiple tabs and background threading.

#### MainWindow Class

```python
class MainWindow(QMainWindow):
    - Initializes application window
    - Creates tab interface
    - Sets up background worker thread
    - Manages signal/slot connections
```

#### FlipperTab Class

```python
class FlipperTab(QWidget):
    - Serial port selection and connection
    - Device monitor display
    - CLI command execution
    - File explorer interface
```

**Key Features:**
- Real-time device status updates
- Responsive UI with threading
- Error messages and status indicators
- File browsing capabilities

#### PineappleTab Class

```python
class PineappleTab(QWidget):
    - URL/credentials input
    - Authentication handling
    - Status display
    - Log viewing
```

#### DeviceWorker Class

```python
class DeviceWorker(QObject):
    - Runs in separate QThread
    - Emits signals on device state changes
    - Implements auto-connect loop
    - Periodic status updates
```

**Worker Signals:**
- `flipper_status_updated` - Device info changed
- `flipper_connected` - Connection status changed
- `pineapple_connected` - Authentication status changed

## Data Flow

### Flipper Connection Sequence

```
User clicks "Connect"
    ↓
FlipperTab.connect_flipper()
    ↓
FlipperDevice.connect(port)
    ↓
Opens serial connection
    ↓
Sets connected = True
    ↓
Emits signal (flipper_connected)
    ↓
UI updates status indicator
```

### Device Status Update Sequence

```
DeviceWorker running in background
    ↓
Every N seconds: FlipperDevice.get_monitor_info()
    ↓
Emits signal (flipper_status_updated)
    ↓
Main thread receives signal
    ↓
FlipperTab.on_flipper_status()
    ↓
Updates monitor display
```

### Pineapple Discovery Sequence

```
User enters URL and credentials
    ↓
Clicks "Connect"
    ↓
PineappleDevice.authenticate()
    ↓
If failed: calls discover_url(force=True)
    ↓
Scans network for 172.16.0.0/16 addresses
    ↓
Probes each candidate URL
    ↓
Returns discovered URL
    ↓
Retries authentication with new URL
    ↓
Stores token for subsequent API calls
```

## Threading Model

```
Main Thread (Qt Event Loop)
    ├─ UI event handlers
    ├─ Signal/slot connections
    └─ Signal emissions from worker

Worker Thread
    ├─ Auto-connect loop
    ├─ Periodic status updates
    └─ Non-blocking device operations
```

**Thread Safety:**
- All device operations use locks
- Signal/slot used for cross-thread communication
- UI updates only happen in main thread
- Worker runs independently in background

## Error Handling Strategy

```
Device Operation
    ↓
Try operation
    ↓
If fails:
    ├─ Log error
    ├─ Schedule auto-reconnect
    ├─ Return error to UI
    └─ Show user message
```

## Performance Considerations

1. **Auto-connect Interval**: Configurable (default 10s)
   - Prevents excessive connection attempts
   - Reduces resource usage
   - Allows fast detection of device reconnection

2. **Serial Communication**:
   - 230400 baud default (Flipper standard)
   - 0.6s wait after command (Flipper response time)
   - Timeout on reads prevents blocking

3. **Network Requests**:
   - 10s timeout on API calls
   - 3s timeout on network discovery
   - Token caching prevents repeated authentication

4. **UI Updates**:
   - Only update visible tab
   - Batch updates when possible
   - Worker thread doesn't block UI

## Extension Points

### Adding New Device Types

1. Create new class in `device_manager.py` (e.g., `NewDeviceClass`)
2. Implement communication logic
3. Create new tab in `desktop_app.py`
4. Add to MainWindow tabs
5. Create corresponding worker signals

### Adding New Features to Flipper

1. Add method to `FlipperDevice` class
2. Add UI control to `FlipperTab`
3. Connect button to handler method
4. Update monitor display if needed

### Customizing UI

1. Modify `FlipperTab` or `PineappleTab` classes
2. Use Qt Designer (optional) for complex layouts
3. Add new signals/slots as needed
4. Update styling with Qt stylesheets

## Testing

### Unit Testing Device Logic

```python
from device_manager import FlipperDevice

# Mock serial connection
f = FlipperDevice("COM3")
assert f.connect() == True
assert f.send_command("info device") != ""
```

### Integration Testing

1. Connect real Flipper Zero
2. Connect to real WiFi Pineapple
3. Test all UI controls
4. Verify status updates

### Build Testing

```bash
python build_exe.py
dist/Bad-Antics_Device_Manager.exe
```

## Future Improvements

- [ ] Plugin system for custom commands
- [ ] Settings persistence
- [ ] Batch operations
- [ ] Advanced logging
- [ ] Device grouping/profiles
- [ ] Scripting support
- [ ] REST API for automation
