#!/bin/bash
optList=$(getopt -o g:h --long ,gui:,help -n 'arch.sh' -- "$@")
eval set -- "$optList"

guiInstall=0

while true; do
    case "$1" in
        -g | --gui)
            if [ "$2" = "ON" ]; then
                guiInstall="1"
                elif [ "$2" = "OFF" ]; then
                guiInstall="0"
            else
                echo "Error: Invalid option '$2'. Valid options are 'ON' and 'OFF'" >&2
            fi
            shift 2
        ;;
        -h | --help)
            printf "Usage: %s: [OPTION]\n" "$0"
            printf "    -h,--help           This help\n\n"
            printf "    Valid options for the following flags are ON and OFF.       Default\n"
            printf "    -g,--gui            Enable or Disable GUI apps install.     OFF\n"
            exit 2
        ;;
        *)
            break
        ;;
    esac
done

sudo pacman -Syy --noconfirm --needed git wget

if [ -d "$HOME/git/linux.confs" ]; then
    cd "$HOME/git/linux.confs"
    git pull
else 
    git clone https://github.com/Trihedraf/linux.confs "$HOME/git/linux.confs"
fi

if [ -d "$HOME/git/linux.confs" ]; then
    "$HOME/git/linux.confs/scripts/configFiles.sh" -at || printf "terminal app configurations failed"
    "$HOME/git/linux.confs/scripts/shellConf.sh" || printf "shell configuration failed"
    if [ "$guiInstall" = 1 ]; then
        "$HOME/git/linux.confs/scripts/fontInstall.sh" || printf "font install failed"
        "$HOME/git/linux.confs/scripts/configFiles.sh" -g || printf "desktop app configurations failed"
    fi
    if cd "$HOME/git/linux.confs"; then
        if sudo cp -rv ./archlinux/etc/* /etc/; then
            sudo sysctl -p /etc/sysctl.d/99-tailscale.conf
            sudo systemctl enable udpgroforwarding.service
        fi
    fi
fi

sudo pacman -Syy --noconfirm --needed \
base-devel \
bat \
btop \
cmake \
devtools \
docker \
docker-buildx \
docker-compose \
ethtool \
fastfetch \
github-cli \
gnutls lib32-gnutls\
htop \
iperf3 \
linux-tools \
man-db \
man-pages \
micro \
mingw-w64 \
msmtp \
ncurses \
lib32-ncurses \
net-tools \
nfs-utils \
samba \
screen \
shellcheck 
superfile \
sqlite \
lib32-sqlite \
tar \
tree \
tldr \
trash-cli \
unzip \
wget \
zip \


if [ "$guiInstall" = 1 ]; then
    # Libraries for GUI
    sudo pacman -Syy --noconfirm --needed \
    alsa-lib lib32-alsa-lib \
    alsa-plugins lib32-alsa-plugins \
    alsa-utils \
    flatpak \
    gamemode lib32-gamemode \
    gamescope \
    giflib lib32-giflib \
    gst-plugins-base-libs lib32-gst-plugins-base-libs \
    gtk3 lib32-gtk3 \
    libgcrypt lib32-libgcrypt \
    libgpg-error lib32-libgpg-error \
    libjpeg-turbo lib32-libjpeg-turbo \
    libldap lib32-libldap \
    libpng lib32-libpng \
    libpulse lib32-libpulse \
    libva lib32-libva \
    libxcomposite lib32-libxcomposite \
    libxinerama lib32-libxinerama \
    libxslt lib32-libxslt \
    mesa lib32-mesa \
    mpg123 lib32-mpg123 \
    ocl-icd lib32-ocl-icd \
    openal lib32-openal \
    opencl-icd-loader lib32-opencl-icd-loader \
    sdl2-compat lib32-sdl2-compat \
    sdl3 lib32-sdl3 \
    v4l-utils lib32-v4l-utils \
    vulkan-icd-loader lib32-vulkan-icd-loader \
    vulkan-radeon lib32-vulkan-radeon

    # GUI Applications
    sudo pacman -Syy --noconfirm --needed \
    alacritty \
    discord \
    ghostty \
    goverlay \
    kitty \
    libreoffice-fresh \
    lutris \
    mangohud lib32-mangohud \
    steam \
    xclip wl-clipboard

    # ART GUI Applications
    sudo pacman -Syy --noconfirm --needed \
    brave-bin \
    github-desktop-plus-bin \
    visual-studio-code-bin
    
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo && echo "Flathub repo added"

fi