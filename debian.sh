#!/bin/sh
sudo sh -c 'echo "" > /etc/motd'
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y cockpit curl git ethtool iperf3 micro net-tools pipx resolvconf rsync samba screen shellcheck wget zsh
sudo resolvconf -u
mkdir -pv ~/git
git clone https://github.com/Trihedraf/linux.confs ~/git/linux.confs
cd ~/git/linux.confs
sudo cp -rv debian-trixie/etc/* /etc/ && sudo rm /etc/apt/sources.list
sudo apt-get update
chmod +x ./install.sh
echo -e "1\n6\n\n0\n3\n4\n\n5\n\n0\n4\n3\n\n0\n0\n" | ./install.sh
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y linux-headers-amd64 zfsutils-linux zfs-auto-snapshot
sudo pipx install --global zfs-autobackup
git clone https://github.com/45drives/cockpit-zfs-manager.git ~/git/cockpit-zfs &&\
    sudo cp -rv ~/git/cockpit-zfs/zfs /usr/share/cockpit &&\
    sudo systemctl enable cockpit.socket
if ! command -v docker &> /dev/null; then curl -fsSL https://get.docker.com | sh; fi && sudo usermod -aG docker $(whoami)
curl -fsSL https://tailscale.com/install.sh | sh
sudo sysctl -p /etc/sysctl.d/99-tailscale.conf
sudo systemctl enable --now zfs-load-key.service
sudo systemctl enable udpgroforwarding.service && echo "Please change your NIC from eth0 to correct id in /etc/systemd/system/udpgroforwarding.service then start udpgroforwarding.service"
echo "Please add nameserver ip_address to /etc/resolvconf/resolv.conf.d/base"
