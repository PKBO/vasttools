Docker Usage Overview Script (docker_report.sh)
This repository also contains the docker_report.sh script, which provides a quick overview of Docker container, image, and build cache usage on your system.

What the script does
After running, you will see:

Running containers (sorted by size)

Stopped containers (sorted by size)

Docker images (sorted by size)

Total build cache size

Build cache entries (sorted by size)

Quick usage
On your target server or computer, run these commands:

bash
Zkopírovat
Upravit
wget -O docker_report.sh https://raw.githubusercontent.com/PKBO/vastdockersize/main/docker_report.sh
chmod +x docker_report.sh
./docker_report.sh
If you are using a branch other than main, change the branch name in the wget URL accordingly.

Requirements
Bash shell

Docker installed and available from the command line

The docker builder df command enabled (Docker 19.03+)

Output
The script prints clear tables and summaries directly to the terminal.

Fast Reboot with PCIe/GPU Reinitialization (kexec.sh)
This repository also includes a tool for ultra-fast reboot of the server using kexec, ideal for cases where a GPU has fallen off the PCIe bus (e.g., nvidia-smi no longer sees it), without requiring a full POST/BIOS reboot.

What the script does
After running, the script:

Detects the newest installed kernel from /boot

Loads it into memory with kexec -l

Performs a fast reboot with kexec -e (skipping BIOS, keeping networking up)

Typically restarts the system in under 10 seconds

Quick usage
On your target server, run the following to install:

bash
Zkopírovat
Upravit
wget -O - https://raw.githubusercontent.com/PKBO/vasttools/main/kexecinstall.sh | bash
source ~/.bashrc
Once installed, you can simply reboot at any time using:

bash
Zkopírovat
Upravit
kxreboot
This runs the main script located at /usr/local/bin/safe-kexec.sh.

Requirements
Ubuntu or Debian-based system

Installed kexec-tools (automatically handled by installer)

Root or sudo privileges

Files in this repo
kexecinstall.sh – Installer script for kexec reboot

kexec.sh – The core logic script (installed to /usr/local/bin/)

Output
Fast reboot with minimal downtime and reinitialization of all PCIe devices including GPUs.
