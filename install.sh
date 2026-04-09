#!/bin/bash

mkdir -p ~/.config

DOTFILES_DIR="$(pwd)"

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
touch "$BASHRC"

if ! grep -qF "$START_MARK" "$BASHRC"; then
    printf "\n%s\n" "$BLOCK" >> "$BASHRC"
fi

while read -r SRC DST; do
    DST="${DST/#\~/$HOME}"
    mkdir -p $(dirname "$DST")
    ln -sfn "$DOTFILES_DIR/$SRC" "$DST"
done < "$DOTFILES_DIR/links.txt"

while read -r SRC DST; do
    DST="${DST/#\~/$HOME}"
    mkdir -p $(dirname "$DST")
    if [ ! -d  "$DST" ]; then
        cp -r "$DOTFILES_DIR/$SRC" "$DST"
    fi
done < "$DOTFILES_DIR/copies.txt"

if [ -d ~/.emacs.d/ ]; then
    rm -rf ~/.emacs.d/
fi
