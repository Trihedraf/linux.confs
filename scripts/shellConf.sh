#!/bin/sh
GITPATH=$(cd $(dirname $(realpath "$0")) && cd ../ && pwd)

lnHomeConf() {
    DIR=$1
    FILE=$2
    mkdir -pv "$DIR"
    [ ! -L "$DIR/$FILE" ] || rm -v "$DIR/$FILE"
    [ ! -f "$DIR/$FILE" ] || mv -v "$DIR/$FILE" "$DIR/$FILE.bak"
    ln -sv "$GITPATH/$FILE" "$DIR/$FILE"
}

lnHomeConf $HOME .bashrc
lnHomeConf $HOME/.bash aliases
lnHomeConf $HOME/.bash functions
lnHomeConf $HOME/.bash prompt
lnHomeConf $HOME .zshrc
lnHomeConf $HOME/.zsh aliases
lnHomeConf $HOME/.zsh functions
lnHomeConf $HOME/.zsh prompt

printf "All bash and zsh files have been linked. Please run . ~/.bashrc for bash or. ~/.zshrc for zsh or logout and back in to enable the configs.\n"
