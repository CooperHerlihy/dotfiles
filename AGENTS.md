# Dotfiles

## Rules

- Test before committing. Ensure stow operations work and NixOS configs evaluate
- Never commit secrets. Tokens, keys, and passwords go in untracked files; reference their location instead
- Never put configs in their global location. Always use the file in dotfiles and then stow
- `nixos/`: NixOS config, user will use `sudo nixos-rebuild switch --flake` to apply
- `scripts/`: Executable scripts
- `resources/`: Reference data, wallpapers, etc.
- `windows/`: Windows-specific dotfiles
- look at `colorscheme.md` for colors

## Commands

Stow is used with: `stow . --no-folding --adopt`

