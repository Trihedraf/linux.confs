#!/bin/bash
GIT_DIR="$HOME/git/linux.confs"
SCRIPT_DIR=$(cd "$(dirname "$(realpath "$0")")" && pwd)
if [ "$SCRIPT_DIR" = "$GIT_DIR" ]; then
    cd "$GIT_DIR" || exit
else
    git clone https://github.com/Trihedraf/linux.confs "$GIT_DIR" || exit
    exec "$GIT_DIR/omarchy.sh" "$@"
    exit
fi

sudo cp -v "$GIT_DIR/omarchy/etc/pacman.conf" /etc/pacman.conf || printf "pacman.conf failed to copy"
omarchy-update -y || exit

sudo pacman -S --noconfirm --needed \
arch-wiki-docs \
arch-wiki-lite \
cmake \
devtools \
dmidecode \
ethtool \
fail2ban \
fwupd \
gimp \
github-cli \
lib32-gnutls \
htop \
iperf3 \
kitty-terminfo \
linux-tools \
man-pages \
micro \
mingw-w64 \
msmtp \
nano \
lib32-ncurses \
net-tools \
nfs-utils \
nmap \
pv \
samba \
screen \
shellcheck \
smartmontools \
superfile \
lib32-sqlite \
syncthing \
terminus-font \
tree \
trash-cli \
wget \
wikiman

# Libraries for GUI
sudo pacman -S --noconfirm --needed \
lib32-alsa-lib \
alsa-plugins lib32-alsa-plugins \
flatpak \
gamemode lib32-gamemode \
gamescope \
lib32-gtk3 \
lib32-libgcrypt \
lib32-libgpg-error \
lib32-libjpeg-turbo \
lib32-libldap \
lib32-libpng \
lib32-libpulse \
lib32-libva \
lib32-libxcomposite \
lib32-libxinerama \
lib32-mesa \
lib32-ocl-icd \
lib32-opencl-icd-loader \
protontricks \
lib32-sdl3 \
vkd3d lib32-vkd3d \
lib32-vulkan-icd-loader \
vulkan-radeon lib32-vulkan-radeon \
wine \
wine-gecko \
wine-mono \
winetricks

# GUI Applications
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo && echo "Flathub repo added"
flatpak install flathub org.desktop_plus.desktop-plus -y

sudo pacman -S --noconfirm --needed \
discord \
ghostty \
ghostty-shell-integration \
ghostty-terminfo \
goverlay \
keepassxc \
lutris \
mangohud lib32-mangohud \
steam \
umu-launcher \
virt-manager \
vlc \
xclip

## Omarchy repo
sudo pacman -S --noconfirm --needed \
brave-bin \
rustdesk \
visual-studio-code-bin

"$GIT_DIR/scripts/configFiles.sh" -gto || printf "app configurations failed"
"$GIT_DIR/scripts/shellConf.sh" || printf "shell configuration failed"
"$GIT_DIR/scripts/fontInstall.sh" || printf "font install failed"

# Omarchy plugins
## Settings Panel
omarchy plugin add https://github.com/twiking/omasettings.git --enable --yes
## Better Default Apps
omarchy plugin add https://github.com/nightdevil00/setup.defaults.git --enable --yes
## Lockscreen Plugin/Setup
omarchy plugin add https://github.com/SirJul1337/omarchy-lock-explorer.git --enable --yes && \
    "$HOME/.config/omarchy/plugins/io.github.sirjul1337.lock-explorer/extras/install.sh" && \
    omarchy-shell lock setMenuEntry on && \
    omarchy-shell lock setFieldItem caps hide && \
    omarchy-shell lock setFieldItem reveal hide && \
    omarchy-shell lock setFieldItem icons hide && \
    omarchy-shell lock setFieldItem layout hide && \
    omarchy-shell lock setDesign my-classic

