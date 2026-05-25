#!/bin/bash
set -e

echo "========================================"
echo "  NI Multisim 14.0 Installer for macOS"
echo "========================================"
echo

# ──────────────────────────────────────────────
# CHECK ARCHITECTURE
# ──────────────────────────────────────────────
ARCH=$(uname -m)
if [[ "$ARCH" == "arm64" ]]; then
    echo "⚠️  Apple Silicon (M1/M2/M3) detected."
    echo "   Wine will run via Rosetta 2 emulation."
    echo "   Checking for Rosetta 2..."
    if ! /usr/bin/pgrep -q oahd; then
        echo "Installing Rosetta 2..."
        softwareupdate --install-rosetta --agree-to-license
    else
        echo "✅ Rosetta 2 already installed."
    fi
    echo
fi

# ──────────────────────────────────────────────
# CHECK HOMEBREW
# ──────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
    echo "❌ Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon
    if [[ "$ARCH" == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
fi

echo "✅ Homebrew detected."

# ──────────────────────────────────────────────
# INSTALL WINE
# ──────────────────────────────────────────────
echo "Installing Wine via Homebrew..."

# Uninstall any existing wine to avoid conflicts
brew uninstall --cask --ignore-dependencies wine-stable 2>/dev/null || true
brew uninstall --ignore-dependencies wine 2>/dev/null || true

brew install --cask wine-stable
brew install cabextract

# ──────────────────────────────────────────────
# INSTALL WINETRICKS
# ──────────────────────────────────────────────
if ! command -v winetricks &>/dev/null; then
    echo "Installing winetricks..."
    brew install winetricks
fi

echo "✅ Wine and winetricks installed."

# ──────────────────────────────────────────────
# CREATE 32-BIT WINE PREFIX
# ──────────────────────────────────────────────
export WINEPREFIX="$HOME/.multisim32"
export WINEARCH=win32

echo "Creating 32-bit Wine prefix at $WINEPREFIX..."

# Remove old prefix if exists
if [ -d "$WINEPREFIX" ]; then
    echo "Removing existing Wine prefix..."
    rm -rf "$WINEPREFIX"
fi

# Create new prefix
wineboot -u 2>/dev/null || true
winecfg -v winxp 2>/dev/null || true

# ──────────────────────────────────────────────
# INSTALL DEPENDENCIES
# ──────────────────────────────────────────────
echo "Installing core Wine dependencies (corefonts, mdac27, jet40)..."
# Kill wineserver to avoid hangs
wineserver -k 2>/dev/null || true
sleep 2

winetricks -q corefonts 2>/dev/null || true
winetricks -q mdac27 2>/dev/null || true
winetricks -q jet40 2>/dev/null || true

# ──────────────────────────────────────────────
# DOWNLOAD MULTISIM
# ──────────────────────────────────────────────
echo "Downloading Multisim 14.0..."
if [ -f "NI_Circuit_Design_Suite_14_0.zip" ]; then
    echo "File already exists. Skipping download."
else
    wget -O NI_Circuit_Design_Suite_14_0.zip \
        "https://download.ni.com/support/softlib/Core/Circuit_Design_Suite/14.0/14.0/NI_Circuit_Design_Suite_14_0.zip"
fi

echo "Unzipping Multisim installer..."
rm -rf multisim_installer
unzip -q NI_Circuit_Design_Suite_14_0.zip -d multisim_installer

cd multisim_installer || exit 1

# ──────────────────────────────────────────────
# RUN INSTALLER
# ──────────────────────────────────────────────
echo "Running Multisim installer via Wine..."
echo "This may take 10-20 minutes. Please wait..."

# Kill any existing wine processes
wineserver -k 2>/dev/null || true
sleep 2

(
    export WINEPREFIX="$HOME/.multisim32"
    export WINEARCH=win32
    export WINEDEBUG=-all
    wine setup.exe /quiet /norestart 2>/dev/null || \
    wine setup.exe /silent /norestart 2>/dev/null || \
    wine cmd /c 'start /wait "" setup.exe'
) >/tmp/multisim-install.log 2>&1

echo "Installer finished."

sleep 3

# ──────────────────────────────────────────────
# DOWNLOAD AND RUN ACTIVATOR
# ──────────────────────────────────────────────
echo "Downloading NI License Activator..."
ACTIVATOR_URL="https://github.com/AndreaLestingi/NI-Multisim-Crack-1.14/releases/download/activator/NI.License.Activator.exe"
ACTIVATOR_PATH="$HOME/.multisim32/drive_c/NI.License.Activator.exe"

if [ -f "$ACTIVATOR_PATH" ]; then
    echo "Activator already downloaded."
else
    wget -O "$ACTIVATOR_PATH" "$ACTIVATOR_URL"
fi

if [ -f "$ACTIVATOR_PATH" ]; then
    echo "Stopping Wine processes before activator..."
    wineserver -k 2>/dev/null || true
    sleep 2
    
    echo "Running NI License Activator under Wine..."
    echo "============================================================="
    echo "When the activator window opens:"
    echo "  1. You will see a list of NI products"
    echo "  2. Right-click (or Ctrl+click) on each product"
    echo "  3. Select 'Activate' from the context menu"
    echo "  4. Close the activator when done"
    echo "============================================================="
    echo
    read -p "Press Enter to open the activator..."
    
    export WINEPREFIX="$HOME/.multisim32"
    export WINEARCH=win32
    wine "$ACTIVATOR_PATH"
    
    echo "Activator closed."
else
    echo "⚠️  WARNING: Failed to download activator."
    echo "   You can manually download it from:"
    echo "   $ACTIVATOR_URL"
    echo "   Then run: wine \"$ACTIVATOR_PATH\""
fi

# ──────────────────────────────────────────────
# CREATE MACOS APPLICATION BUNDLE
# ──────────────────────────────────────────────
echo "Creating macOS application bundle..."

mkdir -p "$HOME/Applications/Multisim.app/Contents/MacOS"
mkdir -p "$HOME/Applications/Multisim.app/Contents/Resources"

# Create icon (simple placeholder - can be replaced)
if [ ! -f "$HOME/Applications/Multisim.app/Contents/Resources/icon.icns" ]; then
    echo "Creating placeholder icon..."
    # Create a simple ICNS file using sips (macOS built-in)
    mkdir -p /tmp/multisim-icon.iconset
    for size in 16 32 64 128 256 512; do
        sips -z $size $size /System/Applications/Utilities/Terminal.app/Contents/Resources/Terminal.icns --out /tmp/multisim-icon.iconset/icon_${size}x${size}.png 2>/dev/null || true
    done
    iconutil -c icns /tmp/multisim-icon.iconset -o "$HOME/Applications/Multisim.app/Contents/Resources/icon.icns" 2>/dev/null || true
    rm -rf /tmp/multisim-icon.iconset
fi

cat > "$HOME/Applications/Multisim.app/Contents/Info.plist" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>Multisim</string>
    <key>CFBundleIdentifier</key>
    <string>com.nationalinstruments.multisim</string>
    <key>CFBundleName</key>
    <string>Multisim 14</string>
    <key>CFBundleDisplayName</key>
    <string>NI Multisim 14.0</string>
    <key>CFBundleVersion</key>
    <string>14.0</string>
    <key>CFBundleShortVersionString</key>
    <string>14.0</string>
    <key>CFBundleIconFile</key>
    <string>icon</string>
    <key>NSHighResolutionCapable</key>
    <true/>
</dict>
</plist>
EOF

cat > "$HOME/Applications/Multisim.app/Contents/MacOS/Multisim" << 'EOF'
#!/bin/bash
export WINEPREFIX="$HOME/.multisim32"
export WINEARCH=win32
export WINEDEBUG=-all

MULTISIM_EXE="$WINEPREFIX/drive_c/Program Files/National Instruments/Circuit Design Suite 14.0/Multisim.exe"

if [ ! -f "$MULTISIM_EXE" ]; then
    osascript -e "display dialog \"Multisim not found at:\\n$MULTISIM_EXE\\n\\nPlease run the installer again.\" buttons {\"OK\"} default button 1 with icon stop"
    exit 1
fi

# Launch Multisim
wine "$MULTISIM_EXE" 2>/dev/null
EOF

chmod +x "$HOME/Applications/Multisim.app/Contents/MacOS/Multisim"

echo "✅ Application bundle created at ~/Applications/Multisim.app"

# ──────────────────────────────────────────────
# CREATE LAUNCHER SCRIPT IN /USR/LOCAL
# ──────────────────────────────────────────────
echo "Creating command-line launcher..."

sudo cat > /usr/local/bin/multisim << 'EOF'
#!/bin/bash
export WINEPREFIX="$HOME/.multisim32"
export WINEARCH=win32
wine "$WINEPREFIX/drive_c/Program Files/National Instruments/Circuit Design Suite 14.0/Multisim.exe" 2>/dev/null
EOF

sudo chmod +x /usr/local/bin/multisim 2>/dev/null || {
    echo "⚠️  Could not create /usr/local/bin/multisim (permission denied)"
    echo "   Run manually: sudo cp /usr/local/bin/multisim"
}

# ──────────────────────────────────────────────
# CLEANUP
# ──────────────────────────────────────────────
echo "Cleaning up installation files..."
cd ..
rm -rf multisim_installer NI_Circuit_Design_Suite_14_0.zip

echo
echo "======================================="
echo "✅ Multisim 14.0 installation complete!"
echo "======================================="
echo
echo "You can launch Multisim from:"
echo "  📱 ~/Applications/Multisim.app (drag to Dock)"
echo "  💻 Terminal: multisim"
echo "  ⌨️  Spotlight: Cmd+Space → 'Multisim'"
echo
echo "First launch may take 10-20 seconds."
echo
echo "If Multisim doesn't start, run this command:"
echo "  WINEPREFIX=\"$HOME/.multisim32\" winecfg"
echo "  → Set Windows version to Windows XP"
echo "  → Apply, then try again"
echo
