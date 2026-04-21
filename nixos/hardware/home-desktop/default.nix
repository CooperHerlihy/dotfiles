{ ... }: {
    imports = [
        ./hardware-configuration.nix
        ./nvidia.nix
    ];

    services.xserver.xkb.layout = "us";
    services.xserver.xkb.variant = "";
}
