#!/bin/bash
if [ -d "$HOME/git/linux.confs" ]; then
    cd "$HOME/git/linux.confs" || exit
    git pull
else
    git clone https://github.com/Trihedraf/linux.confs "$HOME/git/linux.confs" || exit
fi

if [ -d "$HOME/git/linux.confs" ]; then
    "$HOME/git/linux.confs/scripts/configFiles.sh" -gt || printf "app configurations failed"
    "$HOME/git/linux.confs/scripts/shellConf.sh" || printf "shell configuration failed"
    "$HOME/git/linux.confs/scripts/fontInstall.sh" || printf "font install failed"
    sudo cp -v "$HOME/git/linux.confs/omarchy/etc/pacman.conf" /etc/pacman.conf || printf "pacman.conf failed to copy"
fi

sudo omarchy-update -y

sudo pacman -S --noconfirm --needed \
amd-ucode \
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
flatpak install flathub org.desktop_plus.desktop-plus

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

# Omarchy repo
sudo pacman -S --noconfirm --needed \
brave-bin \
rustdesk \
visual-studio-code-bin

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

"$HOME/git/linux.confs/scripts/configFiles.sh" -gto || printf "app configurations failed"
