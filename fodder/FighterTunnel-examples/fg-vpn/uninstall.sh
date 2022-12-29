#!/bin/sh
BIN=/usr/bin
CONFIGS=/etc/fightertunnel
SYSTEMD=/etc/systemd/system
SYSTEMCTL=$(which systemctl)

if [ `id -u` != "0" ]; then
    echo "Error at uninstallation, please run uninstaller as root"
    exit 1
fi

echo "Uninstalling FighterTunnel-Server..."
if [ -f $SYSTEMD/fightertunnel.service ]; then
    $SYSTEMCTL stop fightertunnel.service
    $SYSTEMCTL disable fightertunnel.service
    rm $SYSTEMD/fightertunnel.service
    $SYSTEMCTL daemon-reload
fi
if [ -f $BIN/fightertunnel ]; then
    rm $BIN/fightertunnel
fi
if [ -d $CONFIGS ]; then
    rm -rf $CONFIGS
fi
echo "Uninstall FighterTunnel-Server completed"
