#!/bin/sh

[ ! -f ~/.config/MangoHud/MangoHud.conf ] || mv ~/.config/MangoHud/MangoHud.conf ~/.config/MangoHud/MangoHud.conf.bak
mkdir -p ~/.config/MangoHud/
cp .config/MangoHud/MangoHud.conf ~/.config/MangoHud/MangoHud.conf
