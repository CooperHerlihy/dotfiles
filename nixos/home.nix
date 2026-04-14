{ inputs, config, lib, pkgs, ... }: {
    imports = [ ];

    nixpkgs.config.allowUnfree = true;

    home = {
        username = "herlihy";
        homeDirectory = "/home/herlihy";
    };

    programs.home-manager.enable = true;

    systemd.user.startServices = "sd-switch";

    home.stateVersion = "25.11";
}
