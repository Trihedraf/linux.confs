#!/bin/sh

allBash=
allZsh=
while getopts bzh? name
do
    case $name in
        b)      allBash=1;;
        z)      allZsh=1;;
        h|?)    printf "Usage: %s: [OPTION]\n" "$0"
            printf "\-h, -?  This help\n"
            printf "\-b      Install all Bash Configs\n"
            printf "\-z      Install all Zsh Configs\n"
        exit 2;;
    esac
done
shift $((OPTIND - 1))

bash_rc() {
    [ ! -f ~/.bashrc ] || mv -v ~/.bashrc ~/.bashrc.bak
    cp -v ../.bashrc ~/.bashrc
}

bash_aliases() {
    mkdir -p ~/.bash
    [ ! -f ~/.bash/aliases ] || mv -v ~/.bash/aliases ~/.bash/aliases.bak
    cp -v ../.bash/aliases ~/.bash/aliases
}

bash_functions() {
    mkdir -p ~/.bash
    [ ! -f ~/.bash/functions ] || mv -v ~/.bash/functions ~/.bash/functions.bak
    cp -v ../.bash/functions ~/.bash/functions
}

bash_prompt() {
    mkdir -p ~/.bash
    [ ! -f ~/.bash/prompt ] || mv -v ~/.bash/prompt ~/.bash/prompt.bak
    cp -v ../.bash/prompt ~/.bash/prompt
}

all_bash()
{
    bash_rc
    bash_aliases
    bash_functions
    bash_prompt
    printf "All bash files have been installed. Please run . ~/.bashrc or logout and back in to enable the bash files.\n"
}

zsh_rc() {
    [ ! -f ~/.zshrc ] || mv -v ~/.zshrc ~/.zshrc.bak
    cp -v ../.zshrc ~/.zshrc
}

zsh_aliases() {
    mkdir -p ~/.zsh
    [ ! -f ~/.zsh/aliases ] || mv -v ~/.zsh/aliases ~/.zsh/aliases.bak
    cp -v ../.zsh/aliases ~/.zsh/aliases
}

zsh_functions() {
    mkdir -p ~/.zsh
    [ ! -f ~/.zsh/functions ] || mv -v ~/.zsh/functions ~/.zsh/functions.bak
    cp -v ../.zsh/functions ~/.zsh/functions
}

zsh_prompt() {
    mkdir -p ~/.zsh
    [ ! -f ~/.zsh/prompt ] || mv -v ~/.zsh/prompt ~/.zsh/prompt.bak
    cp -v ../.zsh/prompt ~/.zsh/prompt
}

all_zsh()
{
    zsh_rc
    zsh_aliases
    zsh_functions
    zsh_prompt
    printf "All zsh files have been installed. Please run . ~/.zshrc or logout and back in to enable the zsh files.\n"
}

shell_menu()
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
        printf "    6. Install all zsh files\n"
        printf "    7. Update .zshrc\n"
        printf "    8. Update .zsh/aliases\n"
        printf "    9. Update .zsh/functions\n"
        printf "    10. Update .zsh/prompt\n"
        printf "    0. Return to main menu\n"
        printf "\n  Enter your choice (0-5): "
        read -r shell_choice
        printf "\n\n"
        
        case "$shell_choice" in
            1)
                all_bash
            ;;
            2)
                bash_rc
                printf "Please run . ~/.bashrc or logout and back in to reload the .bashrc.\n"
            ;;
            3)
                bash_aliases
                printf "Please run . ~/.bashrc or logout and back in to reload the aliases.\n"
            ;;
            4)
                bash_functions
                printf "Please run . ~/.bashrc or logout and back in to reload the functions.\n"
            ;;
            5)
                bash_prompt
                printf "Please run . ~/.bashrc or logout and back in to reload the prompt.\n"
            ;;
            6)
                all_zsh
            ;;
            7)
                zsh_rc
                printf "Please run . ~/.zshrc or logout and back in to reload the .zshrc.\n"
            ;;
            8)
                zsh_aliases
                printf "Please run . ~/.zshrc or logout and back in to reload the aliases.\n"
            ;;
            9)
                zsh_functions
                printf "Please run . ~/.zshrc or logout and back in to reload the functions.\n"
            ;;
            10)
                zsh_prompt
                printf "Please run . ~/.zshrc or logout and back in to reload the prompt.\n"
            ;;
            0)
                break
            ;;
        esac
        printf "\n  Press any key to continue..."
        read -r shell_choice
    done
}

if [ -n "$allBash" ]; then
    all_bash
fi

if [ -n "$allZsh" ]; then
    all_zsh
fi
