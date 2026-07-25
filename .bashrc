export PATH=$PATH:~/dotfiles/scripts
export EDITOR=nvim

alias ls='ls --color=auto'
alias ll='ls -lahF --color=auto'
alias l='ls -lFh --color=auto'

alias tm='tmux attach || tmux new'
alias nv='nvim'
alias nd='nix develop'

DEFAULT='\[\e[0m\]'
ACCENT1='\[\e[38;2;222;177;255m\]'
ACCENT2='\[\e[38;2;155;139;248m\]'
export PS1="${ACCENT1}\u:${ACCENT2}\w${DEFAULT}\$ "
