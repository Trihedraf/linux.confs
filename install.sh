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
        printf "\n\n  "

        case "$bash_choice" in
            1)
                mkdir -p ~/.bash
                [ ! -f ~/.bashrc ] || mv ~/.bashrc ~/.bashrc.bak
                cp .bashrc ~/.bashrc
                [ ! -f ~/.bash/aliases ] || mv ~/.bash/aliases ~/.bash/aliases.bak
                cp .bash/aliases ~/.bash/aliases
                [ ! -f ~/.bash/functions ] || mv ~/.bash/functions ~/.bash/functions.bak
                cp .bash/functions ~/.bash/functions
                [ ! -f ~/.bash/prompt ] || mv ~/.bash/prompt ~/.bash/prompt.bak
                cp .bash/prompt ~/.bash/prompt
                printf "All bash files have been installed. Please run . ~/.bashrc or logout and back in to enable the bash files.\n"
                printf "\n  Press enter to continue..."
                read -r bash_choice
                ;;
            2)
                [ ! -f ~/.bashrc ] || mv ~/.bashrc ~/.bashrc.bak
                cp .bashrc ~/.bashrc
                printf "Please run . ~/.bashrc or logout and back in to reload the .bashrc.\n"
                printf "\n  Press any key to continue..."
                read -r bash_choice
                ;;
            3)
                mkdir -p ~/.bash
                [ ! -f ~/.bash/aliases ] || mv ~/.bash/aliases ~/.bash/aliases.bak
                cp .bash/aliases ~/.bash/aliases
                printf "Please run . ~/.bashrc or logout and back in to reload the aliases.\n"
                printf "\n  Press enter to continue..."
                read -r bash_choice
                ;;
            4)
                mkdir -p ~/.bash
                [ ! -f ~/.bash/functions ] || mv ~/.bash/functions ~/.bash/functions.bak
                cp .bash/functions ~/.bash/functions
                printf "Please run . ~/.bashrc or logout and back in to reload the functions.\n"
                printf "\n  Press enter to continue..."
                read -r bash_choice
                ;;
            5)
                mkdir -p ~/.bash
                [ ! -f ~/.bash/prompt ] || mv ~/.bash/prompt ~/.bash/prompt.bak
                cp .bash/prompt ~/.bash/prompt
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


while true; do
    # Display the menu
    clear
    printf "\n  Please select an option:\n\n"
    printf "    1. Bash files menu\n"
    printf "    2. Install fastfetch config\n"
    printf "    3. Install MangoHud config\n"
    printf "    0. Exit\n"
    printf "\n  Enter your choice (0-3): "
    read -r choice
    printf "\n\n  "

    case "$choice" in
        1)
            bash_menu
            ;;
        2)
            mkdir -p ~/.config/fastfetch
            [ ! -f ~/.config/fastfetch/config.jsonc ] || mv ~/.config/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc.bak
            cp .config/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc
            printf "fastfetch config has been installed.\n"
            printf "\n  Press enter to continue..."
            read -r choice
            ;;
        3)
            mkdir -p ~/.config/MangoHud
            [ ! -f ~/.config/MangoHud/MangoHud.conf ] || mv ~/.config/MangoHud/MangoHud.conf ~/.config/MangoHud/MangoHud.conf.bak
            cp .config/MangoHud/MangoHud.conf ~/.config/MangoHud/MangoHud.conf
            printf "MangoHud config has been installed.\n"
            printf "\n  Press enter to continue..."
            read -r choice
            ;;
        0)
            exit 0
    esac
done
