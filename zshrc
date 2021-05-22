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

# Colors
LS_COLORS='no=00;37:fi=00:di=00;33:ln=04;36:pi=40;33:so=01;35:bd=40;33;01:'
export LS_COLORS
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
alias ls='ls --color=auto'


# Lang (completion related bug)
export LANG=fr_FR.UTF-8
export LC_CTYPE=fr_FR.UTF-8

# opam configuration
test -r /home/samuel/.opam/opam-init/init.zsh && . /home/samuel/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# Parallel Builds
MAKEFLAGS="-j$(nproc)"