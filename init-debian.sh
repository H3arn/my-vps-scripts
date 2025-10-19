#!/bin/bash

apt install sudo

sudo apt update
sudo apt upgrade -y
sudo apt install tmux mtr iotop iftop dnsutils htop rsync zsh git vim curl wget unzip ufw tree -y

sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release 
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

apt autoremove -y
apt clean

cd

curl https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o install.sh &&
    sed -i 's/CHSH=no/CHSH=yes/g' install.sh &&
    echo "Y" | sh install.sh 

rm install.sh

git clone https://github.com/z-shell/F-Sy-H.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/F-Sy-H

rm ~/.zshrc

cat <<EOF > ~/.zshrc
export ZSH="\$HOME/.oh-my-zsh"
ZSH_THEME="random"
plugins=(git F-Sy-H)
source \$ZSH/oh-my-zsh.sh
EOF
