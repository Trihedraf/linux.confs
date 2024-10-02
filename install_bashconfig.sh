#!/bin/sh

while true; do
    # Display the menu
    clear
    printf "\n  Please select an option:\n\n"
    printf "    0. Exit\n"
    printf "    1. Install all bash files\n"
    printf "    2. Update .bashrc\n"
    printf "    3. Update .bash/aliases\n"
    printf "    4. Update .bash/functions\n"
    printf "    5. Update .bash/prompt\n"
    printf "\n  Enter your choice (0-5): "
    read -r choice
    printf "\n"

    # Input evaluation
    if [ "$choice" -lt 0 ] || [ "$choice" -gt 5 ]; then
        printf "Invalid option. Please enter a number between 0 and 5.\n"
    else
        # Execute the input
        case $choice in
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
                ;;
            2)
                [ ! -f ~/.bashrc ] || mv ~/.bashrc ~/.bashrc.bak
                cp .bashrc ~/.bashrc
                printf "Please run . ~/.bashrc or logout and back in to reload the .bashrc.\n"
                ;;
            3)
                mkdir -p ~/.bash
                [ ! -f ~/.bash/aliases ] || mv ~/.bash/aliases ~/.bash/aliases.bak
                cp .bash/aliases ~/.bash/aliases
                printf "Please run . ~/.bashrc or logout and back in to reload the aliases.\n"
                ;;
            4)
                mkdir -p ~/.bash
                [ ! -f ~/.bash/functions ] || mv ~/.bash/functions ~/.bash/functions.bak
                cp .bash/functions ~/.bash/functions
                printf "Please run . ~/.bashrc or logout and back in to reload the functions.\n"
                ;;
            5)
                mkdir -p ~/.bash
                [ ! -f ~/.bash/prompt ] || mv ~/.bash/prompt ~/.bash/prompt.bak
                cp .bash/prompt ~/.bash/prompt
                printf "Please run . ~/.bashrc or logout and back in to reload the prompt.\n"
                ;;
            0)
                exit 0
        esac
    fi
    printf "\nDo you want to return to the menu? (y/N) "
    read -r answer
    if [ "$answer" != "y" ]; then
        exit 0
    fi
done
