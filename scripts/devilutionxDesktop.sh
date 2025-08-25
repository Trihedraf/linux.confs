#!/bin/sh

lnHomeConf() {
    dir=$1
    file=$2
    mkdir -p "$dir"
    [ ! -L "$dir/$file" ] || rm -v "$dir/$file"
    [ ! -f "$dir/$file" ] || mv -v "$dir/$file" "$dir/$file.bak"
    ln -sv "$GITPATH/$file" "$dir/$file"
}

lnHomeConf $HOME/.local/share/applications devilutionx.desktop
lnHomeConf $HOME/.local/share/icons devilutionx.png
printf "DevilutionX.desktop installed\n"
