{ config, lib, pkgs, ... }: {
    imports = [
        ./hardware-configuration.nix
    ];

    hardware.opentabletdriver.enable = true;
    hardware.uinput.enable = true;
    boot.kernelModules = [ "uinput" ];

    systemd.services.iwlwifi-resume = {
        description = "Reload iwlwifi after resume from suspend";
        after = [ "sleep.target" ];
        wantedBy = [ "sleep.target" ];
        serviceConfig = {
            Type = "oneshot";
            ExecStart = "-${pkgs.kmod}/bin/modprobe -r iwlwifi";
            ExecStartPost = "${pkgs.coreutils}/bin/sleep 2 && ${pkgs.kmod}/bin/modprobe iwlwifi";
        };
    };
}
