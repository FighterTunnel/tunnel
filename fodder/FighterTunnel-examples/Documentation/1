[Unit]
Description=Limit Usage Xray Service
Documentation=FighterTunnel
After=syslog.target network-online.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/etc/xray/limit.vmess

[Install]
WantedBy=multi-user.target
