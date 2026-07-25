# Dotfiles

## Rules

- **Stow-based layout**: files are organized in a GNU stow-friendly structure. Most configs should go in `.config/`
- **NixOS config**: lives in `nixos/`. User will use `sudo nixos-rebuild switch --flake` to apply.
- **Scripts**: in `scripts/`. Add new ones there and ensure they're executable.
- **Resources**: in `resources/`. Reference data, wallpapers, etc.
- **Windows config**: in `windows/`. Windows-specific dotfiles.
- **`.stow-local-ignore`**: controls stow ignore patterns for this repo.
- **Test before committing.** Ensure stow operations work and NixOS configs evaluate.

## Commands

Stow is used with: `stow . --no-folding`

