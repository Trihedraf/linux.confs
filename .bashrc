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

export PATH="~/.local/bin:$PATH"

if [ -f ~/.bash/aliases ]; then
    . ~/.bash/aliases
fi

if [ -f ~/.bash/functions ]; then
    . ~/.bash/functions
fi

if [ -f ~/.bash/prompt ]; then
    . ~/.bash/prompt
fi

#clear
#fastfetch

PROMPT_COMMAND=bash_prompt_command
