{
    description = "Nixos Flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    };

    outputs = { self, nixpkgs } @inputs: {
        nixosConfigurations.herlihy = nixpkgs.lib.nixosSystem {
            modules = [
                ./configuration.nix
            ];
        };
    };
}
