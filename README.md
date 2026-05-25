# NI Multisim 14 for Linux

> Automated installer script to run **NI Multisim 14.0** on Linux via Wine.

---

## 📋 Description

This project provides a bash script that automates the installation of **National Instruments Multisim 14.0** on Linux, using Wine with a dedicated 32-bit prefix.

The script handles:
- Detection of the Linux distribution
- Removal of conflicting Wine packages
- Installation of Wine and Winetricks (per-distro)
- Creation of a clean 32-bit Wine prefix (`~/.multisim32`)
- Download and extraction of the official Multisim 14.0 installer from NI servers
- Running the installer via Wine
- Fixing the `.desktop` launcher (on Debian/Ubuntu/Fedora)

---

## 🐧 Supported Distributions

| Family | Distros |
|--------|---------|
| Arch Linux | Arch, Manjaro, EndeavourOS, … |
| Debian / Ubuntu | Debian, Ubuntu, Linux Mint, Pop!_OS, … |
| Fedora / RHEL | Fedora, CentOS, RHEL, … |
| openSUSE | openSUSE Leap, Tumbleweed, SLES, … |

---

## ⚙️ Requirements

- A 64-bit Linux system
- `sudo` privileges
- Internet connection (the script downloads Wine, Winetricks, and Multisim)
- At least **~5 GB** of free disk space

---

## 🚀 Usage

```bash
git clone https://github.com/ghepardoman/NI-Multisim-14-for-Linux.git
cd NI-Multisim-14-for-Linux
chmod +x install.sh
./install.sh
```

Follow the on-screen prompts. At the end, a reboot is recommended.

---

## 📦 What Gets Installed

- **Wine** (stable, 32-bit prefix at `~/.multisim32`)
- **Winetricks** with `corefonts`, `mdac27`, `jet40`
- **NI Multisim 14.0** inside the Wine prefix

---

## 🗒️ Notes

- On **Arch Linux**, you can choose between installing Wine via Chaotic AUR (faster, prebuilt) or compiling from the AUR.
- On **Fedora**, enabling RPM Fusion is recommended for best Wine compatibility.
- On **openSUSE**, `forceClosewinedbg.sh` (included in the repo) is executed in background to suppress Wine debug windows.
- The Wine prefix is intentionally **separate** from your default `~/.wine` to avoid conflicts.

---

## ⚠️ Disclaimer

> **This project is provided "as is", without warranty of any kind, express or implied.**
>
> The authors — **Giovanni De Rosa** and **Lorenzo Pappalardo** — are **not responsible** for:
> - Any damage to your system resulting from the use of this script
> - Compatibility issues with specific hardware or software configurations
> - Changes to third-party services (NI download servers, Wine, package repositories) that may break the installer
> - Any legal issues arising from the installation or use of NI Multisim 14.0
>
> **NI Multisim is proprietary software owned by National Instruments (NI) / Emerson.**
> This script only automates the download of the official installer from NI's own servers and does not redistribute any proprietary software.
> You are solely responsible for ensuring you have a valid license to use NI Multisim 14.0.

---

## 👥 Credits

| Role | Name |
|------|------|
| Author & Maintainer | [Giovanni De Rosa (ghepardoman)](https://github.com/ghepardoman) |
| Co-Author | Lorenzo Pappalardo |

Original repository: [https://github.com/ghepardoman/NI-Multisim-14-for-Linux](https://github.com/ghepardoman/NI-Multisim-14-for-Linux/blob/main/install.sh)

---

## 📄 License

This project is released for educational and personal use. NI Multisim is proprietary software owned by National Instruments — ensure you have a valid license before use.
