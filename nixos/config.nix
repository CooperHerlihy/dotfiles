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

    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    programs.steam.enable = true;
    programs.gamemode.enable = true;

    fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
    ];

    environment.systemPackages = with pkgs; [
        # terminal apps
        ghostty
        tmux
        neovim
        opencode

        # cli tools
        stow
        gnumake
        git
        gh
        unzip
        ripgrep
        fd
        htop
        python3

        # gui apps
        emacs
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

    programs.dconf.profiles.user.databases = [
    {
        lockAll = true;
        settings = {
            "org/gnome/desktop/input-sources" = {
                xkb-options = [ "ctrl:nocaps" ];
            };
            "org/gnome/desktop/interface" = {
                color-scheme = "prefer-dark";
                accent-color = "purple";
                gtk-theme = "adwaita-dark";
                font-name = "JetBrains Mono 11";
                document-font-name = "JetBrains Mono 11";
                monospace-font-name = "JetBrainsMono Nerd Font Mono 11";
            };
            "org/gnome/desktop/background" = {
                picture-uri = "file://${toString ../resources/tuscany-pixel-art.jpg}";
                picture-uri-dark = "file://${toString ../resources/tuscany-pixel-art.jpg}";
                picture-options = "zoom";
            };
            "org/gnome/mutter" = {
                dynamic-workspaces = false;
            };
            "org/gnome/mutter/keybindings" = {
                switch-monitor = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
                toggle-tiled-left = [ "<Super>h" ];
                toggle-tiled-right = [ "<Super>l" ];
            };
            "org/gnome/desktop/wm/preferences" = {
                num-workspaces = lib.gvariant.mkInt32 4;
            };
            "org/gnome/desktop/wm/keybindings" = {
                minimize = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
                switch-to-workspace-1 = [ "<Super>u" ];
                switch-to-workspace-2 = [ "<Super>i" ];
                switch-to-workspace-3 = [ "<Super>o" ];
                switch-to-workspace-4 = [ "<Super>p" ];
                move-to-workspace-1 = [ "<Super><Alt>u" ];
                move-to-workspace-2 = [ "<Super><Alt>i" ];
                move-to-workspace-3 = [ "<Super><Alt>o" ];
                move-to-workspace-4 = [ "<Super><Alt>p" ];
                maximize = [ "<Super>k" ];
                unmaximize = [ "<Super>j" ];
            };

        };
    }
    ];

    system.stateVersion = "25.11";
}
