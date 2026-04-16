export PATH=$PATH:~/.config/scripts
export EDITOR=nvim

alias nv='nvim'
alias tm='tmux attach || tmux new'
alias ta='tmux attach'
alias tn='tmux new'

DEFAULT='\[\e[0m\]'
ACCENT1='\[\e[38;2;222;177;255m\]'
ACCENT2='\[\e[38;2;155;139;248m\]'
export PS1="${ACCENT1}\u:${ACCENT2}\w${DEFAULT}\$ "
