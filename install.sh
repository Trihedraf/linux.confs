#!/bin/sh

. ./scripts/configFiles.sh
. ./scripts/devilutionxDesktop.sh
. ./scripts/fontInstall.sh
. ./scripts/shellConf.sh

while true; do
    # Display the menu
    clear
    printf "\n  Please select an option:\n\n"
    printf "    1. Shell files menu\n"
    printf "    2. Font menu\n"
    printf "    3. Config menu\n"
    printf "    4. DevilutionX.desktop\n"
    printf "    0. Exit\n"
    printf "\n  Enter your choice (0-4): "
    read -r choice
    printf "\n\n"

    case "$choice" in
        1)
            shell_menu
        ;;
        2)
            font_menu
        ;;
        3)
            config_menu
        ;;
        4)
            devilutionx_desktop
            printf "\n  Press enter to continue..."
            read -r choice
        ;;
        0)
            exit 0
        ;;
    esac
done
