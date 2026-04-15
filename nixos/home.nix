{ inputs, config, lib, pkgs, ... }: {
    imports = [ ];

    nixpkgs.config.allowUnfree = true;

    home = {
        username = "herlihy";
        homeDirectory = "/home/herlihy";
        packages = with pkgs; [
            unzip

            gcc
            gnumake
            cmake
            git
            gh

            kitty
            tmux
            nim
            neovim
            emacs-pgtk

            wofi
            firefox
            tor-browser
        ];
    };

    programs.home-manager.enable = true;

    # wayland.windowManager.hyprland = {
    #     enable = true;
    #     xwayland.enable = true;
    #     systemd.enable = true;
    # };

    # programs.hyprlock.enable = true;
    # services.hypridle.enable = true;
    # services.hyprpaper.enable = true;
    # services.mako.enable = true;

    programs.wofi.enable = true;
    programs.kitty.enable = true;

    programs.git = {
        enable = true;
        settings = {
            init.defaultBranch = "main";
            user = {
                name = "CooperHerlihy";
                email = "cooper.herlihy@gmail.com";
            };
        };
    };

    programs.tmux.enable = true;
    programs.vim.enable = true;
    programs.neovim = {
        enable = true;
        # withPython3 = false; # override legacy behavior
        # withRuby = false; # override legacy behavior
    };
    programs.emacs = {
        enable = true;
        package = pkgs.emacs-pgtk;
    };

    programs.firefox.enable = true;

    home.file.".bashrc" = {
        source = config.lib.file.mkOutOfStoreSymlink "${../bash/bashrc}";
        recursive = true;
    };
    home.file.".config/hypr" = {
        source = config.lib.file.mkOutOfStoreSymlink "${../hypr}";
        recursive = true;
    };
    home.file.".config/kitty" = {
        source = config.lib.file.mkOutOfStoreSymlink "${../kitty}";
        recursive = true;
    };
    home.file.".config/tmux" = {
        source = config.lib.file.mkOutOfStoreSymlink "${../tmux}";
        recursive = true;
    };
    home.file.".config/nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink "${../nvim}";
        recursive = true;
    };
    home.file.".config/emacs" = {
        source = config.lib.file.mkOutOfStoreSymlink "${../emacs}";
        recursive = true;
    };

    systemd.user.startServices = "sd-switch";

    home.stateVersion = "25.11";
}
