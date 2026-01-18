#!/bin/bash

# cat <<EOF >> /etc/sysctl.d/70-disable-ipv6.conf 
# net.ipv6.conf.all.disable_ipv6 = 1
# net.ipv6.conf.default.disable_ipv6 = 1
# net.ipv6.conf.lo.disable_ipv6 = 1
# EOF

# sysctl --system

#USER_HOME="$(getent passwd $USER 2>/dev/null | cut -d: -f6)"
#echo $USER_HOME > /USER_HOME.log
#pwd > /pwd.log
apt install sudo

sudo apt update
sudo apt upgrade -y
sudo apt install tmux mtr-tiny iotop iftop dnsutils htop btop rsync zsh git vim curl wget unzip ufw tree ca-certificates -y

apt autoremove -y
apt clean

cd

curl https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o install.sh &&
    sed -i 's/CHSH=no/CHSH=yes/g' install.sh &&
    echo "Y" | sh install.sh 

rm install.sh

git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

# rm ~/.zshrc
cat <<EOF > ~/.zshrc
export ZSH="\$HOME/.oh-my-zsh"
ZSH_THEME="random"
plugins=(git fast-syntax-highlighting)
source \$ZSH/oh-my-zsh.sh
EOF

# rm /etc/sysctl.d/70-disable-ipv6.conf 
# sysctl --system
