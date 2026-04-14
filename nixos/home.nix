{ inputs, config, lib, pkgs, ... }: {
    imports = [ ];

    nixpkgs.config.allowUnfree = true;

    home = {
        username = "herlihy";
        homeDirectory = "/home/herlihy";
        packages = with pkgs; [
            # unzip
            # gcc
            # gnumake
            # cmake
            # gh
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
    # programs.wofi.enable = true;

    # programs.kitty = lib.mkForce {
    #     enable = true;
    # };

    # programs.git = {
    #     enable = true;
    #     settings = {
    #         init.defaultBranch = "main";
    #         user = {
    #             name = "CooperHerlihy";
    #             email = "cooper.herlihy@gmail.com";
    #         };
    #     };
    # };

    # programs.tmux.enable = true;
    # programs.vim.enable = true;
    # programs.neovim.enable = true;

    programs.emacs.enable = true;
    programs.emacs.package = pkgs.emacs-pgtk;
    home.file.".config/emacs".source = config.lib.file.mkOutOfStoreSymlink "${../emacs}";

    # programs.firefox.enable = true;

    systemd.user.startServices = "sd-switch";

    home.stateVersion = "25.11";
}
