# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=100000
setopt beep extendedglob nomatch notify
unsetopt autocd
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/samuel/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


# Configure Pure Prompt
fpath+=$HOME/Configuration/pure
autoload -U promptinit; promptinit
prompt pure
zstyle :prompt:pure:git:stash show yes
