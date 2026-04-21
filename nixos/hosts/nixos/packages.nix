{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        stow

        hyprpaper
        waybar
        mako
        libnotify
        wofi

        git
        gh
        gnumake
        unzip
        wget
        curl

        kitty
        tmux
        htop
        neovim

        firefox
        tor-browser

        nestopia-ue
        zsnes
    ];

    services.xserver.enable = true;

    services.xserver.displayManager.lightdm.enable = true;

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };

    programs.steam.enable = true;

    # fonts.packages = with pkgs; [
    #     nerdfonts
    # ];
}
