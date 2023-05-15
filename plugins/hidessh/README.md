# plugin web panel hidessh

panel hidessh menggunakan sistem pay as you go , tidak ada masa aktif ,jika saldo konsumen habis maka akun otomatis terhapus

# instalasi PLugin Web panel Hidessh

```
wget github.com/FighterTunnel/tunnel/raw/main/plugins/hidessh/install-plugins.sh && bash install-plugins.sh
```

# Informasi Penting Vmess

kamu perlu mengubah lokasi file xray dan path sesuai dengan auto script kamu
perhatikan kode di bawah ini

```
uuid=$(cat /proc/sys/kernel/random/uuid)
masaaktif=90
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vmess$/a\#@ '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vmessgrpc$/a\#@ '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
```

**_1. lokasi config Xray Vmess_**

```
/etc/xray/config.json // lokasi file xray kamu
```

- ubah sesuai dengan lokasi file xray kamu

**_2. kamu juga bisa custom mau pakai uuid atau username_**

```
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
```

- jika kamu menggunakan username , ganti id dengan : $user
- jika kamu menggunakan uuid, ganti id dengan $uuid

**_3. edit Path sesuai script kamu_**

```
sed -i '/#vmess$/a\#@ '"$user $exp"'\
```

atau

```
sed -i '/#vmessgrpc$/a\#@ '"$user $exp"'\
```

- perhatihan kode diatas vmess
- jika kamu menggunakan path pribadi bisa mengubah ke path sesuai script kamu
- jika kamu memakai path whatever abaikan ini

**_3. pastikan add vmess dan del vmess sama_**

```
sed -i "/^#@ $user $exp/,/^},{/d" /etc/xray/config.json
```

- perhatikan kode diatas
- jika kamu menggunakan #@ di add vmess, di deleted akun vmess juga pelu #@
- wajib setiap protokol menggunakan kode yang berbeda

# Informasi Penting Trojan

kamu perlu mengubah lokasi file xray dan path sesuai dengan auto script kamu
perhatikan kode di bawah ini

```
masaaktif=90
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#trojan$/a\#& '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#trojan-grpc$/a\#& '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
```

**_1. lokasi config Xray Trojan_**

```
/usr/local/etc/xray/config.json // lokasi file xray kamu
```

- ubah sesuai dengan lokasi file xray kamu

**_2. kamu juga bisa custom mau pakai uuid atau username_**

```
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
```

- jika kamu menggunakan username , ganti id dengan : $user
- jika kamu menggunakan uuid, ganti id dengan $uuid

**_3. edit Path sesuai script kamu_**

```
sed -i '/#trojan$/a\#& '"$user $exp"'\
```

or

```
sed -i '/#trojan-grpc$/a\#& '"$user $exp"'\
```

- jika kamu menggunakan path pribadi bisa mengubah ke path sesuai script kamu
- jika kamu memakai path whatever abaikan ini

**_3. pastikan add vmess dan del vmess sama_**

```
sed -i "/^#& $user $exp/,/^},{/d" /usr/local/etc/xray/config.json
```

- perhatikan kode diatas
- jika kamu menggunakan #& di add vmess, di deleted akun vmess juga pelu #&
- wajib setiap protokol menggunakan kode yang berbeda

# Informasi Penting SSH

untuk ssh universal bisa digunakan untuk semua auto installer script

- jika kamu ingin menambahkan beberapa informasi seperti Port , Payload dll
  bisa di letahkan di bawah kode

```
echo -e "bugisisendiri:2082@$Login:$Pass"
```

# Edit Masa aktif

secara default sistem pay as you go akan menghapus secara otomatis , jika saldo konsumen kurang dari RP100, kamu juga mengatur secara manual di

```
masaaktif=30
```

artinya setiap pembuatan akun akun mempunya masa aktif 30 hari secara otomatis , setelah 30 hari maka akun otomatis terhapus

# kontak

jika kamu ingin mencoba atau testing bisa hub saya

- Telegram : t.me/riyan99s
- email : admin@hidessh.com
- Group : t.me/hidessh
