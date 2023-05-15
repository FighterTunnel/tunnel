#!/bin/bash
# --www hidessh.com

#warning read documentasi in github Readme.md

# add on SSH
wget -q -O /usr/local/bin/add-ssh-user "https://github.com/FighterTunnel/tunnel/raw/main/plugins/hidessh/add-ssh-user"
wget -q -O /usr/local/bin/del-ssh-user "https://github.com/FighterTunnel/tunnel/raw/main/plugins/hidessh/del-ssh-user"

# add on Vmess
wget -q -O /usr/local/bin/add-vmess-user "https://github.com/FighterTunnel/tunnel/raw/main/plugins/hidessh/add-vmess-user"
wget -q -O /usr/local/bin/del-vmess-user "https://github.com/FighterTunnel/tunnel/raw/main/plugins/hidessh/del-vmess-user"

# add on Trojan
wget -q -O /usr/local/bin/add-trojan-user "https://github.com/FighterTunnel/tunnel/raw/main/plugins/hidessh/add-trojan-user"
wget -q -O /usr/local/bin/del-trojan-user "https://github.com/FighterTunnel/tunnel/raw/main/plugins/hidessh/del-trojan-user"

#permission
chmod +x /usr/local/bin/add-ssh-user
chmod +x /usr/local/bin/del-ssh-user
chmod +x /usr/local/bin/add-vmess-user
chmod +x /usr/local/bin/del-vmess-user
chmod +x /usr/local/bin/add-trojan-user
chmod +x /usr/local/bin/del-trojan-user
