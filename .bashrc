#History Options
#HISTTIMEFORMAT="%F %T "
HISTCONTROL=ignoreboth
HISTSIZE=1000000
HISTFILESIZE=1000000

#Shell Options
shopt -s autocd
shopt -s histappend

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash-completion ]; then
    . /usr/share/bash-completion/bash-completion
  elif [ -f /etc/bash-completion ]; then
    . /etc/bash-completion
  fi
fi

#paths
export PATH="~/bin:$PATH"

#aliases
alias sudo='sudo '
alias ..='cd ..'
alias ed='micro'
alias grep='grep --color=auto'
alias ll='ls -lAh --g --full-time --color'
alias nano='micro'
alias pa='ps -A | grep'
alias rcp='rsync -vcAXtUhhP --inplace --numeric-ids --stats'
alias rmv='rsync -vcAXtUhhP --inplace --numeric-ids --stats --remove-source-files'
alias t='tmux attach || tmux new-session'
alias used='du -ahx --apparent-size --time --max-depth=1 | sort -hr'
alias uatt='sudo apt update && sudo apt upgrade && sudo flatpak update -y'
alias vi='micro'
alias jan='cal -m 01'
alias feb='cal -m 02'
alias mar='cal -m 03'
alias apr='cal -m 04'
alias may='cal -m 05'
alias jun='cal -m 06'
alias jul='cal -m 07'
alias aug='cal -m 08'
alias sep='cal -m 09'
alias oct='cal -m 10'
alias nov='cal -m 11'
alias dec='cal -m 12'
alias dcr='sudo docker compose down && sudo docker compose up -d'
alias dcd='sudo docker compose down'
alias dcu='sudo docker compose up -d'
alias dlt='sudo docker logs -tf'
alias dush='du -sh'
alias ftn='for f in *.mkv; do title=$(sed -e "s/.* - .* - //g" <<< "${f%.*}"); mkvpropedit "$f" -e info -s title="$title"; done'
alias romzip='find ./ -type f -exec zip -9 "{}.zip" "{}" \;'

#Functions

function hg() {
    history | grep "$1";
}

function mkcd () {
    local arg1="$1"
	local mysudo="$2"
	$mysudo mkdir -p $arg1; cd $arg1
}

function rmed() {
	local dir="$1"
	find "$dir" -type d -empty -delete
}

clear
fastfetch

bash_prompt_command() {
 case $TERM in
 xterm*|rxvt*)
   local TITLEBAR='\[\033]0;\u:${NEW_PWD}\007\]'
    ;;
  *)
   local TITLEBAR=""
    ;;
 esac
 local NONE="\[\033[0m\]" # unsets color to term fg color

 #local regBlk="\[\033[0;30m\]" # black
 local regRed="\[\033[0;31m\]" # red
 #local regGrn="\[\033[0;32m\]" # green
 #local regYlw="\[\033[0;33m\]" # yellow
 #local regBlu="\[\033[0;34m\]" # blue
 #local regPur="\[\033[0;35m\]" # magenta
 #local regCyn="\[\033[0;36m\]" # cyan
 #local regWht="\[\033[0;37m\]" # white
 #local bldBlk="\[\033[1;30m\]" # bold black
 local bldRed="\[\033[1;31m\]" # bold red
 local bldGrn="\[\033[1;32m\]" # bold green
 local bldYlw="\[\033[1;33m\]" # bold yellow
 local bldBlu="\[\033[1;34m\]" # bold blue
 local bldPur="\[\033[1;35m\]" # bold magenta
 local bldCyn="\[\033[1;36m\]" # bold cyan
 #local bldWht="\[\033[1;37m\]" # bold white
 #local bakBlk="\[\033[40m\]" # background black
 #local bakRed="\[\033[41m\]" # background red
 #local bakGrn="\[\033[42m\]" # background green
 #local bakYlw="\[\033[43m\]" # background yellow
 #local bakBlu="\[\033[44m\]" # background blue
 #local bakPur="\[\033[45m\]" # background magenta
 #local bakCyn="\[\033[46m\]" # background cyan
 #local bakWht="\[\033[47m\]" # background white
 local RESET="\[\e[0m\]"
 local UC=$bldRed   # user color
 local MC=$bldPur   # machine color
 local AC=$bldBlu   # accent color
 local DC=$bldCyn   # directory color
 local CC=$bldGrn   # command color
 local TC=$bldYlw   # time color
 local EC=$regRed     # error color

 [ $UID -eq "0" ] && UC=$regRed && CC=$regRed && DC=$regRed # root color


 PS1="$TITLEBAR${AC}|${TC}\D{%F %T}${AC}|${UC}\u${AC}@${MC}\h${AC}:[${DC}\w${AC}]${EC} \${?#0}\n${CC}>"

 # for terminal line coloring, leaving the rest standard
 none="$(tput sgr0)"
 trap 'echo -ne "${none}"' DEBUG
}

PROMPT_COMMAND=bash_prompt_command
