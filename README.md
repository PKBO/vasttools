# update_machine.sh

This repository contains the `update_machine.sh` script, which safely updates your server, disables automatic upgrades, and restarts Docker and Vast.ai services.

## What the script does

After running, it performs:

1. **Stops Docker and Vast.ai services**
2. **Displays the Machine ID** (for backup)
3. **Updates package lists and upgrades packages**
4. **Disables unattended upgrades**
5. **Restarts Docker and Vast.ai services**

## Quick usage

On your target server or computer, run the following commands:

```bash
wget https://raw.githubusercontent.com/PKBO/vasttools/main/update_machine.sh
chmod +x update_machine.sh
./update_machine.sh
```

## Requirements

- Bash shell  
- Ubuntu or Debian-based system  
- Docker and Vast.ai service installed  
- Root or sudo privileges

## Output

The script prints progress and service restarts directly to the terminal.

## Author

[PKBO](https://github.com/PKBO)

# docker_report.sh

This repository contains the `docker_report.sh` script, which provides a detailed overview of Docker container, image, and build cache disk usage on your system.

## What the script does

After running, it displays:

1. **Running containers** (sorted by size)
2. **Stopped containers** (sorted by size)
3. **Docker images** (sorted by size)
4. **Detailed build cache entries**
5. **Full output from `docker system df -v`**

The script uses formatted `docker` CLI output and converts human-readable sizes into bytes for accurate sorting.

## Quick usage

On your target server or computer, run the following commands:

```bash
wget https://raw.githubusercontent.com/PKBO/vasttools/main/docker_report.sh
chmod +x docker_report.sh
./docker_report.sh
```

## Requirements

- Bash shell  
- Docker 19.03+ installed and available from the command line  
- The `docker builder df` command must be supported

## Output

The script prints structured tables for containers and images (sorted by size), followed by build cache details and a raw summary of disk usage.

## Author

[PKBO](https://github.com/PKBO)


# kexec.sh

This repository contains the `kexec.sh` script, which enables a near-instant reboot of your system without BIOS/POST. Useful when a GPU has fallen off the PCIe bus and needs to be reinitialized.

## What the script does

After running, it performs:

1. **Detects the newest installed kernel**
2. **Loads the kernel into memory using `kexec -l`**
3. **Immediately reboots into the new kernel using `kexec -e`**
4. **Reinitializes PCIe and GPU devices**
5. **Reboots typically in under 10 seconds**

## Quick installation

Run the following command once:

```bash
wget -O - https://raw.githubusercontent.com/PKBO/vasttools/main/kexecinstall.sh | bash
source ~/.bashrc
```

## Usage

```bash
kxreboot
```

## Requirements

- Bash shell  
- Ubuntu or Debian-based system  
- `kexec-tools` (installed automatically)  
- Root or sudo privileges

## Output

The script performs an extremely fast reboot with full PCIe and GPU reinitialization.

## Author

[PKBO](https://github.com/PKBO)
