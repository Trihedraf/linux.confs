#!/bin/sh

install=
while getopts ih? name
do
    case $name in
        i)      install=1;;
        h|?)    printf "Usage: %s: [OPTION]\n" "$0"
            printf "\-h, -?  This help\n"
            printf "\-i      Install DevilutionX.desktop\n"
        exit 2;;
    esac
done
shift $((OPTIND - 1))


devilutionx_desktop()
{
    mkdir -p ~/.local/share/applications
    [ ! -f ~/.local/share/applications/devilutionx.desktop ] || mv -v ~/.local/share/applications/devilutionx.desktop ~/.local/share/applications/devilutionx.desktop.bak
    cp -v .local/share/applications/devilutionx.desktop ~/.local/share/applications/devilutionx.desktop
    [ ! -f ~/.local/share/icons/devilutionx.png ] || mv -v ~/.local/share/icons/devilutionx.png ~/.local/share/icons/devilutionx.png.bak
    cp -v .local/share/icons/devilutionx.png ~/.local/share/icons/devilutionx.png
    printf "DevilutionX.desktop installed\n"
}

if [ -n "$install" ]; then
    devilutionx_desktop
fi
