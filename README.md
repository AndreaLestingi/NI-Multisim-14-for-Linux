# NI Multisim 14 for Linux & macOS

> Automated installer scripts to run **NI Multisim 14.0** on Linux and macOS via Wine.

---

## 📋 Description

This project provides bash scripts that automate the installation of **National Instruments Multisim 14.0** on Linux and macOS, using Wine with a dedicated 32-bit prefix.

### Supported Platforms

| Platform | Script | Status |
|----------|--------|--------|
| 🐧 Linux | `install.sh` | ✅ Full automation |
| 🍎 macOS | `install-macos.sh` | ✅ Full automation |

---

## 🚀 Quick Start

### Linux
```bash
git clone https://github.com/AndreaLestingi/NI-Multisim-14-for-Linux.git
cd NI-Multisim-14-for-Linux
chmod +x install.sh
./install.sh
```

### macOS
```bash
git clone https://github.com/AndreaLestingi/NI-Multisim-14-for-Linux.git
cd NI-Multisim-14-for-Linux
chmod +x install-macos.sh
./install-macos.sh
```

Follow the on-screen prompts. A reboot is recommended after installation.

---

## 📦 What Gets Installed

| Component | Linux | macOS |
|-----------|-------|-------|
| Wine (32-bit) | ✅ Per-distro package | ✅ Homebrew `wine-stable` |
| Winetricks | ✅ | ✅ |
| corefonts / mdac27 / jet40 | ✅ | ✅ |
| NI Multisim 14.0 | ✅ | ✅ |
| NI License Activator | ✅ | ✅ |
| Desktop/App launcher | ✅ `.desktop` file | ✅ `Multisim.app` bundle |

---

## 🔑 License Activation

The script automatically downloads the **NI License Activator** from:

```
https://github.com/AndreaLestingi/NI-Multisim-Crack-1.14/releases/download/activator/NI.License.Activator.exe
```

**When the activator window appears:**

1. You will see a list of NI products (Multisim, LabVIEW, etc.)
2. **Right-click** on each product entry
3. Select **"Activate"** from the context menu
4. Close the activator window when done

> **Note:** The activator is provided for educational purposes only. Users are responsible for complying with all applicable laws and NI's licensing terms.

---

## 🐧 Linux Support

### Supported Distributions

| Family | Distros |
|--------|---------|
| Arch Linux | Arch, Manjaro, EndeavourOS, … |
| Debian / Ubuntu | Debian, Ubuntu, Linux Mint, Pop!_OS, … |
| Fedora / RHEL | Fedora, CentOS, RHEL, … |
| openSUSE | openSUSE Leap, Tumbleweed, SLES, … |

### Requirements (Linux)
- 64-bit Linux system
- `sudo` privileges
- Internet connection
- ~5 GB free disk space

### Launch After Installation
```bash
# From terminal
WINEPREFIX="$HOME/.multisim32" wine "$HOME/.multisim32/drive_c/Program Files/National Instruments/Circuit Design Suite 14.0/Multisim.exe"

# Or from application menu
National Instruments → Circuit Design Suite 14.0 → Multisim 14.0
```

---

## 🍎 macOS Support

### Requirements (macOS)
- macOS 10.14 (Mojave) or later
- Intel or Apple Silicon (M1/M2/M3)
- Internet connection
- ~6 GB free disk space

> **Apple Silicon note:** Wine runs via Rosetta 2. First launch may take longer.

### Launch After Installation

**Method 1: Application Bundle (Recommended)**
```
Open Finder → Go to ~/Applications → Double-click Multisim.app
```

**Method 2: Spotlight Search**
Press `Cmd + Space` and type "Multisim"

**Method 3: Terminal**
```bash
export WINEPREFIX="$HOME/.multisim32"
wine "$HOME/.multisim32/drive_c/Program Files/National Instruments/Circuit Design Suite 14.0/Multisim.exe"
```

---

## 🧹 Uninstall

### Linux
```bash
chmod +x uninstall.sh
./uninstall.sh
```

### macOS
```bash
chmod +x uninstall-macos.sh
./uninstall-macos.sh
```

Both uninstallers will:
- Stop all Wine processes
- Remove the `~/.multisim32` Wine prefix
- Delete desktop launchers / app bundles
- Optionally remove Wine packages from your system

---

## 🗒️ Platform-Specific Notes

### Linux Notes
- On **Arch Linux**, you can choose between Chaotic AUR (faster) or compiling from AUR
- On **Fedora**, enabling RPM Fusion is recommended for best Wine compatibility
- On **openSUSE**, `forceClosewinedbg.sh` runs in background to suppress Wine debug windows
- The Wine prefix is separate from your default `~/.wine` to avoid conflicts

### macOS Notes
- **First launch** may take 10–20 seconds as Wine initializes
- **XQuartz** may be required for some Wine components
- The app bundle contains a launcher script with correct environment variables
- On Apple Silicon, Rosetta 2 installs automatically on first Wine launch

---

## 🐛 Troubleshooting

### Common Issues (Both Platforms)

| Issue | Solution |
|-------|----------|
| **Wine not found** | Restart terminal or run `hash -r` |
| **Blank/white window** | Run `winecfg` and set Windows version to XP |
| **Activator doesn't show products** | Run manually: `wine ~/.multisim32/drive_c/NI.License.Activator.exe` |
| **Fonts corrupted** | Run: `winetricks corefonts` |
| **Multisim crashes on launch** | Delete `~/.multisim32` and reinstall |

### Linux-Specific

| Issue | Solution |
|-------|----------|
| **Multiple definition errors** | Use the provided script (already fixed) |
| **Missing 32-bit libraries** | Run: `sudo dpkg --add-architecture i386` (Debian/Ubuntu) |

### macOS-Specific

| Issue | Solution |
|-------|----------|
| **"Bad CPU type in executable"** | Run: `softwareupdate --install-rosetta` |
| **Homebrew not found** | Script installs it automatically |
| **Wine is slow** | Normal on Apple Silicon (emulation overhead) |

---

## ⚠️ Disclaimer

> **This project is provided "as is", without warranty of any kind, express or implied.**
>
> The authors are **not responsible** for:
> - Any damage to your system resulting from the use of this script
> - Compatibility issues with specific hardware, software, or OS versions
> - Changes to third-party services (NI download servers, Wine, Homebrew, package repositories) that may break the installer
> - Any legal issues arising from the installation or use of NI Multisim 14.0 or the activator
>
> **NI Multisim is proprietary software owned by National Instruments (NI) / Emerson.**
> This script only automates the download of the official installer from NI's own servers and does not redistribute any proprietary software.
>
> **The NI License Activator is provided by a third party and is not affiliated with the script authors.**
>
> You are solely responsible for ensuring you have a valid license to use NI Multisim 14.0.

---

## 👥 Credits

| Role | Name |
|------|------|
| Original Linux Author | [Giovanni De Rosa (ghepardoman)](https://github.com/ghepardoman) |
| Linux Co-Author | Lorenzo Pappalardo |
| macOS Port | Community |
| Activator Provider | [Andrea Lestingi](https://github.com/AndreaLestingi) |

**Original Linux repository:**  
[https://github.com/ghepardoman/NI-Multisim-14-for-Linux](https://github.com/ghepardoman/NI-Multisim-14-for-Linux/blob/main/install.sh)

**Activator source:**  
[https://github.com/AndreaLestingi/NI-Multisim-Crack-1.14](https://github.com/AndreaLestingi/NI-Multisim-Crack-1.14)

---

## 📄 License

This script is released under the **GNU General Public License v3.0**.  
You are free to use, modify, and redistribute it, provided you include the original copyright notice and this license.

NI Multisim is proprietary software owned by National Instruments — ensure you have a valid license before use.

---

## 🌟 Contributing

Issues and pull requests are welcome! Please ensure:
- Scripts remain POSIX-compliant where possible
- Changes are tested on at least one distribution/platform
- Documentation is updated accordingly

---

**Enjoy Multisim on Linux & macOS!** 🐧🍎🔌
```
