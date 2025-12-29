#!/usr/bin/env python3
"""
Advanced PyInstaller build script for Bad-Antics Device Manager
Creates a professional executable with icon and metadata
"""

import os
import shutil
import subprocess
import sys
from pathlib import Path


def create_icon():
    """Create a simple icon using PIL if available, otherwise use a placeholder"""
    try:
        from PIL import Image, ImageDraw
        
        # Create a dark hacker-themed icon
        size = 256
        img = Image.new('RGB', (size, size), color='#0a0a0a')
        draw = ImageDraw.Draw(img)
        
        # Draw a simple circuit/hacker pattern
        # Green lines on black background
        color = '#00ff00'
        
        # Draw corners
        margin = 20
        draw.rectangle([margin, margin, size-margin, size-margin], outline=color, width=3)
        
        # Draw diagonal lines
        draw.line([margin, margin, size-margin, size-margin], fill=color, width=2)
        draw.line([size-margin, margin, margin, size-margin], fill=color, width=2)
        
        # Draw center circle
        center = size // 2
        radius = 40
        draw.ellipse(
            [center-radius, center-radius, center+radius, center+radius],
            outline=color,
            width=2
        )
        
        # Save icon
        ico_path = Path('icon.ico')
        img.save(ico_path, 'ICO')
        print(f"✓ Created icon: {ico_path}")
        return str(ico_path)
    except ImportError:
        print("⚠ PIL not installed - proceeding without custom icon")
        return None


def build_executable(icon_path=None):
    """Build the executable using PyInstaller"""
    
    print("\n" + "="*60)
    print("  🔨 Building Bad-Antics Device Manager Executable")
    print("="*60 + "\n")
    
    # PyInstaller command
    cmd = [
        sys.executable,
        "-m",
        "PyInstaller",
        "--onefile",  # Single executable
        "--windowed",  # No console window
        "--name=Bad-Antics_Device_Manager",
        "--add-data=LICENSE:.",  # Include license
        "--collect-all=PyQt6",  # Include all PyQt6 modules
        "--noconfirm",  # Don't ask for confirmation
        "--distpath=dist",  # Output directory
        "--buildpath=build",  # Build directory
        "--specpath=.",  # Spec file location
    ]
    
    # Add icon if available
    if icon_path and os.path.exists(icon_path):
        cmd.extend([f"--icon={icon_path}"])
    
    cmd.append("desktop_app.py")
    
    print("Running PyInstaller...")
    print(f"Command: {' '.join(cmd)}\n")
    
    try:
        result = subprocess.run(cmd, check=True)
        if result.returncode == 0:
            print("\n✓ Executable built successfully!")
            return True
    except subprocess.CalledProcessError as e:
        print(f"\n✗ Build failed with error: {e}")
        return False


def verify_executable():
    """Verify the executable was created"""
    exe_path = Path("dist/Bad-Antics_Device_Manager.exe")
    
    if exe_path.exists():
        size_mb = exe_path.stat().st_size / (1024 * 1024)
        print(f"\n✓ Executable verified:")
        print(f"  Location: {exe_path.absolute()}")
        print(f"  Size: {size_mb:.2f} MB")
        return True
    else:
        print(f"\n✗ Executable not found at {exe_path}")
        return False


def cleanup():
    """Clean up build artifacts"""
    print("\n🧹 Cleaning up build artifacts...")
    
    items_to_remove = ['build', 'Bad-Antics_Device_Manager.spec']
    for item in items_to_remove:
        if os.path.exists(item):
            if os.path.isdir(item):
                shutil.rmtree(item)
            else:
                os.remove(item)
            print(f"  ✓ Removed {item}")


def main():
    """Main build process"""
    
    print("\n" + "█" * 60)
    print("█" + " " * 58 + "█")
    print("█" + "  Bad-Antics Device Manager - Advanced Builder".center(58) + "█")
    print("█" + " " * 58 + "█")
    print("█" * 60)
    
    # Check dependencies
    print("\n📦 Checking dependencies...")
    try:
        import PyInstaller
        print("  ✓ PyInstaller installed")
    except ImportError:
        print("  ✗ PyInstaller not found")
        print("  Installing: pip install PyInstaller")
        subprocess.run([sys.executable, "-m", "pip", "install", "PyInstaller"], check=True)
        print("  ✓ PyInstaller installed")
    
    # Create icon
    print("\n🎨 Creating application icon...")
    icon_path = create_icon()
    
    # Build executable
    if not build_executable(icon_path):
        print("\n✗ Build failed!")
        return False
    
    # Verify
    if not verify_executable():
        print("\n✗ Verification failed!")
        return False
    
    # Cleanup
    cleanup()
    
    # Success message
    print("\n" + "█" * 60)
    print("█" + " " * 58 + "█")
    print("█" + "  ✓ BUILD SUCCESSFUL!".center(58) + "█")
    print("█" + " " * 58 + "█")
    print("█" * 60)
    print("\n📁 Ready to install: dist/Bad-Antics_Device_Manager.exe")
    print("📚 Next step: Create installer using build_installer.bat\n")
    
    return True


if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)
