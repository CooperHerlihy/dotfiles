{ config, lib, pkgs, ... }: {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    time.timeZone = "America/New_York";
    i18n.defaultLocale = "en_US.UTF-8";

    networking.hostName = "nixos";
    networking.networkmanager.enable = true;

    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;

    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
    };

    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;

    users.users.herlihy = {
        isNormalUser = true;
        description = "herlihy";
        extraGroups = [ "wheel" "networkmanager" ];
    };

    programs.bash.interactiveShellInit = ''
        if [ "$(tty)" = "/dev/tty1" ] && [ -z "$WAYLAND_DISPLAY" ]; then
            start-hyprland
        fi
    '';

    nixpkgs.config.allowUnfree = true;

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
        # desktop
        hyprpaper
        waybar
        swaynotificationcenter
        wofi
        ghostty
        libnotify
        brightnessctl
        playerctl
        wlogout
        hyprlock

        # cli
        stow
        gnumake
        git
        gh
        unzip
        ripgrep
        fd
        fzf
        htop
        python3

        # terminal
        tmux
        neovim
        opencode

        # gui apps
        emacs
        vlc
        firefox
        tor-browser
        discord
        spotify
        anki
        krita
        aseprite

        # games
        steam
        heroic
        prismlauncher
        nestopia-ue
        zsnes
    ];

    system.stateVersion = "25.11";
}
