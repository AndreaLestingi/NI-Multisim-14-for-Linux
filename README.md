# NI Multisim 14 for Linux (Wine Installer)

Automated installer script for running **NI Multisim 14.0** on Linux using Wine.

---

## ⚠️ Disclaimer

This project is provided "as is", without warranty of any kind, express or implied.

The authors take no responsibility or liability for any damages, data loss, system instability, or legal issues that may arise from the use of this script.

By using this software, you acknowledge that:
- You use it entirely at your own risk
- You are responsible for complying with all applicable software licenses and laws
- The authors are not affiliated with National Instruments or any related company

---

## 📌 Features

- Automatic detection of Linux distribution:
  - Arch Linux
  - Debian / Ubuntu / Mint
  - Fedora
  - openSUSE
- Automatic Wine installation and configuration
- 32-bit Wine prefix setup (`WINEARCH=win32`)
- Winetricks dependency installation:
  - corefonts
  - mdac27
  - jet40
- Automated download of NI Circuit Design Suite 14.0
- Automated installation via Wine
- Desktop shortcut correction (Debian-based systems)
- Optional Chaotic AUR support (Arch Linux)

---

## ⚙️ Requirements

- Linux system (supported distros listed above)
- Internet connection
- sudo privileges
- At least 5–10 GB free disk space
- Wine-compatible hardware

---

## 🚀 Installation

```bash
chmod +x install.sh
./install.sh
