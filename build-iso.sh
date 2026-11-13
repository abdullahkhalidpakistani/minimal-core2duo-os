#!/bin/sh
set -e

# Update and install required build tools for ISO creation
apk update
apk add genisoimage syslinux squashfs-tools cdrkit wget curl

echo "=== Setting up Minimalist OS Environment ==="
# Create working directories
mkdir -p /tmp/os-root/etc /tmp/os-root/boot /tmp/os-root/root

# Configure lightweight environment variables
echo "export XDG_CURRENT_DESKTOP=Openbox" > /tmp/os-root/etc/environment

# Install lightweight window manager, file manager, and Chromium browser via Alpine APK
# Note: In a full rootfs build, these packages are pulled into the chroot or rootfs
echo "Preparing rootfs packages..."
cat << 'EOF' > /tmp/install_packages.sh
#!/bin/sh
apk add --no-cache \
    openbox \
    pcmanfm \
    chromium \
    alsa-utils \
    eudev \
    xorg-server \
    xf86-video-vesa \
    xf86-input-libinput \
    tint2 \
    lxappearance
EOF

chmod +x /tmp/install_packages.sh
echo "Build environment prepared successfully."
