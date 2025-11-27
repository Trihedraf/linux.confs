#!/bin/sh
GITPATH=$(cd "$(dirname "$(realpath "$0")")" && cd ../ && pwd)

archConfigs=0
guiConfigs=0
terminalConfigs=0
while getopts agth? name
do
    case $name in
        a)      archConfigs=1;;
        g)      guiConfigs=1;;
        t)      terminalConfigs=1;;
        h|?)    printf "Usage: %s: [OPTION]\n" "$0"
            printf "\-h, -?  This help\n"
            printf "\-a      Install archlinux Configs\n"
            printf "\-g      Install gui Configs\n"
            printf "\-t      Install Terminal Configs\n"
        exit 2;;
    esac
done
shift $((OPTIND - 1))

lnHomeConf() {
    srcdir=$1
    dir=$2
    file=$3
    mkdir -p "$dir"
    [ ! -L "$dir/$file" ] || rm -v "$dir/$file"
    [ ! -f "$dir/$file" ] || mv -v "$dir/$file" "$dir/$file.bak"
    ln -sv "$srcdir/$file" "$dir/$file"
}

cpEtcConf() {
    dir=$1
    file=$2
    sudo mkdir -p "$dir"
    sudo [ ! -L "$dir/$file" ] || sudo rm -v "$dir/$file"
    sudo [ ! -f "$dir/$file" ] || sudo mv -v "$dir/$file" "$dir/$file.bak"
    sudo cp -v "$GITPATH$dir/$file" "$dir/$file"
}


kitty_config()
{
    lnHomeConf "$GITPATH/.config/kitty" "$HOME/.config/kitty" "kitty.conf"
    printf "Kitty config has been installed.\n"
}

konsole_config()
{
    lnHomeConf "$GITPATH/.local/share/konsole" "$HOME/.local/share/konsole" "tri.profile"
    lnHomeConf "$GITPATH/.config" "$HOME/.config" "konsolerc"
    printf "Konsole config has been installed.\n"
}

mango_config()
{
    lnHomeConf "$GITPATH/.config/MangoHud" "$HOME/.config/MangoHud" "MangoHud.conf"
    printf "MangoHud config has been installed.\n"
}

if [ "$guiConfigs" = 1 ]; then
    kitty_config
    konsole_config
    mango_config
fi


fastfetch_config()
{
    lnHomeConf "$GITPATH/.config/fastfetch" "$HOME/.config/fastfetch" "config.jsonc"
    printf "fastfetch config has been installed.\n"
}

micro_config()
{
    lnHomeConf "$GITPATH/.config/micro" "$HOME/.config/micro" "settings.json"
    printf "micro config has been installed.\n"
}

sftp_config()
{
    cpEtcConf "/etc/ssh/sshd_config.d" "sftp.conf"
    if systemctl --no-legend --all list-units ssh* | grep sshd.service ; then
        sudo systemctl reload sshd
        elif systemctl --no-legend --all list-units ssh* | grep ssh.service ; then
        sudo systemctl reload ssh
    fi
    printf "internal sftp config has been installed.\n"
}

sudo_config()
{
    cpEtcConf "/etc/sudoers.d" "wheel"
    printf "sudo config has been installed.\n"
}

if [ "$terminalConfigs" = 1 ]; then
    fastfetch_config
    micro_config
    sftp_config
    sudo_config
fi

paru_config()
{
    lnHomeConf "$GITPATH/.config/paru" "$HOME/.config/paru" "paru.conf"
    printf "paru config has been installed.\n"
}

if [ "$archConfigs" = 1 ]; then
    paru_config
fi
