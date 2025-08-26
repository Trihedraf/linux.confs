#!/bin/sh
GITPATH=$(cd $(dirname $(realpath "$0")) && cd ../ && pwd)

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

lnHomeConf() {
    dir=$1
    file=$2
    mkdir -p "$dir"
    [ ! -L "$dir/$file" ] || rm -v "$dir/$file"
    [ ! -f "$dir/$file" ] || mv -v "$dir/$file" "$dir/$file.bak"
    ln -sv "$GITPATH/$file" "$dir/$file"
}

lnEtcConf() {
    dir=$1
    file=$2
    sudo mkdir -p "$dir"
    sudo [ ! -L "$dir/$file" ] || sudo rm -v "$dir/$file"
    sudo [ ! -f "$dir/$file" ] || sudo mv -v "$dir/$file" "$dir/$file.bak"
    sudo ln -sv "$GITPATH/$dir/$file" "$dir/$file"
}


konsole_config()
{
    lnHomeConf $HOME/.local/share/konsole tri.profile
    lnHomeConf $HOME/.config konsolerc
    printf "Konsole config has been installed.\n"
}

mango_config()
{
    lnHomeConf $HOME/.config/MangoHud MangoHud.conf
    printf "MangoHud config has been installed.\n"
}

fastfetch_config()
{
    lnHomeConf $HOME/.config/fastfetch config.jsonc
    printf "fastfetch config has been installed.\n"
}

micro_config()
{
    lnHomeConf $HOME/.config/micro settings.json
    printf "micro config has been installed.\n"
}

sftp_config()
{
    lnEtcConf /etc/ssh/sshd_config.d sftp.conf
    if systemctl --no-legend --all list-units ssh* | grep sshd.service ; then
        sudo systemctl reload sshd
        elif systemctl --no-legend --all list-units ssh* | grep ssh.service ; then
        sudo systemctl reload ssh
    fi
    printf "internal sftp config has been installed.\n"
}

sudo_config()
{
    lnEtcConf /etc/sudoers.d wheel
    printf "sudo config has been installed.\n"
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
