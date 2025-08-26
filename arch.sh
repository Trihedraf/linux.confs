#!/bin/sh
optList=$(getopt -o e:g:h --long etc:,gui:,help -n 'arch.sh' -- "$@")
eval set -- "$optList"

etcInstall=1
guiInstall=1

while true; do
    case "$1" in
        -e | --etc)
            if [ "$2" = "ON" ]; then
                etcInstall="1"
                elif [ "$2" = "OFF" ]; then
                etcInstall="0"
            else
                echo "Error: Invalid option '$2'. Valid options are 'ON' and 'OFF'" >&2
            fi
            shift 2
        ;;
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
            printf "    -e,--etc            Enable or Disable /etc configs install. ON\n"
            printf "    -g,--gui            Enable or Disable GUI apps install.     ON\n"
            exit 2
        ;;
        *)
            break
        ;;
    esac
done

sudo pacman -S --noconfirm --needed git

if git clone https://github.com/Trihedraf/linux.confs "$HOME/git/linux.confs"; then
    "$HOME/git/linux.confs/scripts/configFiles.sh" -t || printf "terminal app configurations failed"
    "$HOME/git/linux.confs/scripts/shellConf.sh" || printf "shell configuration failed"
    if [ "$etcInstall" = 1 ]; then
        "$HOME/git/linux.confs/scripts/configFiles.sh" -e || printf "/etc configurations failed"
    fi
    if [ "$guiInstall" = 1 ]; then
        "$HOME/git/linux.confs/scripts/fontInstall.sh" || printf "font install failed"
        "$HOME/git/linux.confs/scripts/configFiles.sh" -d || printf "desktop app configurations failed"
    fi
    if cd "$HOME/git/linux.confs"; then
        if sudo cp -rv ./archlinux/etc/* /etc/; then
            sudo sysctl -p /etc/sysctl.d/99-tailscale.conf
            sudo systemctl enable udpgroforwarding.service
        fi
    fi
fi

sudo pacman -S --noconfirm --needed base-devel cmake docker docker-buildx \
docker-compose fastfetch flatpak giflib lib32-giflib github-cli gnutls \
lib32-gnutls libpng lib32-libpng linux-tools man-db micro mingw-w64 ncurses \
lib32-ncurses screen shellcheck superfile sqlite lib32-sqlite tar tree tldr \
trash-cli unzip wget zip zsh

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

if ! command -v paru > /dev/null 2>&1; then
    git clone https://aur.archlinux.org/paru-bin.git "$HOME/git/paru-bin"
    if cd "$HOME/git/paru-bin"; then
        makepkg -si --noconfirm --needed &&\
        mkdir -pv ~/.config/paru/ &&\
        printf "[options]\nSkipReview\n" > ~/.config/paru/paru.conf
    fi
fi

paru -S multitail

if [ "$guiInstall" = 1 ]; then
    paru -S --noconfirm --needed alacritty brave-bin discord github-desktop \
    libreoffice-fresh steam visual-studio-code-bin alsa-lib lib32-alsa-lib \
    alsa-utils alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib \
    gst-plugins-base-libs lib32-gst-plugins-base-libs gtk2 gtk3 lib32-gtk2 \
    lib32-gtk3 libldap lib32-libldap libpulse lib32-libpulse libva lib32-libva \
    libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama openal \
    lib32-openal ocl-icd lib32-ocl-icd sdl2 lib32-sdl2 v4l-utils \
    lib32-v4l-utils vulkan-icd-loader lib32-vulkan-icd-loader
fi

echo "run 'chsh -s /bin/zsh' to set your shell to zsh"
echo "Please change your NIC from eth0 to correct id in /etc/systemd/system/udpgroforwarding.service then start udpgroforwarding.service"
