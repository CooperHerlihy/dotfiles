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
        gdb
        lldb
        renderdoc
        valgrind
        perf
        vulkan-tools
        clang-tools

        # terminal programs
        kitty
        htop
        tmux
        neovim

        # gui applications
        emacs
        vlc
        krita
        aseprite
        firefox
        tor-browser

        # games
        steam
        heroic
        prismlauncher
        nestopia-ue
        zsnes
    ];
}
