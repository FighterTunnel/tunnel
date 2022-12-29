#!/bin/sh
BIN=/usr/bin
CONFIGS=/etc/fightertunnel
SYSTEMD=/etc/systemd/system
SYSTEMCTL=$(which systemctl)
RESOURCES=`$(which dirname) "$0"`

if [ `id -u` != "0" ]; then
    echo "Error at installation, please run installer as root"
    exit 1
fi

if [ ! -d $SYSTEMD ]; then
    echo "Error at installation, no systemd directory found. make sure your distro using systemd as default init"
    exit 1
fi

if [ ! -f $SYSTEMCTL ]; then
    echo "Error at installation, no systemctl binary found. make sure your distro using systemd as default init"
    exit 1
fi

echo "Preparing upgrade/install..."
if [ -f $SYSTEMD/fightertunnel.service ]; then
    $SYSTEMCTL daemon-reload
    $SYSTEMCTL stop fightertunnel.service
    $SYSTEMCTL disable fightertunnel.service
    rm $SYSTEMD/fightertunnel.service
fi
if [ -f $BIN/fightertunnel ]; then
    rm $BIN/fightertunnel
fi
if [ -f $CONFIGS/cert.pem ]; then
    rm $CONFIGS/cert.pem
fi
if [ -f $CONFIGS/key.pem ]; then
    rm $CONFIGS/key.pem
fi

echo "Copying binary files..."
if [ ! -d $CONFIGS ]; then
    mkdir $CONFIGS
fi
cp $RESOURCES/fightertunnel $BIN/fightertunnel
cp $RESOURCES/cert.pem $CONFIGS/cert.pem
cp $RESOURCES/key.pem $CONFIGS/key.pem
cp $RESOURCES/fightertunnel.service $SYSTEMD/fightertunnel.service
if [ ! -f $CONFIGS/config.json ]; then
    cp $RESOURCES/config.json $CONFIGS/config.json
fi

echo "Setting files permission..."
chmod 700 $BIN/fightertunnel
chmod 700 $CONFIGS/cert.pem
chmod 700 $CONFIGS/config.json
chmod 700 $CONFIGS/key.pem
chmod 700 $SYSTEMD/fightertunnel.service

echo "Finishing upgrade/install..."
$SYSTEMCTL daemon-reload
$SYSTEMCTL enable fightertunnel.service

echo "Upgrade/Install completed."

echo ""
echo "[ NOTE ]"
echo "-Config and SSL(KEY/CERT) location: $CONFIGS"
echo "-Service Commands :"
echo "   + Start -> systemctl start fightertunnel.service"
echo "   + Restart -> systemctl restart fightertunnel.service"
echo "   + Stop -> systemctl stop fightertunnel.service"
echo "   + Log/Status -> systemctl status fightertunnel.service -l"
echo "   + Enable auto-start (enabled by default) -> systemctl enable fightertunnel.service"
echo "   + Disable auto-start -> systemctl disable fightertunnel.service"
echo "   + Full logs -> journalctl -u fightertunnel.service"


