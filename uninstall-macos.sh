#!/bin/bash
# Uninstall script for NI Multisim 14.0 on macOS

set -e

echo "========================================"
echo "  NI Multisim 14.0 Uninstaller for macOS"
echo "========================================"
echo

WINEPREFIX="$HOME/.multisim32"

echo "This will remove:"
echo "  - Wine prefix: $WINEPREFIX"
echo "  - Application bundle: ~/Applications/Multisim.app"
echo

read -p "Are you sure? [y/N]: " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Uninstall cancelled."
    exit 0
fi

echo "Stopping Wine processes..."
wineserver -k 2>/dev/null || true
pkill -f "wine" 2>/dev/null || true

echo "Removing Wine prefix..."
rm -rf "$WINEPREFIX"

echo "Removing application bundle..."
rm -rf "$HOME/Applications/Multisim.app"

echo "Removing desktop entries..."
rm -f "$HOME/.local/share/applications/wine/Programs/National Instruments/Circuit Design Suite 14.0/Multisim 14.0.desktop" 2>/dev/null || true

echo
read -p "Do you want to uninstall Wine and winetricks as well? [y/N]: " remove_wine
if [[ "$remove_wine" =~ ^[Yy]$ ]]; then
    echo "Removing Wine and winetricks..."
    brew uninstall --cask wine-stable 2>/dev/null || true
    brew uninstall winetricks 2>/dev/null || true
    brew uninstall cabextract 2>/dev/null || true
    echo "✅ Wine removed."
else
    echo "Skipping Wine removal."
fi

echo
echo "======================================="
echo "✅ Multisim 14.0 has been uninstalled!"
echo "======================================="
