# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

#History Options
#HISTTIMEFORMAT="%F %T "
HISTCONTROL=ignoreboth
HISTSIZE=1000000
HISTFILESIZE=1000000

#Shell Options
shopt -s autocd
shopt -s dotglob
shopt -s globstar
shopt -s histappend

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash-completion ]; then
    . /usr/share/bash-completion/bash-completion
  elif [ -f /etc/bash-completion ]; then
    . /etc/bash-completion
  fi
fi

export PATH="~/.local/bin:$PATH"

if [ -f "$HOME/.local/bin/micro" ];then
    micro="$HOME/.local/bin/micro"
elif [ -f /home/linuxbrew/.linuxbrew/bin/micro ]; then
    micro=/home/linuxbrew/.linuxbrew/bin/micro
fi

export VISUAL=$micro
export EDITOR=$micro
export SUDO_EDITOR=$micro

if [ -d "$HOME/.bash" ]; then
    for file in "$HOME/.bash"/*; do
        [ -f "$file" ] && source "$file"
    done
fi

#clear
#fastfetch

if [ $PWD == "/var$HOME" ]; then
    cd $HOME
fi

PROMPT_COMMAND=bashPromptCommand
