autoload -Uz compinit promptinit
compinit
promptinit
setopt autocd extendedglob
unsetopt beep

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[3~" delete-char

zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1

export PATH="$PATH:~/.local/bin"
export EDITOR=micro
export VISUAL=micro

# HISTORY
HISTFILE=~/.zsh/history
HISTFILESIZE=1000000000         # History limit of the file on disk.
HISTSIZE=$HISTFILESIZE          # Current session's history limit.
SAVEHIST=$HISTFILESIZE          # Zsh saves this many lines to the history file upon shell exit.
setopt INC_APPEND_HISTORY       # History file is updated immediately after a command is entered
setopt HIST_EXPIRE_DUPS_FIRST   # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS        # Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS     # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS         # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE        # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS        # Do not write a duplicate event to the history file.
setopt SHARE_HISTORY            # Share history between all sessions.
# END HISTORY

if [ -f ~/.zsh/aliases ]; then
    . ~/.zsh/aliases
else
    print "aliases not found."
fi
if [ -f ~/.zsh/functions ]; then
    . ~/.zsh/functions
else
    print "functions not found."
fi
if [ -f ~/.zsh/prompt ]; then
    . ~/.zsh/prompt
else
    print "prompt not found."
fi
