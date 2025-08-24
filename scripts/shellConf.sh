#!/bin/sh
cd "$(dirname $(realpath $0))" && cd ../ && gitpath="$(pwd)" && cd "$(dirname $(realpath $0))"

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

rm_link_or_mv_bak() {
    [ ! -L "$1" ] || rm -v "$1"
    [ ! -f "$1" ] || mv -v "$1" "$1.bak"
}

bash_rc() {
    rm_link_or_mv_bak ~/.bashrc
    ln -sv "$gitpath/.bashrc" ~/.bashrc
}

bash_aliases() {
    rm_link_or_mv_bak ~/.bash/aliases
    ln -sv "$gitpath/.bash/aliases" ~/.bash/aliases
}

bash_functions() {
    rm_link_or_mv_bak ~/.bash/functions
    ln -sv "$gitpath/.bash/functions" ~/.bash/functions
}

bash_prompt() {
    rm_link_or_mv_bak ~/.bash/prompt
    ln -sv "$gitpath/.bash/prompt" ~/.bash/prompt
}

all_bash()
{
    bash_rc
    bash_aliases
    bash_functions
    bash_prompt
    printf "All bash files have been linked. Please run . ~/.bashrc or logout and back in to enable the bash files.\n"
}

zsh_rc() {
    rm_link_or_mv_bak ~/.zshrc
    ln -sv "$gitpath/.zshrc" ~/.zshrc
}

zsh_aliases() {
    rm_link_or_mv_bak ~/.zsh/aliases
    ln -sv "$gitpath/.zsh/aliases" ~/.zsh/aliases
}

zsh_functions() {
    rm_link_or_mv_bak ~/.zsh/functions
    ln -sv "$gitpath/.zsh/functions" ~/.zsh/functions
}

zsh_prompt() {
    rm_link_or_mv_bak ~/.zsh/prompt
    ln -sv "$gitpath/.zsh/prompt" ~/.zsh/prompt
}

all_zsh()
{
    zsh_rc
    zsh_aliases
    zsh_functions
    zsh_prompt
    printf "All zsh files have been linked. Please run . ~/.zshrc or logout and back in to enable the zsh files.\n"
}

shell_menu()
{
    while true; do
        # Display the menu
        clear
        printf "\n  Please select an option:\n\n"
        printf "    1. Link all bash files\n"
        printf "    2. Link .bashrc\n"
        printf "    3. Link .bash/aliases\n"
        printf "    4. Link .bash/functions\n"
        printf "    5. Link .bash/prompt\n"
        printf "    6. Link all zsh files\n"
        printf "    7. Link .zshrc\n"
        printf "    8. Link .zsh/aliases\n"
        printf "    9. Link .zsh/functions\n"
        printf "    10. Link .zsh/prompt\n"
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
    mkdir -p ~/.bash
    all_bash
fi

if [ -n "$allZsh" ]; then
    mkdir -p ~/.zsh
    all_zsh
fi

if [ -z "$allBash" ] && [ -z "$allZsh" ]; then
    mkdir -p ~/.bash
    mkdir -p ~/.zsh
    shell_menu
fi
