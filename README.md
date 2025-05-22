Tady je kompletní README.md, přesně podle požadavku:

markdown
Zkopírovat
Upravit
# Vast.ai Server Tools (`vasttools`)

This repository contains several scripts to assist with managing GPU servers on platforms like Vast.ai. Each script focuses on a specific task such as safe OS upgrade, Docker cleanup, or fast reboot with GPU reinitialization.

---

## 🔄 Server Update Script (`update_machine.sh`)

This script safely updates Ubuntu-based servers running Docker and Vast.ai services.

### What the script does

- Stops Docker and Vast.ai services safely  
- Displays Machine ID (recommended to back up)  
- Updates package lists  
- Upgrades packages  
- Disables automatic upgrades to prevent disruptions  
- Restarts Docker and Vast.ai services

### Quick usage

```bash
wget -O update_machine.sh https://raw.githubusercontent.com/PKBO/vasttools/main/update_machine.sh
chmod +x update_machine.sh
./update_machine.sh
Requirements
Bash shell

Ubuntu or Debian-based system

Docker installed and working

Vast.ai service installed

Root or sudo privileges

Output
Status messages and logs printed directly to the terminal.

📦 Docker Usage Overview Script (docker_report.sh)
This script gives you an overview of space used by Docker containers, images, and build cache.

What the script does
Lists running containers (sorted by size)

Lists stopped containers (sorted by size)

Lists Docker images (sorted by size)

Shows total build cache size

Lists individual cache entries (sorted by size)

Quick usage
bash
Zkopírovat
Upravit
wget -O docker_report.sh https://raw.githubusercontent.com/PKBO/vasttools/main/docker_report.sh
chmod +x docker_report.sh
./docker_report.sh
Requirements
Bash shell

Docker 19.03+ with docker builder df support

Output
Clean terminal output with sorted summaries of Docker space usage.

⚡ Fast Reboot with GPU Reinitialization (kexec.sh)
This script performs a near-instant reboot using kexec, which reinitializes PCIe devices (like NVIDIA GPUs) without running the full BIOS/POST cycle. Useful when a GPU falls off the bus and needs to be recovered.

What the script does
Detects the newest installed kernel from /boot

Loads it into memory using kexec -l

Performs a fast reboot into the new kernel with kexec -e

Reinitializes all PCIe devices including GPUs

Skips BIOS and usually avoids breaking SSH/ping (especially on Vast.ai)

Quick usage
bash
Zkopírovat
Upravit
wget -O - https://raw.githubusercontent.com/PKBO/vasttools/main/kexecinstall.sh | bash
source ~/.bashrc
Then run:

bash
Zkopírovat
Upravit
kxreboot
Files in this repo
kexecinstall.sh – Installer script

kexec.sh – Core logic (installed to /usr/local/bin/safe-kexec.sh)

Requirements
Bash shell

Ubuntu or Debian-based system

kexec-tools (installed automatically)

Root or sudo privileges

Output
Fast reboot with GPU and PCIe reinitialization in 5–10 seconds. Vast.ai typically does not register downtime.

