#!/bin/sh
mkdir -p ~/.local/share/fonts/commitmono-nerd
wget -q --show-progress --progress=bar:force:noscroll https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CommitMono.zip -O - | bsdtar -xvf- -C ~/.local/share/fonts/commitmono-nerd "CommitMonoNerdFontMono-*.otf"
printf "CommitMono Nerd Font has been installed.\n"
mkdir -p ~/.local/share/fonts/meslo-lgs-nerd
wget -q --show-progress --progress=bar:force:noscroll https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip -O - | bsdtar -xvf- -C ~/.local/share/fonts/meslo-lgs-nerd "MesloLGSNerdFontMono-*.ttf"
printf "Meslo Nerd Font has been installed.\n"
mkdir -p ~/.local/share/fonts/ubuntu-mono-nerd
wget -q --show-progress --progress=bar:force:noscroll https://github.com/ryanoasis/nerd-fonts/releases/latest/download/ubuntu_mono.zip -O - | bsdtar -xvf- -C ~/.local/share/fonts/ubuntu-mono-nerd "ubuntu_monoNerdFontMono-*.ttf"
printf "Ubuntu Mono Nerd Font has been installed.\n"
