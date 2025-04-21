#!/bin/bash
# Setup script for VPS Simulator on Replit

# Step 1: Create persistent storage for root filesystem
mkdir -p .data/rootfs

# Step 2: Download Ubuntu 22.04 root filesystem
if [ ! -f ".data/ubuntu-rootfs.tar.gz" ]; then
  echo "Downloading Ubuntu 22.04 rootfs..."
  wget -qO .data/ubuntu-rootfs.tar.gz "https://partner-images.canonical.com/core/jammy/current/ubuntu-jammy-core-cloudimg-amd64-root.tar.gz"
else
  echo "Rootfs already downloaded."
fi

# Step 3: Extract root filesystem
if [ ! -d ".data/rootfs/bin" ]; then
  echo "Extracting root filesystem..."
  tar -xzf .data/ubuntu-rootfs.tar.gz -C .data/rootfs
else
  echo "Root filesystem already extracted."
fi

# Step 4: Install basic tools inside the rootfs
echo "Installing basic tools..."
proot -S ./.data/rootfs /bin/bash -c "
  apt update && apt install -y curl wget nano openssl ufw iptables nginx
"

echo "Setup complete! Use 'bash start-vps.sh' to start the environment."