#!/bin/sh
GITPATH=$(cd "$(dirname "$(realpath "$0")")" && cd ../ && pwd)

lnHomeConf() {
    DIR=$1
    FILE=$2
    [ ! -L "$DIR/$FILE" ] || rm -v "$DIR/$FILE"
    [ ! -f "$DIR/$FILE" ] || mv -v "$DIR/$FILE" "$DIR/$FILE.bak"
    ln -sv "$GITPATH/$FILE" "$DIR/$FILE"
}

mkdir -pv "$HOME" "$HOME/.bash"
lnHomeConf "$HOME" ".bashrc"
lnHomeConf "$HOME" ".bash/aliases"
lnHomeConf "$HOME" ".bash/colors"
lnHomeConf "$HOME" ".bash/functions"
lnHomeConf "$HOME" ".bash/prompt"

printf "All bash configs have been linked. Please run . ~/.bashrc or logout and login to enable the configs.\n"
