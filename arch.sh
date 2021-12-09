#!/bin/bash

pacman -S sudo wget vim vi nano git zsh tmux mtr npm dnsutils htop rsync unzip gnupg socat iperf3 nginx wipe cron crontab

# get trojan-go
wget https://github.com/p4gefau1t/trojan-go/releases/download/v0.10.6/trojan-go-linux-amd64.zip
unzip -o trojan-go-linux-amd64.zip -d /usr/local/bin/trojan-go
mkdir -p /usr/local/etc/trojan-go
curl -L https://raw.githubusercontent.com/H3arn/cmy-vps-scripts/master/trojan-go.service -o /etc/systemd/system/trojan-go.service 

# install paru
sudo vim /etc/pacman.conf
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru-bin.git
cd paru
makepkg -si

# add locale and pacman color
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
cat << EOT >> /etc/pacman.conf
[archlinuxcn]
Server = https://repo.archlinuxcn.org/\$arch
EOT
cat /etc/pacman.conf | grep Color

# network optimization
touch /etc/sysctl.d/99-sysctl.conf
cat << EOT >> /etc/sysctl.d/99-sysctl.conf
net.core.netdev_max_backlog = 30000
net.core.rmem_max = 67108864
net.core.wmem_max = 67108864
net.ipv4.tcp_wmem = 4096 12582912 33554432
net.ipv4.tcp_rmem = 4096 12582912 33554432
net.ipv4.tcp_max_syn_backlog = 80960
net.ipv4.tcp_slow_start_after_idle = 0
net.ipv4.tcp_tw_reuse = 1
net.ipv4.ip_local_port_range = 10240 65535
net.ipv4.tcp_abort_on_overflow = 1
net.ipv4.tcp_congestion_control = bbr
net.core.default_qdisc = cake
net.ipv4.tcp_syncookies = 1 
EOT

# set up new user archie
useradd -m -G "wheel" "archie"
visudo
sudo su archie

# get acme.sh
curl https://get.acme.sh | sh

# install oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s /usr/bin/zsh 

git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

curl -L https://raw.githubusercontent.com/H3arn/my-vps-scripts/master/.zshrc -o /home/archie/.zshrc

