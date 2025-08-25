#!/bin/sh
cd "$(dirname $(realpath $0))" && cd ../ && gitpath="$(pwd)" && cd "$(dirname $(realpath $0))"

lnConf() {
    file=$1
    [ ! -L "$HOME/$file" ] || rm -v "$HOME/$file"
    [ ! -f "$HOME/$file" ] || mv -v "$HOME/$file" "$HOME/$file.bak"
    ln -sv "$gitpath/$file" "$HOME/$file"
}

mkdir -p "$HOME/.bash" "$HOME/.zsh"
lnConf .bashrc
lnConf .bash/aliases
lnConf .bash/functions
lnConf .bash/prompt
lnConf .zshrc
lnConf .zsh/aliases
lnConf .zsh/functions
lnConf .zsh/prompt

printf "All bash and zsh files have been linked. Please run . ~/.bashrc for bash or. ~/.zshrc for zsh or logout and back in to enable the configs.\n"
