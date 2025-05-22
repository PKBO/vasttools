#!/bin/bash
set -e

echo "[INFO] Hledám nejnovější nainstalovaný kernel..."

VMLINUZ=$(ls -1 /boot/vmlinuz-* | sort -V | tail -n1)
INITRD=$(echo "$VMLINUZ" | sed 's/vmlinuz-/initrd.img-/')
KERNEL_VERSION=$(basename "$VMLINUZ" | cut -d'-' -f2-)

echo "[INFO] Detekováno nejnovější jádro: $KERNEL_VERSION"

if [[ ! -f "$VMLINUZ" ]]; then
  echo "[ERROR] Nenalezen kernel image: $VMLINUZ"
  exit 1
fi

if [[ ! -f /boot/$INITRD ]]; then
  echo "[ERROR] Nenalezen initrd image: /boot/$INITRD"
  exit 1
fi

echo "[INFO] Připravuji zavedení kernelu přes kexec..."
echo " - vmlinuz: $VMLINUZ"
echo " - initrd : /boot/$INITRD"

kexec -l "$VMLINUZ" --initrd="/boot/$INITRD" --reuse-cmdline

echo "[INFO] Sync + přepnutí do nového jádra..."
sync
sleep 2
echo "[INFO] Spouštím kexec..."
kexec -e
