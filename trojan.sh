#!/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt install vim curl wget unzip gnupg socat -y

wget https://nginx.org/keys/nginx_signing.key
apt-key add nginx_signing.key
echo "deb https://nginx.org/packages/mainline/debian/ buster nginx" >> /etc/apt/sources.list
echo "deb-src https://nginx.org/packages/mainline/debian/ buster nginx" >> /etc/apt/sources.list
sudo apt update
sudo apt install nginx -y

wget https://github.com/p4gefau1t/trojan-go/releases/download/v0.10.6/trojan-go-linux-amd64.zip
unzip -o trojan-go-linux-amd64.zip -d /usr/local/bin/trojan-go
mkdir -p /usr/local/etc/trojan-go
