# apr/22/2022 20:51:21 by RouterOS 6.48.6
# software id = V29P-LRIK
#
# model = RB750Gr3
# serial number = CC210EC4363A
/interface ovpn-client
add comment=id-17.hostddns.us:1987<->8291 connect-to=116.90.180.117 \
    mac-address=FE:59:A0:0E:09:D1 name=byhaaa@tunnel.id password=cibuaya25 \
    user=byhaaa@tunnel.id
/interface bridge
add comment="MODEM ISP" name=bridge1 protocol-mode=none vlan-filtering=yes
/interface ethernet
set [ find default-name=ether1 ] name=ether1-Openwrt
set [ find default-name=ether2 ] comment="vlan-20(OrbitMAX)" name=ether2-Umum
set [ find default-name=ether3 ] comment="Modem-(OrbitSTAR)" name=\
    ether3-Sosmed&Youtube
set [ find default-name=ether4 ] comment="Modem-(B310s)" name=ether4-Game
set [ find default-name=ether5 ] comment=MikroTik-Ac2 name=ether5-Hotspot
/interface vlan
add interface=ether1-Openwrt name=vlan-10 vlan-id=10
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=dhcp_pool0 ranges=192.168.100.2-192.168.100.254
/ip dhcp-server
add address-pool=dhcp_pool0 disabled=no interface=ether5-Hotspot name=dhcp1
/tool user-manager customer
set admin access=\
    own-routers,own-users,own-profiles,own-limits,config-payment-gw
/interface bridge port
add bridge=bridge1 hw=no interface=ether1-Openwrt pvid=10
add bridge=bridge1 interface=ether2-Umum pvid=20
/ip neighbor discovery-settings
set discover-interface-list=!dynamic
/interface bridge vlan
add bridge=bridge1 tagged=ether1-Openwrt untagged=ether2-Umum vlan-ids=20
/interface detect-internet
set detect-interface-list=all
/ip address
add address=192.168.2.2/24 interface=ether3-Sosmed&Youtube network=\
    192.168.2.0
add address=192.168.100.1/24 interface=ether5-Hotspot network=192.168.100.0
add address=192.168.1.2/24 interface=vlan-10 network=192.168.1.0
add address=192.168.8.2/24 interface=ether4-Game network=192.168.8.0
/ip dhcp-server network
add address=192.168.100.0/24 dns-server=8.8.8.8,8.8.4.4 gateway=192.168.100.1
/ip dns
set allow-remote-requests=yes cache-max-ttl=1d servers="1.1.1.1,129.250.35.250\
    ,1.0.0.1,208.67.222.220,156.154.71.25,9.9.9.9,4.2.2.1,4.2.2.2,4.2.2.3,4.2.\
    2.4,4.2.2.5,4.2.2.6,208.67.220.123,208.67.220.222,8.8.8.8,8.8.4.4,156.154.\
    70.1,204.194.232.200,24.113.32.30"
/ip firewall address-list
add address=192.168.1.0/24 list=Client+ISP
add address=192.168.2.0/24 list=Client+ISP
add address=192.168.10.0/24 list=Client+ISP
add address=192.168.100.0/24 list=Client+ISP
add address=192.168.0.0/16 comment="LB By BNT" list=LOCAL-IP
add address=172.16.0.0/12 comment="LB By BNT" list=LOCAL-IP
add address=10.0.0.0/8 comment="LB By BNT" list=LOCAL-IP
add address=192.168.8.0/24 list=Client+ISP
/ip firewall mangle
add action=accept chain=prerouting comment="Bypass Client + ISP" \
    dst-address-list=Client+ISP
add action=mark-connection chain=prerouting comment="Koneksi Game" \
    dst-address-list=Game-List new-connection-mark=Koneksi-Game passthrough=\
    yes src-address-list=Client+ISP
add action=mark-routing chain=prerouting connection-mark=Koneksi-Game \
    new-routing-mark=Route-Game passthrough=no src-address-list=Client+ISP
add action=mark-connection chain=prerouting comment=ICMP new-connection-mark=\
    DNS-ICMP passthrough=yes protocol=icmp
add action=mark-connection chain=prerouting dst-port=53,5353,853 \
    new-connection-mark=DNS-ICMP passthrough=yes protocol=tcp
add action=mark-connection chain=prerouting dst-port=53,5353,853 \
    new-connection-mark=DNS-ICMP passthrough=yes protocol=udp
add action=mark-routing chain=prerouting connection-mark=DNS-ICMP \
    new-routing-mark=Route-ICMP passthrough=no src-address-list=Client+ISP
add action=mark-connection chain=prerouting comment="Koneksi Speedtest" \
    dst-address-list=Speedtest-List dst-port=80,443 new-connection-mark=\
    Koneksi_Speedtest passthrough=yes protocol=tcp src-address-list=\
    Client+ISP
add action=mark-routing chain=prerouting connection-mark=Koneksi_Speedtest \
    dst-port=80,443 new-routing-mark=Route-Speedtest passthrough=no protocol=\
    tcp src-address-list=Client+ISP
add action=mark-connection chain=prerouting comment="Koneksi Whatsapp" \
    dst-address-list=Whatsapp-List new-connection-mark=Koneksi_Whatsapp \
    passthrough=yes src-address-list=Client+ISP
add action=mark-routing chain=prerouting connection-mark=Koneksi_Whatsapp \
    new-routing-mark=Route-Whatsapp passthrough=no src-address-list=\
    Client+ISP
add action=mark-connection chain=prerouting comment="Koneksi YOUTUBE&TIKTOK" \
    dst-address-list=Youtube-List new-connection-mark=Koneksi-Youtube \
    passthrough=yes src-address-list=Client+ISP
add action=mark-routing chain=prerouting connection-mark=Koneksi-Youtube \
    new-routing-mark=Route-YouTube passthrough=no src-address-list=Client+ISP
add action=mark-connection chain=input comment="LB By BNT" in-interface=\
    vlan-10 new-connection-mark=cm-vlan-10 passthrough=yes
add action=mark-connection chain=input comment="LB By BNT" in-interface=\
    ether3-Sosmed&Youtube new-connection-mark=cm-ether3 passthrough=yes
add action=mark-routing chain=output comment="LB By BNT" connection-mark=\
    cm-vlan-10 new-routing-mark=to-vlan-10 passthrough=yes
add action=mark-routing chain=output comment="LB By BNT" connection-mark=\
    cm-ether3 new-routing-mark=to-ether3 passthrough=yes
add action=mark-connection chain=prerouting comment="LB By BNT" \
    dst-address-list=!LOCAL-IP dst-address-type=!local new-connection-mark=\
    cm-vlan-10 passthrough=yes per-connection-classifier=\
    both-addresses-and-ports:2/0 src-address-list=LOCAL-IP
add action=mark-connection chain=prerouting comment="LB By BNT" \
    dst-address-list=!LOCAL-IP dst-address-type=!local new-connection-mark=\
    cm-ether3 passthrough=yes per-connection-classifier=\
    both-addresses-and-ports:2/1 src-address-list=LOCAL-IP
add action=mark-routing chain=prerouting comment="LB By BNT" connection-mark=\
    cm-vlan-10 dst-address-list=!LOCAL-IP new-routing-mark=to-vlan-10 \
    passthrough=yes src-address-list=LOCAL-IP
add action=mark-routing chain=prerouting comment="LB By BNT" connection-mark=\
    cm-ether3 dst-address-list=!LOCAL-IP new-routing-mark=to-ether3 \
    passthrough=yes src-address-list=LOCAL-IP
/ip firewall nat
add action=masquerade chain=srcnat out-interface=vlan-10
add action=masquerade chain=srcnat out-interface=ether3-Sosmed&Youtube
add action=masquerade chain=srcnat out-interface=ether4-Game
add action=masquerade chain=srcnat disabled=yes out-interface=\
    byhaaa@tunnel.id
add action=masquerade chain=srcnat comment="LB By BNT" disabled=yes \
    out-interface=vlan-10
add action=masquerade chain=srcnat comment="LB By BNT" disabled=yes \
    out-interface=ether3-Sosmed&Youtube
/ip firewall raw
add action=add-dst-to-address-list address-list=Whatsapp-List \
    address-list-timeout=5h chain=prerouting comment=Whatsapp \
    dst-address-list=!Client+ISP dst-port=\
    3478,4244,5222,5223,5228,5288,5242,5349,34784,45395,50318,59234 protocol=\
    tcp src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Whatsapp-List \
    address-list-timeout=5h chain=prerouting dst-address-list=!Client+ISP \
    dst-port=3478,4244,5222,5223,5228,5288,5242,5349,34784,45395,50318,59234 \
    protocol=tcp src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Whatsapp-List \
    address-list-timeout=5h chain=prerouting content=.whatsapp.com \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Whatsapp-List \
    address-list-timeout=5h chain=prerouting content=.whatsapp.net \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Speedtest-List \
    address-list-timeout=5h chain=prerouting comment=SPEEDTEST content=\
    speedtest.net dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Speedtest-List \
    address-list-timeout=5h chain=prerouting content=speedest. \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Speedtest-List \
    address-list-timeout=5h chain=prerouting content=speedtest- \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Speedtest-List \
    address-list-timeout=5h chain=prerouting content=.speedtest. \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Speedtest-List \
    address-list-timeout=5h chain=prerouting content=ooklaserver.net \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Speedtest-List \
    address-list-timeout=5h chain=prerouting content=nflxvideo.net \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Speedtest-List \
    address-list-timeout=5h chain=prerouting content=ipsaya.com \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Speedtest-List \
    address-list-timeout=5h chain=prerouting content=speedtestcustom.com \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Speedtest-List \
    address-list-timeout=5h chain=prerouting content=speedtestcustom. \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Speedtest-List \
    address-list-timeout=5h chain=prerouting content=speedtest.cbn.id \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Speedtest-List \
    address-list-timeout=5h chain=prerouting content=fast.com \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Speedtest-List \
    address-list-timeout=5h chain=prerouting content=speedcheck.org \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Speedtest-List \
    address-list-timeout=5h chain=prerouting content=speedof.me \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Speedtest-List \
    address-list-timeout=5h chain=prerouting content=hide.me \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Speedtest-List \
    address-list-timeout=5h chain=prerouting content=speedtest.cbn.id \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Speedtest-List \
    address-list-timeout=5h chain=prerouting content=whatismyipaddress.com \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Speedtest-List \
    address-list-timeout=5h chain=prerouting content=nordvpn.com \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Speedtest-List \
    address-list-timeout=5h chain=prerouting content=cekipsaya.com \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Speedtest-List \
    address-list-timeout=5h chain=prerouting content=similarweb.com \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Speedtest-List \
    address-list-timeout=5h chain=prerouting content=cbnspeed.com \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Speedtest-List \
    address-list-timeout=5h chain=prerouting content=vpnoverview.com \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Speedtest-List \
    address-list-timeout=5h chain=prerouting content=whatismyip.com \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Speedtest-List \
    address-list-timeout=5h chain=prerouting comment=top10 content=\
    top10vpn.com disabled=yes dst-address-list=!Client+ISP src-address-list=\
    Client+ISP
add action=add-dst-to-address-list address-list=Game-List \
    address-list-timeout=5h chain=prerouting comment=PUBG dst-address-list=\
    !Client+ISP dst-port=\
    7889,10012,13004,14000,17000,17500,18081,20000-20002,20371 protocol=tcp \
    src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Game-List \
    address-list-timeout=5h chain=prerouting dst-address-list=!Client+ISP \
    dst-port=8011,9030,10491,10612,12235,13004,13748,17000,17500,20000-20002 \
    protocol=udp src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Game-List \
    address-list-timeout=5h chain=prerouting dst-address-list=!Client+ISP \
    dst-port=7086-7995,10039,10096,11455,12070-12460,13894,13972,41182-41192 \
    protocol=udp src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Game-List \
    address-list-timeout=5h chain=prerouting dst-address-list=!Client+ISP \
    dst-port=10576-10643,20001,20002 protocol=udp src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Game-List \
    address-list-timeout=5h chain=prerouting comment=Mobilelegends \
    dst-address-list=!Client+ISP dst-port=\
    5000-5221,5224-5227,5229-5241,5243-5508,5551-5559,5601-5700,9001,9443 \
    protocol=tcp src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Game-List \
    address-list-timeout=5h chain=prerouting dst-address-list=!Client+ISP \
    dst-port=5520-5529,10003,30000-30300 protocol=tcp src-address-list=\
    Client+ISP
add action=add-dst-to-address-list address-list=Game-List \
    address-list-timeout=5h chain=prerouting dst-address-list=!Client+ISP \
    dst-port=4001-4009,5000-5221,5224-5241,5243-5508,5551-5559,5601-5700 \
    protocol=udp src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Game-List \
    address-list-timeout=5h chain=prerouting dst-address-list=!Client+ISP \
    dst-port=2702,3702,5517,5520-5529,8001,9000-9010,9992,10003,30000-30300 \
    protocol=udp src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Game-List \
    address-list-timeout=5h chain=prerouting comment=FF dst-address-list=\
    !Client+ISP dst-port="6006,6674,7006,7889,8001-8012,9006,10000-10012,11000\
    -11019,12006,12008,13006" protocol=tcp src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Game-List \
    address-list-timeout=5h chain=prerouting dst-address-list=!Client+ISP \
    dst-port=20561,39003,39006,39698,39779,39800 protocol=tcp \
    src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Game-List \
    address-list-timeout=5h chain=prerouting dst-address-list=!Client+ISP \
    dst-port=\
    6006,6008,7008,8008,9008,10000-10013,10100,11000-11019,12008,13008 \
    protocol=udp src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Game-List \
    address-list-timeout=5h chain=prerouting comment="Genshin Impact" \
    dst-address-list=!Client+ISP dst-port=42472 protocol=tcp \
    src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Game-List \
    address-list-timeout=5h chain=prerouting dst-address-list=!Client+ISP \
    dst-port=42472,22101-22102 protocol=udp src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Game-List \
    address-list-timeout=5h chain=prerouting comment=\
    "Call of Duty (COD Mobile)" dst-address-list=!Client+ISP dst-port=\
    3013,10000-10019,18082,50000,65010,65050 protocol=tcp src-address-list=\
    Client+ISP
add action=add-dst-to-address-list address-list=Game-List \
    address-list-timeout=5h chain=prerouting dst-address-list=!Client+ISP \
    dst-port=7085-7995,8700,9030,10010-10019,17000-20100 protocol=udp \
    src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Game-List \
    address-list-timeout=5h chain=prerouting comment="Arena of Valor (AOV)" \
    dst-address-list=!Client+ISP dst-port=10001-10094 protocol=tcp \
    src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Game-List \
    address-list-timeout=5h chain=prerouting dst-address-list=!Client+ISP \
    dst-port=10101-10201,10080-10110,17000-18000 protocol=udp \
    src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Game-List \
    address-list-timeout=5h chain=prerouting comment=\
    "Clash of Clans (COC) dan Clash Royale" dst-address-list=!Client+ISP \
    dst-port=9330-9340 protocol=tcp src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Game-List \
    address-list-timeout=5h chain=prerouting dst-address-list=!Client+ISP \
    dst-port=9330-9340 protocol=udp src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Game-List \
    address-list-timeout=5h chain=prerouting comment=DOTA2 dst-address-list=\
    !Client+ISP dst-port=9100-9200,8230-8250,8110-8120,27000-28998,7770-7790 \
    protocol=tcp src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Game-List \
    address-list-timeout=5h chain=prerouting dst-address-list=!Client+ISP \
    dst-port=27000-28998,39000,16300-16350 protocol=udp src-address-list=\
    Client+ISP
add action=add-dst-to-address-list address-list=Game-List \
    address-list-timeout=5h chain=prerouting comment=TEAMVIWER \
    dst-address-list=!Client+ISP dst-port=5938 protocol=tcp src-address-list=\
    Client+ISP
add action=add-dst-to-address-list address-list=Game-List \
    address-list-timeout=5h chain=prerouting dst-address-list=!Client+ISP \
    dst-port=5938 protocol=udp src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Game-List \
    address-list-timeout=5h chain=prerouting comment=cararegistrasi.com \
    content=cararegistrasi.com dst-address-list=!Client+ISP src-address-list=\
    Client+ISP
add action=add-dst-to-address-list address-list=Youtube-List \
    address-list-timeout=5h chain=prerouting comment="YOUTUBE DAN SOSMED" \
    content=.youtube.com dst-address-list=!Client+ISP src-address-list=\
    Client+ISP
add action=add-dst-to-address-list address-list=Youtube-List \
    address-list-timeout=5h chain=prerouting content=.googlevideo.com \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Youtube-List \
    address-list-timeout=5h chain=prerouting content=yt3.ggpht.com \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Youtube-List \
    address-list-timeout=5h chain=prerouting content=youtu.be \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Youtube-List \
    address-list-timeout=5h chain=prerouting content=.youtube-nocookie.com \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Youtube-List \
    address-list-timeout=5h chain=prerouting content=.ytimg.com \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Youtube-List \
    address-list-timeout=5h chain=prerouting content=youtubei.googleapis.com \
    dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Youtube-List \
    address-list-timeout=5h chain=prerouting comment=TIKTOK content=\
    .tiktok.com disabled=yes dst-address-list=!Client+ISP src-address-list=\
    Client+ISP
add action=add-dst-to-address-list address-list=Youtube-List \
    address-list-timeout=5h chain=prerouting content=.tiktokv.com disabled=\
    yes dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Youtube-List \
    address-list-timeout=5h chain=prerouting content=.tiktokcdn.com disabled=\
    yes dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Youtube-List \
    address-list-timeout=5h chain=prerouting content=.tiktokcdn.com disabled=\
    yes dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Youtube-List \
    address-list-timeout=5h chain=prerouting content=.byteoversea.com \
    disabled=yes dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Youtube-List \
    address-list-timeout=5h chain=prerouting content=.ibyteimg.com disabled=\
    yes dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Youtube-List \
    address-list-timeout=5h chain=prerouting content=.ibytedtos.com disabled=\
    yes dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Youtube-List \
    address-list-timeout=5h chain=prerouting content=.myqcloud.com disabled=\
    yes dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Youtube-List \
    address-list-timeout=5h chain=prerouting comment=INSTAGRAM content=\
    .instagram.com disabled=yes dst-address-list=!Client+ISP \
    src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Youtube-List \
    address-list-timeout=5h chain=prerouting content=.cdninstagram.com \
    disabled=yes dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Youtube-List \
    address-list-timeout=5h chain=prerouting comment=FACEBOOK content=\
    .facebook.com disabled=yes dst-address-list=!Client+ISP src-address-list=\
    Client+ISP
add action=add-dst-to-address-list address-list=Youtube-List \
    address-list-timeout=5h chain=prerouting content=.facebook.net disabled=\
    yes dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Youtube-List \
    address-list-timeout=5h chain=prerouting content=web.facebook.com \
    disabled=yes dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Youtube-List \
    address-list-timeout=5h chain=prerouting content=*.facebook.com* \
    disabled=yes dst-address-list=!Client+ISP src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Game-List \
    address-list-timeout=5h chain=prerouting comment=TEAMVIWER content=\
    sg-4.hostddns.us dst-address-list=!Client+ISP dst-port="" \
    src-address-list=Client+ISP
add action=add-dst-to-address-list address-list=Game-List \
    address-list-timeout=5h chain=prerouting comment=cararegistrasi.com \
    content=sg-4.hostddns.us dst-address-list=!Client+ISP src-address-list=\
    Client+ISP
/ip hotspot ip-binding
add comment=PC disabled=yes mac-address=00:E0:4C:56:06:3F type=bypassed
add comment="SAMSUNG A71" disabled=yes mac-address=68:BF:C4:25:08:0C type=\
    bypassed
/ip route
add check-gateway=ping comment=GAME distance=1 gateway=192.168.8.1 \
    routing-mark=Route-Game
add check-gateway=ping comment=ICMP distance=1 gateway=192.168.1.1 \
    routing-mark=Route-ICMP
add check-gateway=ping comment="SPEEDTEST INDOSAT" distance=1 gateway=\
    192.168.8.1 routing-mark=Route-Speedtest
add check-gateway=ping comment=WHATSAPP distance=1 gateway=192.168.1.1 \
    routing-mark=Route-Whatsapp
add check-gateway=ping comment=YOUTUBE&TIKTOK distance=1 gateway=192.168.2.1 \
    routing-mark=Route-YouTube
add check-gateway=ping comment="LB By BNT" distance=1 gateway=192.168.1.1 \
    routing-mark=to-vlan-10
add check-gateway=ping comment="LB By BNT" distance=1 gateway=192.168.2.1 \
    routing-mark=to-ether3
add check-gateway=ping comment=UTAMA distance=1 gateway=192.168.1.1
add check-gateway=ping comment=BACKUP distance=1 gateway=192.168.2.1
/system clock
set time-zone-autodetect=no time-zone-name=Asia/Jakarta
/system logging
add action=disk prefix=-> topics=hotspot,info,debug
/system ntp client
set enabled=yes primary-ntp=103.123.108.223 secondary-ntp=162.159.200.123 \
    server-dns-names=id.pool.ntp.org
/tool user-manager database
set db-path=flash/user-manager
