#!/bin/bash
optList=$(getopt -o z:h --long zfs:,help -n 'debian.sh' -- "$@")
eval set -- "$optList"

zfsInstall=0

while true; do
    case "$1" in
        -z | --zfs)
            if [ "$2" = "ON" ]; then
                zfsInstall="1"
                elif [ "$2" = "OFF" ]; then
                zfsInstall="0"
            else
                echo "Error: Invalid option '$2'. Valid options are 'ON' and 'OFF'" >&2
            fi
            shift 2
        ;;
        -h | --help)
            printf "Usage: %s: [OPTION]\n" "$0"
            printf "    -h,--help           This help\n\n"
            printf "    Valid options for the following flags are ON and OFF.       Default\n"
            printf "    -z,--zfs            Enable or Disable ZFS install.          OFF\n"
            exit 2
        ;;
        *)
            break
        ;;
    esac
done

sudo sh -c 'echo "" > /etc/motd'

if sudo DEBIAN_FRONTEND=noninteractive apt-get install -y cockpit curl git ethtool iperf3 micro net-tools pipx resolvconf rsync samba screen shellcheck wget zsh; then
    sudo resolvconf -u
    sudo systemctl enable cockpit.socket
else
    exit
fi

if ! command -v tailscale > /dev/null 2>&1; then curl -fsSL https://tailscale.com/install.sh | sh; fi

if ! command -v docker > /dev/null 2>&1; then curl -fsSL https://get.docker.com | sh; fi && sudo usermod -aG docker "$(whoami)"

if git clone https://github.com/Trihedraf/linux.confs "$HOME/git/linux.confs"; then
    "$HOME/git/linux.confs/scripts/spfInstall.sh"
    "$HOME/git/linux.confs/scripts/configFiles.sh" -t || printf "terminal app configurations failed"
    "$HOME/git/linux.confs/scripts/shellConf.sh" || printf "shell configuration failed"
fi

if cd "$HOME/git/linux.confs"; then
    if sudo cp -rv ./debian-trixie/etc/* /etc/; then
        sudo sysctl -p /etc/sysctl.d/99-tailscale.conf
        sudo systemctl enable udpgroforwarding.service
        sudo rm /etc/apt/sources.list && sudo apt-get update
        if [ "$zfsInstall" = 1 ]; then
            sudo DEBIAN_FRONTEND=noninteractive apt-get install -y linux-headers-amd64 zfsutils-linux &&\
            sudo systemctl enable --now zfs-load-key.service &&\
            sudo pipx install --global zfs-autobackup
            git clone https://github.com/45drives/cockpit-zfs-manager.git "$HOME/git/cockpit-zfs" &&\
            sudo cp -rv "$HOME/git/cockpit-zfs/zfs" "/usr/share/cockpit"
        fi
    fi
fi

echo "run 'chsh -s /bin/zsh' to set your shell to zsh"
echo "Please change your NIC from eth0 to correct id in /etc/systemd/system/udpgroforwarding.service then start udpgroforwarding.service"
echo "Please add nameserver ip_address to /etc/resolvconf/resolv.conf.d/base"
