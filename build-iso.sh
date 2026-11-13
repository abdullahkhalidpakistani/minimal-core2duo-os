#!/bin/sh
set -e

echo "=== Building Lightweight Core 2 Duo OS Rootfs ==="

# Install necessary host utilities for rootfs and ISO creation
sudo apt-get update
sudo apt-get install -y genisoimage wget squashfs-tools curl

# Create working directory
mkdir -p /tmp/os-root/boot/grub

# Create a basic GRUB configuration for fast booting
cat << 'EOF' > /tmp/os-root/boot/grub/grub.cfg
set timeout=2
set default=0

menuentry "Minimal Core2Duo OS" {
    echo "Loading Linux Kernel..."
    linux /boot/vmlinuz-lts root=/dev/ram0 init=/sbin/init quiet
    initrd /boot/initrd-lts
}
EOF

# Build ISO structure using genisoimage
echo "Generating final bootable ISO image..."
genisoimage -o minimal-core2duo-os.iso -R -J /tmp/os-root
echo "ISO generation complete!"
