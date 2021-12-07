#!/bin/bash

apt install sudo

sudo apt update
sudo apt upgrade -y
sudo apt install tmux mtr npm dnsutils htop rsync zsh git vim curl wget unzip gnupg socat iperf3 -y

npm -i nali-cli -g

wget https://nginx.org/keys/nginx_signing.key
apt-key add nginx_signing.key
echo "deb https://nginx.org/packages/mainline/debian/ buster nginx" >> /etc/apt/sources.list
echo "deb-src https://nginx.org/packages/mainline/debian/ buster nginx" >> /etc/apt/sources.list
sudo apt update
sudo apt install nginx -y

wget https://github.com/p4gefau1t/trojan-go/releases/download/v0.10.6/trojan-go-linux-amd64.zip
unzip -o trojan-go-linux-amd64.zip -d /usr/local/bin/trojan-go
mkdir -p /usr/local/etc/trojan-go
curl -L https://raw.githubusercontent.com/H3arn/my-vps-scripts/master/trojan-go.service -o /etc/systemd/system/trojan-go.service 

curl https://get.acme.sh | sh

sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s /usr/bin/zsh 

git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
