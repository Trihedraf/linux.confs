#!/bin/sh
mkdir -p "$HOME/.local/share/fonts/commitmono-nerd" "$HOME/.local/share/fonts/meslo-lgs-nerd" "$HOME/.local/share/fonts/ubuntu-mono-nerd"
wget -q --show-progress --progress=bar:force:noscroll https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CommitMono.zip -O - | bsdtar -xvf- -C "$HOME/.local/share/fonts/commitmono-nerd" "CommitMonoNerdFontMono-*.otf"
printf "CommitMono Nerd Font has been installed.\n"
wget -q --show-progress --progress=bar:force:noscroll https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip -O - | bsdtar -xvf- -C "$HOME/.local/share/fonts/meslo-lgs-nerd" "MesloLGSNerdFontMono-*.ttf"
printf "Meslo Nerd Font has been installed.\n"
wget -q --show-progress --progress=bar:force:noscroll https://github.com/ryanoasis/nerd-fonts/releases/latest/download/UbuntuMono.zip -O - | bsdtar -xvf- -C "$HOME/.local/share/fonts/ubuntu-mono-nerd" "UbuntuMonoNerdFontMono-*.ttf"
printf "Ubuntu Mono Nerd Font has been installed.\n"
