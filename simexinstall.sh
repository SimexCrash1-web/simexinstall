#!/bin/bash

# Warna
BLUE='\033[0;34m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

# Welcome
display_welcome() {
echo -e ""
echo -e "${RED} =============================================== ${NC}"
echo -e "${RED}               AUTO INSTALLER PANEL              ${NC}"
echo -e "${RED}                 BY SIMEX BACK                 ${NC}"
echo -e "${RED} =============================================== ${NC}"
sleep 3
}

# Check OS
check_os() {

source /etc/os-release
OS=$ID
VER=$VERSION_ID

if [[ "$OS" == "ubuntu" || "$OS" == "debian" ]]; then
echo -e "${GREEN}OS Terdeteksi: $OS $VER${NC}"
else
echo -e "${RED}OS tidak didukung script ini${NC}"
exit 1
fi

}

# Check Token
check_token() {

echo -e "${YELLOW}Masukkan Token Installer${NC}"
read -p "TOKEN : " USER_TOKEN

if [ "$USER_TOKEN" = "SimexCogan" ]; then
echo -e "${GREEN}TOKEN VALID${NC}"
sleep 1
clear
else
echo -e "${RED}TOKEN SALAH${NC}"
exit 1
fi

}

# Install Panel
install_panel() {

echo -e "${BLUE}Masukkan Subdomain Panel${NC}"
read -p "Domain : " domain

bash <(curl -s https://raw.githubusercontent.com/rafiadrian1/kuliah/main/autoinstall.sh) $domain true admin@gmail.com Simexganteng admin Simex true

echo -e ""
echo -e "${GREEN}INSTALL PANEL SELESAI${NC}"
sleep 2

}

# Create Node
create_node() {

echo -e "${BLUE}Input Domain Panel${NC}"
read -p "Domain : " domain

cd /var/www/pterodactyl || { echo "Folder panel tidak ditemukan"; exit 1; }

php artisan p:location:make <<EOF
SimexCogan
Auto Installer
EOF

php artisan p:node:make <<EOF
NODE-JS
Node By Simex
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
sleep 2

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

read -p "Pilih Menu : " menu

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