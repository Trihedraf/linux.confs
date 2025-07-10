#!/bin/sh
sudo pacman -S --noconfirm --needed base-devel cmake docker docker-buildx \
    docker-compose fastfetch flatpak giflib lib32-giflib github-cli git gnutls \
    lib32-gnutls libpng lib32-libpng make man-db micro ncurses \
    lib32-ncurses screen shellcheck sudo superfile sqlite lib32-sqlite tar \
    tree tldr trash-cli unzip wget zip 

sudo flatpak remote-add --if-not-exists flathub \
    https://flathub.org/repo/flathub.flatpakrepo

mkdir -pv ~/git
git clone https://github.com/Trihedraf/linux.confs ~/git/linux.confs &&\
    cd ~/git/linux.confs &&\
    chmod +x ./install.sh &&\
    printf "1\n1\n\n0\n3\n4\n\n5\n\n0\n4\n3\n\n0\n0\n" | ./install.sh

git clone https://aur.archlinux.org/paru.git ~/git/paru &&\
    cd ~/git/paru &&\
    makepkg -si --noconfirm --needed &&\
    mkdir -pv ~/.config/paru/ &&\
    printf "[options]\nSkipReview\n" > ~/.config/paru/paru.conf

paru -S multitail
