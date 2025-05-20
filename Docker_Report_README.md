# Vast.ai Server Update Script (`update_machine.sh`)

This repository contains the `update_machine.sh` script, which safely updates servers running Docker and Vast.ai services.

## What the script does
After running, you will see:

- Stopping Docker and Vast.ai services safely
- Displaying Machine ID (recommended to back up)
- Updating package lists
- Upgrading packages
- Disabling automatic upgrades to prevent disruptions
- Restarting Docker and Vast.ai services

## Quick usage
On your target server or computer, run these commands:

```bash
wget -O update_machine.sh https://raw.githubusercontent.com/PKBO/vastdockersize/main/update_machine.sh
chmod +x update_machine.sh
./update_machine.sh
```
Replace `<URL-TO-SCRIPT>` with the actual URL where the script is hosted.

## Requirements
- Bash shell
- Docker installed and available from the command line
- Vast.ai services properly installed
- Root or sudo privileges

## Output
The script prints clear status updates directly to the terminal.

## Author
PKBO

---

# Docker Usage Overview Script (`docker_report.sh`)

This repository also contains the `docker_report.sh` script, which provides a quick overview of Docker container, image, and build cache usage on your system.

## What the script does
After running, you will see:

- Running containers (sorted by size)
- Stopped containers (sorted by size)
- Docker images (sorted by size)
- Total build cache size
- Build cache entries (sorted by size)

## Quick usage
On your target server or computer, run these commands:

```bash
wget -O docker_report.sh https://raw.githubusercontent.com/PKBO/vastdockersize/main/docker_report.sh
chmod +x docker_report.sh
./docker_report.sh
```

If you are using a branch other than `main`, change the branch name in the wget URL accordingly.

## Requirements
- Bash shell
- Docker installed and available from the command line
- The `docker builder df` command enabled (Docker 19.03+)

## Output
The script prints clear tables and summaries directly to the terminal.

## Author
[PKBO](https://github.com/PKBO)
