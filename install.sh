#!/bin/sh

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

checkPackageManager() {
    ## Check Package Manager
    PACKAGEMANAGER=$1
    for pgm in ${PACKAGEMANAGER}; do
        if command_exists "${pgm}"; then
            PACKAGER=${pgm}
            printf "%b\n" "${CYAN}Using ${pgm} as package manager${RC}"
            break
        fi
    done
    
    if [ -z "$PACKAGER" ]; then
        printf "%b\n" "${RED}Can't find a supported package manager${RC}"
        exit 1
    fi
}

bash_menu()
{
    while true; do
        # Display the menu
        clear
        printf "\n  Please select an option:\n\n"
        printf "    1. Install all bash files\n"
        printf "    2. Update .bashrc\n"
        printf "    3. Update .bash/aliases\n"
        printf "    4. Update .bash/functions\n"
        printf "    5. Update .bash/prompt\n"
        printf "    0. Return to main menu\n"
        printf "\n  Enter your choice (0-5): "
        read -r bash_choice
        printf "\n\n"
        
        case "$bash_choice" in
            1)
                mkdir -p ~/.bash
                [ ! -f ~/.bashrc ] || mv -v ~/.bashrc ~/.bashrc.bak
                cp -v .bashrc ~/.bashrc
                [ ! -f ~/.bash/aliases ] || mv -v ~/.bash/aliases ~/.bash/aliases.bak
                cp -v .bash/aliases ~/.bash/aliases
                [ ! -f ~/.bash/functions ] || mv -v ~/.bash/functions ~/.bash/functions.bak
                cp -v .bash/functions ~/.bash/functions
                [ ! -f ~/.bash/prompt ] || mv -v ~/.bash/prompt ~/.bash/prompt.bak
                cp -v .bash/prompt ~/.bash/prompt
                printf "All bash files have been installed. Please run . ~/.bashrc or logout and back in to enable the bash files.\n"
                printf "\n  Press enter to continue..."
                read -r bash_choice
            ;;
            2)
                [ ! -f ~/.bashrc ] || mv -v ~/.bashrc ~/.bashrc.bak
                cp -v .bashrc ~/.bashrc
                printf "Please run . ~/.bashrc or logout and back in to reload the .bashrc.\n"
                printf "\n  Press any key to continue..."
                read -r bash_choice
            ;;
            3)
                mkdir -p ~/.bash
                [ ! -f ~/.bash/aliases ] || mv -v ~/.bash/aliases ~/.bash/aliases.bak
                cp -v .bash/aliases ~/.bash/aliases
                printf "Please run . ~/.bashrc or logout and back in to reload the aliases.\n"
                printf "\n  Press enter to continue..."
                read -r bash_choice
            ;;
            4)
                mkdir -p ~/.bash
                [ ! -f ~/.bash/functions ] || mv -v ~/.bash/functions ~/.bash/functions.bak
                cp -v .bash/functions ~/.bash/functions
                printf "Please run . ~/.bashrc or logout and back in to reload the functions.\n"
                printf "\n  Press enter to continue..."
                read -r bash_choice
            ;;
            5)
                mkdir -p ~/.bash
                [ ! -f ~/.bash/prompt ] || mv -v ~/.bash/prompt ~/.bash/prompt.bak
                cp -v .bash/prompt ~/.bash/prompt
                printf "Please run . ~/.bashrc or logout and back in to reload the prompt.\n"
                printf "\n  Press enter to continue..."
                read -r bash_choice
            ;;
            0)
                break
            ;;
        esac
    done
}

native_package_menu()
{
    while true; do
        # Display the menu
        clear
        printf "\n  Please select an option:\n\n"
        printf "    1. Install Alacritty\n"
        printf "    0. Return to main menu\n"
        printf "\n  Enter your choice (0-1): "
        read -r package_manager_choice
        printf "\n\n"
        
        case "$package_manager_choice" in
            1)
                checkPackageManager "apt-get dnf pacman nala zypper"
                case "$PACKAGER" in
                    apt-get|nala)
                        sudo "$PACKAGER" update
                        sudo "$PACKAGER" install -y alacritty
                        printf "\nAlacritty has been installed.\n"
                        printf "\n  Press enter to continue..."
                        read -r package_manager_choice
                    ;;
                    pacman)
                        sudo "$PACKAGER" -S --noconfirm alacritty
                        printf "\nAlacritty has been installed.\n"
                        printf "\n  Press enter to continue..."
                        read -r package_manager_choice
                    ;;
                    dnf)
                        sudo "$PACKAGER" update
                        sudo "$PACKAGER" install -y alacritty
                        printf "\nAlacritty has been installed.\n"
                        printf "\n  Press enter to continue..."
                        read -r package_manager_choice
                    ;;
                    zypper)
                        sudo "$PACKAGER" --non-interactive install -y alacritty
                        printf "\nAlacritty has been installed.\n"
                        printf "\n  Press enter to continue..."
                        read -r package_manager_choice
                    ;;
                esac
            ;;
            0)
                break
            ;;
        esac
    done
}

#appimage_menu()
#{
#    while true; do
#        # Display the menu
#        clear
#        printf "\n  Please select an option:\n\n"
#        printf "    1. \n"
#        printf "    0. Return to main menu\n"
#        printf "\n  Enter your choice (0-1): "
#        read -r appimage_choice
#        printf "\n\n"

#        case "$appimage_choice" in
#            1)
#                fdsa
#            ;;
#            0)
#                break
#            ;;
#        esac
#    done
#}

#tabby_appimage_install()
#{
#    mkdir -p ~/.local/bin
#    wget -qO - https://github.com/Eugeny/tabby/releases/latest/download/latest-x64-linux.yml | \
#    grep -oE 'tabby.*AppImage' | \
#    while read -r filename; do
#        if [ ! -f "$HOME/.local/bin/$filename" ]; then
#            printf "Latest Tabby AppImage not found. Remove any existing Tabby AppImages and Downloading Latest...\n"
#            find "$HOME/.local/bin/" -type f,l -name "tabby*.AppImage" -delete
#            wget -q --show-progress --progress=bar:force:noscroll -O "$HOME/.local/bin/$filename" "https://github.com/Eugeny/tabby/releases/latest/download/$filename"
#            chmod +x "$HOME/.local/bin/$filename"
#            ln -s "$HOME/.local/bin/$filename" "$HOME/.local/bin/tabby.AppImage"
#            printf "Latest Tabby AppImage has been installed.\n"
#            break
#        else
#            printf "Latest Tabby AppImage already exists. Skipping...\n"
#            break
#        fi
#    done
#}

font_menu()
{
    while true; do
        #Display the menu
        clear
        printf "\n  Please select an option:\n\n"
        printf "    1. Install CommitMono Nerd Font\n"
        printf "    2. Install Meslo LGS Nerd Font\n"
        printf "    3. Install Ubuntu Mono Nerd Font\n"
        printf "    0. Return to main menu\n"
        printf "\n  Enter your choice (0-3): "
        read -r font_choice
        printf "\n\n"
        
        case "$font_choice" in
            1)
                mkdir -p ~/.local/share/fonts/commitmono-nerd
                wget -q --show-progress --progress=bar:force:noscroll https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CommitMono.zip -O - | bsdtar -xvf- -C ~/.local/share/fonts/commitmono-nerd "CommitMonoNerdFontMono-*.otf"
                printf "CommitMono Nerd Font has been installed.\n"
                printf "\n  Press enter to continue..."
                read -r font_choice
            ;;
            2)
                mkdir -p ~/.local/share/fonts/meslo-lgs-nerd
                wget -q --show-progress --progress=bar:force:noscroll https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip -O - | bsdtar -xvf- -C ~/.local/share/fonts/meslo-lgs-nerd "MesloLGSNerdFontMono-*.ttf"
                printf "Meslo Nerd Font has been installed.\n"
                printf "\n  Press enter to continue..."
                read -r font_choice
            ;;
            3)
                mkdir -p ~/.local/share/fonts/ubuntu-mono-nerd
                wget -q --show-progress --progress=bar:force:noscroll https://github.com/ryanoasis/nerd-fonts/releases/latest/download/UbuntuMono.zip -O - | bsdtar -xvf- -C ~/.local/share/fonts/ubuntu-mono-nerd "UbuntuMonoNerdFontMono-*.ttf"
                printf "Ubuntu Mono Nerd Font has been installed.\n"
                printf "\n  Press enter to continue..."
                read -r font_choice
            ;;
            0)
                break
            ;;
        esac
    done
}

config_menu()
{
    while true; do
        # Display the menu
        clear
        printf "\n  Please select an option:\n\n"
        printf "    1. Install fastfetch config\n"
        printf "    2. Install Konsole config\n"
        printf "    3. Install MangoHud config\n"
        printf "    0. Return to main menu\n"
        printf "\n  Enter your choice (0-3): "
        read -r config_choice
        printf "\n\n"
        
        case "$config_choice" in
            1)
                mkdir -p ~/.config/fastfetch
                [ ! -f ~/.config/fastfetch/config.jsonc ] || mv -v ~/.config/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc.bak
                cp -v .config/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc
                printf "fastfetch config has been installed.\n"
                printf "\n  Press enter to continue..."
                read -r choice
            ;;
            2)
                mkdir -p ~/.local/share/konsole
                [ ! -f ~/.local/share/konsole/tri.profile ] || mv -v ~/.local/share/konsole/tri.profile ~/.local/share/konsole/tri.profile.bak
                cp -v .local/share/konsole/tri.profile ~/.local/share/konsole/tri.profile
                printf "Konsole profile has been installed.\n"
                mkdir -p ~/.config
                [ ! -f ~/.config/konsolerc ] || mv -v ~/.config/konsolerc ~/.config/konsolerc.bak
                cp -v .config/konsolerc ~/.config/konsolerc
                printf "Konsole config has been installed.\n"
                printf "\n  Press enter to continue..."
                read -r choice
            ;;
            3)
                mkdir -p ~/.config/MangoHud
                [ ! -f ~/.config/MangoHud/MangoHud.conf ] || mv -v ~/.config/MangoHud/MangoHud.conf ~/.config/MangoHud/MangoHud.conf.bak
                cp -v .config/MangoHud/MangoHud.conf ~/.config/MangoHud/MangoHud.conf
                printf "MangoHud config has been installed.\n"
                printf "\n  Press enter to continue..."
                read -r choice
            ;;
            0)
                break
            ;;
        esac
    done
}

while true; do
    # Display the menu
    clear
    printf "\n  Please select an option:\n\n"
    printf "    1. Bash files menu\n"
    #printf "    2. Native Package menu\n"
    #printf "    2. AppImage menu\n"
    printf "    2. Font menu\n"
    printf "    3. Config menu\n"
    printf "    4. DevilutionX.desktop\n"
    printf "    0. Exit\n"
    printf "\n  Enter your choice (0-3): "
    read -r choice
    printf "\n\n"
    
    case "$choice" in
        1)
            bash_menu
        ;;
        #2)
        #    native_package_menu
        #;;
        #2)
        #    appimage_menu
        #;;
        2)
            font_menu
        ;;
        3)
            config_menu
        ;;
        4)
            mkdir -p ~/.local/share/applications
            [ ! -f ~/.local/share/applications/devilutionx.desktop ] || mv -v ~/.local/share/applications/devilutionx.desktop ~/.local/share/applications/devilutionx.desktop.bak
            cp -v .local/share/applications/devilutionx.desktop ~/.local/share/applications/devilutionx.desktop
            [ ! -f ~/.local/share/icons/devilutionx.png ] || mv -v ~/.local/share/icons/devilutionx.png ~/.local/share/icons/devilutionx.png.bak
            cp -v .local/share/icons/devilutionx.png ~/.local/share/icons/devilutionx.png
            printf "DevilutionX.desktop installed\n"
            printf "\n  Press enter to continue..."
            read -r choice
        ;;
        0)
            exit 0
        ;;
    esac
done
