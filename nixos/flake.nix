{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        nixpkgs-unstable-opencode.url = "github:nixos/nixpkgs/1559d3daa3ecc813a650b79375ea61b6741b8746";
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
                            unstable-opencode = import inputs.nixpkgs-unstable-opencode {
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
