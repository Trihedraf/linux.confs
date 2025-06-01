sudo sh -c 'echo "" > /etc/motd'
sudo apt-get install -y git micro curl wget rsync screen cockpit samba
mkdir ~/git &&\
    git clone https://github.com/Trihedraf/linux.confs ~/git/linux.confs &&\
    cd ~/git/linux.confs &&\
    chmod +x ./install.sh &&\
    echo -e "1\n1\n\n0\n3\n4\n\n5\n\n0\n4\n3\n\n0\n0\n" | ./install.sh
sudo apt update
sudo apt-get install -y linux-headers-amd64 zfsutils-linux zfs-auto-snapshot
git clone https://github.com/45drives/cockpit-zfs-manager.git ~/git/cockpit-zfs &&\
    sudo systemctl enable cockpit.socket &&\
    sudo cp -r ~/git/cockpit-zfs/zfs /usr/share/cockpit
curl -fsSL get.docker.com | sh
sudo usermod -aG docker $(whoami)
curl -fsSL https://tailscale.com/install.sh | sh
sudo sysctl -p /etc/sysctl.d/99-tailscale.conf
sudo systemctl enable --now udpgroforwarding.service