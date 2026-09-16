{ config, lib, pkgs, ... }: {
    imports = [
        ./hardware-configuration.nix
    ];

    hardware.opentabletdriver.enable = true;
    hardware.uinput.enable = true;
    boot.kernelModules = [ "uinput" ];

    boot.extraModprobeConfig = ''
         options iwlwifi power_save=0
    '';
}
