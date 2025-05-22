🔄 System Update Script (update_machine.sh)
Safely updates your server, disables automatic upgrades, and restarts Docker and Vast.ai services.

Features
Stops Docker and Vast.ai services

Displays the machine ID (for backup)

Runs system update and upgrade

Disables unattended upgrades

Restarts Docker and Vast.ai

Usage
bash
Zkopírovat
Upravit
wget -O update_machine.sh https://raw.githubusercontent.com/PKBO/vasttools/main/update_machine.sh
chmod +x update_machine.sh
./update_machine.sh
⚡ Fast Reboot Script (kexec.sh)
Performs a near-instant reboot using kexec without BIOS/POST. Useful when GPUs fall off the PCIe bus.

Features
Detects the newest installed kernel

Loads the kernel into memory via kexec -l

Reboots directly into the new kernel with kexec -e

Rescans PCIe and GPU devices

Typically reboots in under 10 seconds

Installation & Usage
Install once:

bash
Zkopírovat
Upravit
wget -O - https://raw.githubusercontent.com/PKBO/vasttools/main/kexecinstall.sh | bash
source ~/.bashrc
Then reboot anytime with:

bash
Zkopírovat
Upravit
kxreboot
License
MIT

Author
PKBO
