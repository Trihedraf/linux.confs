#!/bin/sh
GITPATH=$(cd "$(dirname "$(realpath "$0")")" && pwd)

"$GITPATH/scripts/configFiles.sh" -det
"$GITPATH/scripts/devilutionxDesktop.sh"
"$GITPATH/scripts/fontInstall.sh"
"$GITPATH/scripts/shellConf.sh"
