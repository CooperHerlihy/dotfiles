{
    description = "Nixos Flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager";
        # home-manager.inputs.nixpkgs.follow = "nixpkgs";
    };

    outputs = { self, nixpkgs, home-manager, ... } @inputs: {
        nixosConfigurations = {
            nixos = nixpkgs.lib.nixosSystem {
                specialArgs = {inherit inputs;};
                modules = [
                    ./configuration.nix
                ];
            };
        };
    };
}
