{ lib, pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;

    # services.openssh.enable = true;

    # services.getty.autologinUser = "herlihy";

    programs.bash.interactiveShellInit = ''
        if [ "$(tty)" = "/dev/tty1" ] && [ -z "$WAYLAND_DISPLAY" ]; then
            start-hyprland
        fi
    '';

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };

    programs.steam.enable = true;
    programs.gamemode.enable = true;

    fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
    ];

    environment.systemPackages = with pkgs; [
        # desktop environment
        hyprland
        hyprpaper
        # hypridle
        # hyprlock
        mako
        waybar
        wofi
        libnotify
        brightnessctl
        playerctl
        # clipboard?
        # screenshots?
        nautilus

        # cli tools
        stow
        gnumake
        git
        gh
        unzip
        ripgrep
        fd
        fzf

        # dev tools
        gnumake
        valgrind
        perf

        gcc
        cmake
        gdb
        lldb
        clang-tools

        renderdoc
        vulkan-tools

        ghc
        cabal-install
        haskell-language-server

        # terminal programs
        kitty
        htop
        tmux
        neovim
        opencode

        # gui applications
        emacs
        vlc
        krita
        aseprite
        firefox
        tor-browser
        discord
        spotify
        anki

        # games
        steam
        heroic
        prismlauncher
        nestopia-ue
        zsnes
    ];
}
