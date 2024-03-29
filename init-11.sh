#!/bin/bash

apt install sudo

sudo apt update
sudo apt upgrade -y
sudo apt install tmux mtr dnsutils htop rsync zsh git vim curl wget unzip gnupg socat iperf3 ufw tree apache2-utils sqlite3 speedtest-cli neofetch -y

vim /etc/ssh/sshd_config

mkdir .ssh
echo "" >> .ssh/authorized_keys

service sshd restart

# ufw allow 443
# ufw allow 2083
# ufw allow 2087
# ufw allow 2096
# ufw allow 8443
#npm -i nali-cli -g

# docker
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
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# nginx mainline
sudo apt install curl gnupg2 ca-certificates lsb-release debian-archive-keyring
curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
    | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
gpg --dry-run --quiet --no-keyring --import --import-options import-show /usr/share/keyrings/nginx-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
http://nginx.org/packages/mainline/debian `lsb_release -cs` nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list
echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" \
    | sudo tee /etc/apt/preferences.d/99nginx
sudo apt update
sudo apt install nginx


# wget https://github.com/p4gefau1t/trojan-go/releases/download/v0.10.6/trojan-go-linux-amd64.zip
# unzip -o trojan-go-linux-amd64.zip -d /usr/local/bin/trojan-go
# mkdir -p /usr/local/etc/trojan-go
# curl -L https://raw.githubusercontent.com/H3arn/my-vps-scripts/master/trojan-go.service -o /etc/systemd/system/trojan-go.service

# acme.sh
curl https://get.acme.sh | sh

# NTP
apt install systemd-timesyncd
systemctl enable --now systemd-timesyncd

# oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#chsh -s /usr/bin/zsh

# F-Sy-H
git clone https://github.com/z-shell/F-Sy-H.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/F-Sy-H

# starship.rs shell prompt
curl -sS https://starship.rs/install.sh | sh

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

sysctl --system
