#!/bin/bash
#UDP
GITHUB_CMD="https://github.com/FighterTunnel/tunnel/raw/"
wget -O /usr/bin/badvpn "${GITHUB_CMD}main/BadVPN-UDPWG/badvpn" >/dev/null 2>&1
chmod +x /usr/bin/badvpn > /dev/null 2>&1
wget -q -O /etc/systemd/system/badvpn1.service "${GITHUB_CMD}main/BadVPN-UDPWG/badvpn1.service" >/dev/null 2>&1
wget -q -O /etc/systemd/system/badvpn2.service "${GITHUB_CMD}main/BadVPN-UDPWG/badvpn2.service" >/dev/null 2>&1
wget -q -O /etc/systemd/system/badvpn3.service "${GITHUB_CMD}main/BadVPN-UDPWG/badvpn3.service" >/dev/null 2>&1
systemctl disable badvpn1 
systemctl stop badvpn1 
systemctl enable badvpn1
systemctl start badvpn1 
systemctl disable badvpn2 
systemctl stop badvpn2 
systemctl enable badvpn2
systemctl start badvpn2 
systemctl disable badvpn3 
systemctl stop badvpn3 
systemctl enable badvpn3
systemctl start badvpn3 
