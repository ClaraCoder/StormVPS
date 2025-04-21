#!/bin/bash
# VPS Simulation Launcher Script for Replit

# Check if the environment is already set up
if [ ! -d ".data/rootfs" ]; then
  echo "Environment not found. Initializing setup..."
  bash setup.sh
fi

echo "Starting VPS Simulation Environment..."
proot -S ./.data/rootfs /bin/bash --login