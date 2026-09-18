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

    nixpkgs.config.allowUnfree = true;

    services.fstrim.enable = true;

    programs.dconf.enable = true;

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };

    services.greetd = {
        enable = true;
        settings.default_session = {
            command = "${pkgs.hyprland}/bin/start-hyprland";
            user = "herlihy";
        };
    };

    systemd.user.services.waybar = {
        enable = true;
        serviceConfig = {
            ExecStart = "${pkgs.waybar}/bin/waybar";
            Restart = "always";
            RestartSec = 1;
        };
        wantedBy = [ "graphical-session.target" ];
        partOf = [ "graphical-session.target" ];
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
        hyprlock
        wofi
        ghostty
        libnotify
        playerctl
        brightnessctl

        # cli
        stow
        gnumake
        git
        gh
        unzip
        ripgrep
        fd
        htop
        python3

        # terminal
        tmux
        neovim
        unstable-opencode.opencode

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
