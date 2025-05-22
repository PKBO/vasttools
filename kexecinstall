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
EOF

chmod +x /usr/local/bin/safe-kexec.sh

# Alias
if ! grep -q 'alias kxreboot=' ~/.bashrc; then
  echo "alias kxreboot='/usr/local/bin/safe-kexec.sh'" >> ~/.bashrc
  echo "[INFO] Alias 'kxreboot' přidán do ~/.bashrc"
else
  echo "[INFO] Alias 'kxreboot' již existuje"
fi

echo "[INFO] Instalace dokončena. Pro aktivaci aliasu spusť:"
echo "source ~/.bashrc"
