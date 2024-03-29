#!/bin/bash

pacman -S tree sudo wget vim nano git zsh tmux mtr dnsutils htop rsync unzip gnupg socat iperf3 nginx wipe cron nmap ufw docker docker-compose neofetch

# ufw allow 443
# ufw allow 8443

vim /etc/ssh/sshd_config
mkdir .ssh
vim .ssh/authorized_keys
systemctl restart sshd

# get trojan-go
# wget https://github.com/p4gefau1t/trojan-go/releases/download/v0.10.6/trojan-go-linux-amd64.zip
# unzip -o trojan-go-linux-amd64.zip -d /usr/local/bin/trojan-go
# mkdir -p /usr/local/etc/trojan-go
# curl -L https://raw.githubusercontent.com/H3arn/my-vps-scripts/master/trojan-go.service -o /etc/systemd/system/trojan-go.service

# add locale and pacman color
#echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
vim /etc/pacman.conf
#echo "Color" >>  /etc/pacman.conf

# add archcn repo
cat << EOT >> /etc/pacman.conf
[archlinuxcn]
Server = https://repo.archlinuxcn.org/\$arch
EOT

pacman -Syy

#echo "Color" >> /etc/pacman.conf  

ls -al /etc/sysctl.d/

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

# reboot

sysctl --system

# enable NTP sync
systemctl enable --now systemd-timesyncd

# set up new user archie
useradd -m -G "wheel" archie
visudo
sudo su archie
cd
mkdir .ssh
sudo cp /root/.ssh/authorized_keys ~/.ssh/authorized_keys

# install paru
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -si

# install oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s /usr/bin/zsh 

# F-Sy-H
git clone https://github.com/z-shell/F-Sy-H.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/F-Sy-H

# get acme.sh
curl https://get.acme.sh | sh

# starship prompt
curl -sS https://starship.rs/install.sh | sh

# curl -L https://raw.githubusercontent.com/H3arn/my-vps-scripts/master/.zshrc -o /home/archie/.zshrc

# install webhook bot
# wget https://github.com/KunoiSayami/github-webhook-notification.rs/releases/latest/download/github-webhook-notification_linux_amd64
# chmod +x github-webhook-notification_linux_amd64
# sudo cp github-webhook-notification_linux_amd64 /usr/local/bin/
# sudo curl -L https://raw.githubusercontent.com/H3arn/github-webhook-notification.rs/master/gh-wbhk-tg.service -o /etc/systemd/system/gh-wbhk-tg.service
# sudo touch /usr/local/etc/gh-wbhk-tg/config.toml

