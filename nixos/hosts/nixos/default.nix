{ ... }: {
    imports = [
        ./common.nix
        ./packages.nix
    ];

    networking.hostName = "nixos";
}
