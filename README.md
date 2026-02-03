# Zotify Installer for Fedora

A lightweight, automated Bash script designed to streamline the installation of [Zotify](https://github.com/zotify-dev/zotify) on Fedora Linux. 

This installer handles the specific quirks of Fedora's package management (DNF), ensuring that necessary codecs (FFmpeg) and Python environment managers (Pipx) are set up correctly before installing the Zotify CLI tool.

## 🚀 Features

* **Automated Dependency Management:** Installs `python3`, `pipx`, and `git`.
* **Smart FFmpeg Detection:** Checks for full `ffmpeg` (often from RPMFusion). If unavailable, falls back to `ffmpeg-free` from default repositories to ensure basic functionality.
* **Clean Installation:** Uses `pipx` to install Zotify in an isolated environment, preventing conflicts with system-wide Python packages.
* **Latest Source:** Pulls directly from the active `zotify-dev/zotify` repository.

## 📋 Prerequisites

* **OS:** Fedora Linux (Workstation, Server, or Spins)
* **Permissions:** Sudo privileges (required to install system packages like FFmpeg and Git).

## 🛠️ Installation

### Option 1: Quick Install (Clone & Run)

1.  **Clone this repository** (or download the script):
    ```bash
    git clone [https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git](https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git)
    cd YOUR_REPO_NAME
    ```

2.  **Make the script executable:**
    ```bash
    chmod +x install_zotify_fedora.sh
    ```

3.  **Run the installer:**
    ```bash
    sudo ./install_zotify_fedora.sh
    ```

### Option 2: Manual Script Creation

1.  Create a file named `install_zotify_fedora.sh`.
2.  Paste the script content into the file.
3.  Run `chmod +x install_zotify_fedora.sh`.
4.  Run `sudo ./install_zotify_fedora.sh`.

---

## ⚙️ What the script does

1.  **Privilege Check:** Verifies the script is run with `sudo` (required for DNF operations).
2.  **Update Metadata:** Refreshes DNF repository data.
3.  **Install Tools:** Installs `python3`, `pipx`, and `git`.
4.  **FFmpeg Handling:**
    * It checks if you have full `ffmpeg` installed.
    * If not, it attempts to install it (if you have RPMFusion enabled).
    * If that fails, it installs `ffmpeg-free` to ensure the program runs, though proprietary codecs may be limited.
5.  **Zotify Install:** Switches back from `root` to your **standard user account** to install Zotify via `pipx`. This ensures the tool is owned by you, not root.

## 🎵 Usage

Once the installation is complete, you can run Zotify from anywhere in your terminal:

```bash
zotify
