#!/bin/sh

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

appimage_menu()
{
    while true; do
        # Display the menu
        clear
        printf "\n  Please select an option:\n\n"
        printf "    1. Tabby\n"
        printf "    0. Return to main menu\n"
        printf "\n  Enter your choice (0-1): "
        read -r appimage_choice
        printf "\n\n"
        
        case "$appimage_choice" in
            1)
                tabby_menu
            ;;
            0)
                break
            ;;
        esac
    done
}

tabby_menu()
{
    while true; do
        # Display the menu
        clear
        printf "\n  Please select an option:\n\n"
        printf "    1. Install Tabby AppImage, config and .desktop file\n"
        printf "    2. Download Latest Tabby AppImage\n"
        printf "    3. Update Tabby Config\n"
        printf "    4. Remove Tabby AppImage, config and .desktop file\n"
        printf "    0. Return to main menu\n"
        printf "\n  Enter your choice (0-4): "
        read -r tabby_choice
        printf "\n\n"
        
        case "$tabby_choice" in
            1)
                mkdir -p ~/.local/bin
                wget -qO - https://github.com/Eugeny/tabby/releases/latest/download/latest-x64-linux.yml | \
                grep -oE 'tabby.*AppImage' | \
                while read -r filename; do
                    if [ ! -f "$HOME/.local/bin/tabby-linux-x64.AppImage" ]; then
                        wget -q --show-progress --progress=bar:force:noscroll -O "$HOME/.local/bin/tabby-linux-x64.AppImage" "https://github.com/Eugeny/tabby/releases/latest/download/$filename"
                        chmod +x ~/.local/bin/tabby-linux-x64.AppImage
                    fi
                done
                mkdir -p ~/.config/tabby
                [ ! -f ~/.config/tabby/config.yaml ] || mv -v ~/.config/tabby/config.yaml ~/.config/tabby/config.yaml.bak
                cp -v .config/tabby/config.yaml ~/.config/tabby/config.yaml
                mkdir -p ~/.local/share/applications
                [ ! -f ~/.local/share/applications/tabby.desktop ] || mv -v ~/.local/share/applications/tabby.desktop ~/.local/share/applications/tabby.desktop.bak
                cp -v .local/share/applications/tabby.desktop ~/.local/share/applications/tabby.desktop
                printf "Tabby AppImage, config and .desktop file have been installed.\n"
                printf "\n  Press enter to continue..."
                read -r tabby_choice
            ;;
            2)
                mkdir -p ~/.local/bin
                rm ~/.local/bin/tabby-linux-x64.AppImage
                wget -qO - https://github.com/Eugeny/tabby/releases/latest/download/latest-x64-linux.yml | \
                grep -oE 'tabby.*AppImage' | \
                while read -r filename; do
                    if [ ! -f "$HOME/.local/bin/tabby-linux-x64.AppImage" ]; then
                        wget -q --show-progress --progress=bar:force:noscroll -O "$HOME/.local/bin/tabby-linux-x64.AppImage" "https://github.com/Eugeny/tabby/releases/latest/download/$filename"
                        chmod +x ~/.local/bin/tabby-linux-x64.AppImage
                    fi
                done
                printf "Tabby AppImage has been updated.\n"
                printf "\n  Press enter to continue..."
                read -r tabby_choice
            ;;
            3)
                mkdir -p ~/.config/tabby
                [ ! -f ~/.config/tabby/config.yaml ] || mv -v ~/.config/tabby/config.yaml ~/.config/tabby/config.yaml.bak
                cp -v .config/tabby/config.yaml ~/.config/tabby/config.yaml
                printf "Tabby config has been updated.\n"
                printf "\n  Press enter to continue..."
                read -r tabby_choice
            ;;
            4)
                rm -v ~/.local/bin/tabby-linux-x64.AppImage
                rm -v ~/.config/tabby/config.yaml
                rm -v ~/.local/share/applications/tabby.desktop
                printf "Tabby AppImage, config and .desktop file have been removed.\n"
                printf "\n  Press enter to continue..."
                read -r tabby_choice
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
    printf "    2. AppImage menu\n"
    printf "    3. Install fastfetch config\n"
    printf "    4. Install MangoHud config\n"
    printf "    0. Exit\n"
    printf "\n  Enter your choice (0-3): "
    read -r choice
    printf "\n\n"
    
    case "$choice" in
        1)
            bash_menu
        ;;
        2)
            appimage_menu
        ;;
        3)
            mkdir -p ~/.config/fastfetch
            [ ! -f ~/.config/fastfetch/config.jsonc ] || mv -v ~/.config/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc.bak
            cp -v .config/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc
            printf "fastfetch config has been installed.\n"
            printf "\n  Press enter to continue..."
            read -r choice
        ;;
        4)
            mkdir -p ~/.config/MangoHud
            [ ! -f ~/.config/MangoHud/MangoHud.conf ] || mv -v ~/.config/MangoHud/MangoHud.conf ~/.config/MangoHud/MangoHud.conf.bak
            cp -v .config/MangoHud/MangoHud.conf ~/.config/MangoHud/MangoHud.conf
            printf "MangoHud config has been installed.\n"
            printf "\n  Press enter to continue..."
            read -r choice
        ;;
        0)
            exit 0
        ;;
    esac
done
