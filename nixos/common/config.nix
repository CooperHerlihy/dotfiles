{ lib, pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;

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

    environment.systemPackages = with pkgs; [
        # desktop environment
        stow
        playerctl
        brightnessctl
        hyprpaper
        mako
        libnotify
        waybar
        wofi

        # cli tools
        git
        gh
        gnumake
        unzip
        ripgrep
        fd
        fzf

        # dev tools
        gcc
        clang
        clang-tools
        valgrind
        gdb
        lldb
        renderdoc
        vulkan-tools
        perf

        # terminal programs
        kitty
        htop
        tmux
        neovim

        # applications
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

    # services.openssh.enable = true;

    programs.steam.enable = true;
    programs.gamemode.enable = true;
}
