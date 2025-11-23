#!/bin/bash
GITPATH=$(cd "$(dirname "$(realpath "$0")")" && cd ../ && pwd)

lnHomeConf() {
    srcdir=$1
    dir=$2
    file=$3
    mkdir -p "$dir"
    [ ! -L "$dir/$file" ] || rm -v "$dir/$file"
    [ ! -f "$dir/$file" ] || mv -v "$dir/$file" "$dir/$file.bak"
    ln -sv "$srcdir/$file" "$dir/$file"
}

konsole_config()
{
    lnHomeConf "$GITPATH/.local/share/konsole" "$HOME/.var/app/org.kde.konsole/data/konsole" "tri.profile"
    lnHomeConf "$GITPATH/.config" "$HOME/.var/app/org.kde.konsole/config" "konsolerc"
    printf "Konsole config has been installed.\n"
}

konsole_config
