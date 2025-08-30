#!/bin/sh
GITPATH=$(cd "$(dirname "$(realpath "$0")")" && cd ../ && pwd)

lnHomeConf() {
    HOMEDIR=$1
    SUBDIR=$2
    FILE=$3
    mkdir -pv "$HOMEDIR/$SUBDIR"
    [ ! -L "$HOMEDIR/$SUBDIR$FILE" ] || rm -v "$HOMEDIR/$SUBDIR$FILE"
    [ ! -f "$HOMEDIR/$SUBDIR$FILE" ] || mv -v "$HOMEDIR/$SUBDIR$FILE" "$HOMEDIR/$SUBDIR$FILE.bak"
    ln -sv "$GITPATH/$SUBDIR$FILE" "$HOMEDIR/$SUBDIR$FILE"
}

lnHomeConf "$HOME" "" .bashrc
lnHomeConf "$HOME" ".bash/" aliases
lnHomeConf "$HOME" ".bash/" functions
lnHomeConf "$HOME" ".bash/" prompt
lnHomeConf "$HOME" "".zshrc
lnHomeConf "$HOME" ".zsh/" aliases
lnHomeConf "$HOME" ".zsh/" functions
lnHomeConf "$HOME" ".zsh/" prompt

printf "All bash and zsh files have been linked. Please run . ~/.bashrc for bash or . ~/.zshrc for zsh or logout and back in to enable the configs.\n"
