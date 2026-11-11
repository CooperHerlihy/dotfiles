{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    };

    outputs = { self, nixpkgs, ... }@inputs: {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ({ config, pkgs, ... }: {
                    nixpkgs.overlays = [
                        (final: prev: {
                            unstable = import inputs.nixpkgs-unstable {
                                system = prev.system;
                                config.allowUnfree = true; 
                            };
                        })
                    ];
                })
                ./hardware/desktop.nix
                ./config.nix
            ];
        };
    };
}
