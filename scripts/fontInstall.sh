#!/bin/sh

allFonts=
while getopts azh? name
do
    case $name in
        a)      allFonts=1;;
        h|?)    printf "Usage: %s: [OPTION]\n" "$0"
            printf "\-h, -?  This help\n"
            printf "\-a      Install all Fonts\n"
        exit 2;;
    esac
done
shift $((OPTIND - 1))

commit_mono()
{
    mkdir -p ~/.local/share/fonts/commitmono-nerd
    wget -q --show-progress --progress=bar:force:noscroll https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CommitMono.zip -O - | bsdtar -xvf- -C ~/.local/share/fonts/commitmono-nerd "CommitMonoNerdFontMono-*.otf"
    printf "CommitMono Nerd Font has been installed.\n"
}

meslo_lgs() {
    mkdir -p ~/.local/share/fonts/meslo-lgs-nerd
    wget -q --show-progress --progress=bar:force:noscroll https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip -O - | bsdtar -xvf- -C ~/.local/share/fonts/meslo-lgs-nerd "MesloLGSNerdFontMono-*.ttf"
    printf "Meslo Nerd Font has been installed.\n"
}

ubuntu_mono() {
    mkdir -p ~/.local/share/fonts/ubuntu-mono-nerd
    wget -q --show-progress --progress=bar:force:noscroll https://github.com/ryanoasis/nerd-fonts/releases/latest/download/ubuntu_mono.zip -O - | bsdtar -xvf- -C ~/.local/share/fonts/ubuntu-mono-nerd "ubuntu_monoNerdFontMono-*.ttf"
    printf "Ubuntu Mono Nerd Font has been installed.\n"
}

all_Fonts() {
    commit_mono
    meslo_lgs
    ubuntu_mono
}

font_menu()
{
    
    while true; do
        #Display the menu
        clear
        printf "\n  Please select an option:\n\n"
        printf "    1. Install CommitMono Nerd Font\n"
        printf "    2. Install Meslo LGS Nerd Font\n"
        printf "    3. Install Ubuntu Mono Nerd Font\n"
        printf "    4. Install all Fonts\n"
        printf "    0. Return to main menu\n"
        printf "\n  Enter your choice (0-3): "
        read -r font_choice
        printf "\n\n"
        
        case "$font_choice" in
            1)
                commit_mono
            ;;
            2)
                meslo_lgs
            ;;
            3)
                ubuntu_mono
            ;;
            4)
                all_Fonts
            ;;
            0)
                break
            ;;
        esac
        printf "\n  Press enter to continue..."
        read -r font_choice
    done
}

if [ -n "$allFonts" ]; then
    all_Fonts
fi
