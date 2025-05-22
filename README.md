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
wget -O docker_report.sh https://raw.githubusercontent.com/PKBO/vasttools/main/docker_report.sh
chmod +x docker_report.sh
./docker_report.sh
If you are using a branch other than main, change the branch name in the wget URL accordingly.

Requirements
Bash shell

Docker installed and available from the command line

The docker builder df command enabled (Docker 19.03+)

Output
The script prints clear tables and summaries directly to the terminal.

Fast Reboot with GPU Reinitialization (kexec.sh)
This repository also includes a script for fast system reboot using kexec, which reinitializes PCIe devices (e.g. NVIDIA GPUs) without a full BIOS/POST cycle. This is useful on GPU servers where a card has "fallen off the bus" and needs to be rediscovered by the system.

What the script does
After running, the script:

Detects the newest installed kernel from /boot

Loads it into memory with kexec -l

Reboots directly into the new kernel using kexec -e (skipping BIOS/firmware stage)

Reinitializes all PCIe devices including GPUs

Typically completes the reboot in under 10 seconds

Quick usage
Install the reboot tool with:

bash
Zkopírovat
Upravit
wget -O - https://raw.githubusercontent.com/PKBO/vasttools/main/kexecinstall.sh | bash
source ~/.bashrc
Then trigger a fast reboot anytime with:

bash
Zkopírovat
Upravit
kxreboot
This executes the main script located at /usr/local/bin/safe-kexec.sh.

Files in this repo
kexecinstall.sh – Installer script

kexec.sh – Core reboot logic (installed to /usr/local/bin/safe-kexec.sh)

Requirements
Bash shell

Ubuntu or Debian-based system

kexec-tools (installed automatically)

Root or sudo privileges

Output
Fast reboot with GPU and PCIe bus reset, typically with no downtime from Vast.ai’s perspective.

