#!/bin/sh

desktopConfigs=
terminalConfigs=
while getopts dth? name
do
    case $name in
        d)      desktopConfigs=1;;
        t)      terminalConfigs=1;;
        h|?)    printf "Usage: %s: [OPTION]\n" "$0"
            printf "\-h, -?  This help\n"
            printf "\-d      Install all Desktop Configs\n"
            printf "\-t      Install all Terminal Configs\n"
        exit 2;;
    esac
done
shift $((OPTIND - 1))

konsole_config()
{
    mkdir -p ~/.local/share/konsole
    [ ! -f ~/.local/share/konsole/tri.profile ] || mv -v ~/.local/share/konsole/tri.profile ~/.local/share/konsole/tri.profile.bak
    cp -v ../.local/share/konsole/tri.profile ~/.local/share/konsole/tri.profile
    printf "Konsole profile has been installed.\n"
    mkdir -p ~/.config
    [ ! -f ~/.config/konsolerc ] || mv -v ~/.config/konsolerc ~/.config/konsolerc.bak
    cp -v ../.config/konsolerc ~/.config/konsolerc
    printf "Konsole config has been installed.\n"
}

mango_config()
{
    mkdir -p ~/.config/MangoHud
    [ ! -f ~/.config/MangoHud/MangoHud.conf ] || mv -v ~/.config/MangoHud/MangoHud.conf ~/.config/MangoHud/MangoHud.conf.bak
    cp -v ../.config/MangoHud/MangoHud.conf ~/.config/MangoHud/MangoHud.conf
    printf "MangoHud config has been installed.\n"
}

fastfetch_config()
{
    mkdir -p ~/.config/fastfetch
    [ ! -f ~/.config/fastfetch/config.jsonc ] || mv -v ~/.config/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc.bak
    cp -v ../.config/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc
    printf "fastfetch config has been installed.\n"
}

micro_config()
{
    mkdir -p ~/.config/micro
    [ ! -f ~/.config/micro/settings.json ] || mv -v ~/.config/micro/settings.json ~/.config/micro/settings.json.bak
    cp -v ../.config/micro/settings.json ~/.config/micro/settings.json
    printf "micro config has been installed.\n"
}

sftp_config()
{
    sudo mkdir -p /etc/ssh/sshd_config.d
    [ ! -f /etc/ssh/sshd_config.d/sftp.conf ] || sudo mv -v /etc/ssh/sshd_config.d/sftp.conf /etc/ssh/sshd_config.d/sftp.conf.bak
    sudo cp -v ../etc/ssh/sshd_config.d/sftp.conf /etc/ssh/sshd_config.d/sftp.conf
    if systemctl --no-legend --all list-units ssh* | grep sshd.service ; then
        sudo systemctl reload sshd
        elif systemctl --no-legend --all list-units ssh* | grep ssh.service ; then
        sudo systemctl reload ssh
    fi
    printf "internal sftp config has been installed.\n"
}

sudo_config()
{
    sudo mkdir -p /etc/sudoers.d
    [ ! -f /etc/sudoers.d/wheel ] || sudo mv -v /etc/sudoers.d/wheel /etc/sudoers.d/wheel.bak
    sudo cp -v ../etc/sudoers.d/wheel /etc/sudoers.d/wheel
    printf "sudo config has been installed.\n"
}

config_menu()
{
    while true; do
        # Display the menu
        clear
        printf "\n  Please select an option:\n\n"
        printf "    1. Install Konsole config\n"
        printf "    2. Install MangoHud config\n"
        printf "    3. Install fastfetch config\n"
        printf "    4. Install micro config\n"
        printf "    5. Install sftp config\n"
        printf "    6. Install sudo config\n"
        printf "    0. Return to main menu\n"
        printf "\n  Enter your choice (0-6): "
        read -r config_choice
        printf "\n\n"
        
        case "$config_choice" in
            1)
                konsole_config
            ;;
            2)
                mango_config
            ;;
            3)
                fastfetch_config
            ;;
            4)
                micro_config
            ;;
            5)
                sftp_config
            ;;
            6)
                sudo_config
            ;;
            0)
                break
            ;;
        esac
        printf "\n  Press enter to continue..."
        read -r config_choice
    done
}

if [ -n "$desktopConfigs" ]; then
    konsole_config
    mango_config
fi

if [ -n "$terminalConfigs" ]; then
    fastfetch_config
    micro_config
    sftp_config
    sudo_config
fi
