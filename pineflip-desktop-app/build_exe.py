#!/usr/bin/env python3
"""
Build script for creating standalone executable
Uses PyInstaller to package the application
"""

import subprocess
import sys
import os

def main():
    print("\n" + "="*60)
    print("  Bad-Antics Device Manager - Executable Builder")
    print("="*60 + "\n")
    
    # Install PyInstaller if needed
    print("Installing PyInstaller...")
    subprocess.check_call([sys.executable, "-m", "pip", "install", "-q", "PyInstaller"])
    
    # Build the executable
    print("\nBuilding executable...")
    cmd = [
        sys.executable, "-m", "PyInstaller",
        "--onefile",
        "--windowed",
        "--name", "Bad-Antics_Device_Manager",
        "--add-data", f"device_manager.py{os.pathsep}.",
        "--console",
        "desktop_app.py"
    ]
    
    result = subprocess.run(cmd)
    
    if result.returncode == 0:
        print("\n" + "="*60)
        print("  Build Successful!")
        print("="*60)
        print("\nExecutable location:")
        print(f"  {os.path.join(os.getcwd(), 'dist', 'Bad-Antics_Device_Manager.exe')}")
        print("\nYou can now distribute this .exe file to users!")
        print("No Python installation required!\n")
    else:
        print("\n" + "="*60)
        print("  Build Failed!")
        print("="*60)
        print("\nPlease check the error messages above.\n")
        sys.exit(1)

if __name__ == "__main__":
    main()
