{ config, pkgs, ... }: {
    # services.xserver.digimend.enable = true;

    # environment.systemPackages = [
    #     config.boot.kernelPackages.digimend
    # ];

    hardware.opentabletdriver.enable = true;
    hardware.uinput.enable = true;
    boot.kernelModules = [ "uinput" ];
}
