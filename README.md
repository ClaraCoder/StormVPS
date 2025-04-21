# VPS Simulator on Replit

This project simulates a full-fledged VPS environment using Ubuntu 22.04 within Replit. It supports various VPN services and provides a web-based control panel.

## Features
1. Simulated root environment using `proot`.
2. Install and configure VPN services:
   - OpenVPN
   - WireGuard (simulated)
   - V2Ray (VMess, VLess, Trojan-GFW, Shadowsocks)
   - Trojan VPN
3. Web-based control panel for managing services.
4. Persistent data storage in `.data` folder.

## Getting Started
1. Clone this repository to your Replit project.
2. Run the setup script:
   ```bash
   bash setup.sh
   ```
3. Start the VPS environment:
   ```bash
   bash start-vps.sh
   ```
4. Access the WebView for management.

## Limitations
- Kernel-based features like real WireGuard interfaces are not supported on Replit.

---