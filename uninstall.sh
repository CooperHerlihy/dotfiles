#!/usr/bin/env bash

mkdir -p ~/.config

DOTFILES_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

while read -r SRC DST; do
    DST="${DST/#\~/$HOME}"
    rm "$DST"
done < "$DOTFILES_DIR/links.txt"

while read -r SRC DST; do
    DST="${DST/#\~/$HOME}"
    mkdir -p $(dirname "$DST")
    if [ -d  "$DST" ]; then
        rm -rf "$DST"
    fi
done < "$DOTFILES_DIR/copies.txt"

START_MARK="# >>> dotfiles bashrc >>>"
END_MARK="# <<< dotfiles bashrc <<<"

BLOCK=$(cat <<'EOF'
# >>> dotfiles bashrc >>>
if [ -f "${HOME}/.config/bash/bashrc" ]; then
    . "${HOME}/.config/bash/bashrc"
fi
# <<< dotfiles bashrc <<<
EOF
)

BASHRC="$HOME/.bashrc"

if grep -qF "$START_MARK" "$BASHRC"; then
    sed -i.bak "/$START_MARK/,/$END_MARK/d" "$BASHRC"
fi
