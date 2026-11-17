# Dotfiles

## Rules

- **Test before committing.** Ensure stow operations work and NixOS configs evaluate
- **Never commit secrets.** Tokens, keys, and passwords go in untracked files; reference their location instead
- **Stow-based layout**: files are organized in a GNU stow-friendly structure. Most configs should go in `.config/`
- `nixos/`: NixOS config, user will use `sudo nixos-rebuild switch --flake` to apply
- `scripts/`: Executable scripts
- `resources/`: Reference data, wallpapers, etc.
- `windows/`: Windows-specific dotfiles
- look at `colorscheme.md` for colors

## Commands

Stow is used with: `stow . --no-folding`

