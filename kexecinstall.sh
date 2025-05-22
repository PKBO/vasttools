#!/bin/bash
set -e

echo "[INFO] Instalace safe-kexec..."

# Instalace nástroje
apt update
apt install -y kexec-tools

# Uložení hlavního skriptu
cat > /usr/local/bin/safe-kexec.sh << 'EOF'
#!/bin/bash
set -e
echo "[INFO] Hledám nejnovější nainstalovaný kernel..."
VMLINUZ=$(ls -1 /boot/vmlinuz-* | sort -V | tail -n1)
KERNEL_VERSION=$(basename "$VMLINUZ" | sed 's/vmlinuz-//')
INITRD="/boot/initrd.img-$KERNEL_VERSION"
ROOT_DEVICE=$(findmnt -n -o SOURCE /)

echo "[INFO] Detekováno nejnovější jádro: $KERNEL_VERSION"
if [[ ! -f "$VMLINUZ" ]]; then
  echo "[ERROR] Nenalezen kernel image: $VMLINUZ"
  exit 1
fi
if [[ ! -f "$INITRD" ]]; then
  echo "[ERROR] Nenalezen initrd image: $INITRD"
  exit 1
fi

echo "[INFO] Připravuji zavedení kernelu přes kexec..."
echo " - vmlinuz: $VMLINUZ"
echo " - initrd : $INITRD"
echo " - root   : $ROOT_DEVICE"

kexec -l "$VMLINUZ" --initrd="$INITRD" --command-line="root=$ROOT_DEVICE ro init=/lib/systemd/systemd"

echo "[INFO] Sync + přepnutí do nového jádra..."
sync
sleep 2
echo "[INFO] Spouštím kexec..."
kexec -e
EOF

chmod +x /usr/local/bin/safe-kexec.sh

# Globální alias do /etc/profile.d
echo "alias kxreboot='/usr/local/bin/safe-kexec.sh'" > /etc/profile.d/kxreboot.sh
chmod +x /etc/profile.d/kxreboot.sh

echo "[INFO] Alias 'kxreboot' přidán do /etc/profile.d/kxreboot.sh"
echo "[INFO] Instalace dokončena. Pro aktivaci aliasu spusť nový shell nebo:"
echo "source /etc/profile.d/kxreboot.sh"
