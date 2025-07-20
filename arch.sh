#!/bin/sh
sudo cp -v ./archlinux/etc/pacman.conf /etc/pacman.conf

sudo pacman -S --noconfirm --needed base-devel cmake docker docker-buildx \
    docker-compose fastfetch flatpak giflib lib32-giflib git github-cli gnutls \
    lib32-gnutls libpng lib32-libpng linux-tools man-db micro mingw-w64 \
    ncurses lib32-ncurses screen shellcheck superfile sqlite lib32-sqlite tar \
    tree tldr trash-cli unzip wget zip zsh

sudo flatpak remote-add --if-not-exists flathub \
    https://flathub.org/repo/flathub.flatpakrepo

mkdir -pv ~/git
git clone https://github.com/Trihedraf/linux.confs ~/git/linux.confs &&\
    cd ~/git/linux.confs &&\
    chmod +x ./install.sh &&\
    printf "1\n6\n\n0\n3\n4\n\n5\n\n0\n4\n3\n\n0\n0\n" | ./install.sh

git clone https://aur.archlinux.org/paru.git ~/git/paru &&\
    cd ~/git/paru &&\
    makepkg -si --noconfirm --needed &&\
    mkdir -pv ~/.config/paru/ &&\
    printf "[options]\nSkipReview\n" > ~/.config/paru/paru.conf

paru -S multitail
