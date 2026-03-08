#!/bin/bash

# Color
BLUE='\033[0;34m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

# Welcome
display_welcome() {
echo -e ""
echo -e "${RED}===============================================${NC}"
echo -e "${RED}            AUTO INSTALLER PANEL              ${NC}"
echo -e "${RED}               BY THOMZ STORE                 ${NC}"
echo -e "${RED}===============================================${NC}"
sleep 3
}

# Check OS
check_os() {
source /etc/os-release
OS=$ID
VER=$VERSION_ID

if [[ "$OS" == "ubuntu" || "$OS" == "debian" ]]; then
echo -e "${GREEN}OS detected: $OS $VER${NC}"
else
echo -e "${RED}OS tidak didukung${NC}"
exit 1
fi
}

# Token
check_token() {
echo ""
echo -e "${YELLOW}Masukkan TOKEN installer${NC}"
read -r USER_TOKEN

if [ "$USER_TOKEN" = "Thomvelz" ]; then
echo -e "${GREEN}TOKEN VALID${NC}"
else
echo -e "${RED}TOKEN SALAH${NC}"
exit 1
fi
sleep 1
clear
}

# Install Panel
install_panel() {

while true
do

echo ""
echo "Lanjut install panel? (y/n)"
read -r install

case $install in

y|Y)

echo ""
read -p "Masukkan Subdomain Panel: " domain

bash <(curl -s https://raw.githubusercontent.com/rafiadrian1/kuliah/main/autoinstall.sh) $domain true admin@gmail.com thomzganteng admin thomz true

echo -e "${GREEN}INSTALL PANEL SELESAI${NC}"
break
;;

n|N)
return
;;

*)
echo "Input salah"
;;

esac

done

}

# Create Node
create_node() {

echo ""
read -p "Masukkan domain panel: " domain

cd /var/www/pterodactyl || { echo "Panel tidak ditemukan"; exit 1; }

php artisan p:location:make <<EOF
Thomz
Auto Installer
EOF

php artisan p:node:make <<EOF
NodeJS
Node by Thomz
1
https
$domain
yes
no
no
100000
0
100000
0
100
8080
2022
/var/lib/pterodactyl/volumes
EOF

echo -e "${GREEN}NODE BERHASIL DIBUAT${NC}"
}

# MAIN
display_welcome
check_os
check_token

while true
do

echo ""
echo "1. Install Panel"
echo "2. Create Node"
echo "x. Exit"
echo ""

read -p "Pilih menu: " menu

case $menu in

1)
install_panel
;;

2)
create_node
;;

x)
exit
;;

*)
echo "Menu tidak valid"
;;

esac

done
