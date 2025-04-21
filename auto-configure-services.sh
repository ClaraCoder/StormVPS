#!/bin/bash
# Auto-configure script for VPN services

echo "Initializing auto-configuration for VPN services..."

# Install OpenVPN
echo "Installing OpenVPN..."
apt update && apt install -y openvpn
cat > /etc/openvpn/server.conf <<EOF
port 1194
proto udp
dev tun
ca ca.crt
cert server.crt
key server.key
dh dh.pem
server 10.8.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
keepalive 10 120
cipher AES-256-CBC
auth SHA256
compress lz4
persist-key
persist-tun
status openvpn-status.log
verb 3
EOF
systemctl start openvpn

# Install V2Ray
echo "Installing V2Ray..."
bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)
cat > /usr/local/etc/v2ray/config.json <<EOF
{
  "inbounds": [
    {
      "port": 10086,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "YOUR_UUID_HERE",
            "alterId": 64
          }
        ]
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    }
  ]
}
EOF
systemctl start v2ray

# Install Nginx
echo "Installing Nginx..."
apt update && apt install -y nginx
cat > /etc/nginx/sites-available/default <<EOF
server {
  listen 80;
  server_name localhost;

  location / {
    proxy_pass http://127.0.0.1:10086;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_set_header Host $host;
  }
}
EOF
systemctl restart nginx

echo "Auto-configuration complete!"