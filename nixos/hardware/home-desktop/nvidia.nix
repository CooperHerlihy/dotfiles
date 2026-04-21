{ ... }: {
    # boot.kernelParams = [
    #     "nvidia-drm.modeset=1"
    #     # "nvidia-drm.fbdev=1"
    # ];
    #
    # environment.sessionVariable = {
    #     WLR_NO_HARDWARE_CURSORS = "1";
    #     NIXOS_OZONE_WL = "1";
    # };
    #
    # hardware.graphics = {
    #     enable = true;
    #     enable32Bit = true;
    # };
    #
    # hardware.nvidia = {
    #     modesetting.enable = true;
    #
    #     # powerManagement.enable = false;
    #     # powerManagement.finegrained = false;
    #
    #     open = false;
    #     nvidiaSettings = true;
    #     package = config.boot.kernelPackages.nvidiaPackages.stable;
    #
    #     # prime = {
    #     #     amdgpuBusId = "PCI:6:0:0";
    #     #     nvidiaBusId = "PCI:1:0:0";
    #     # };
    # };
    #
    # services.xserver.videoDrivers = lib.mkDefault [ "nvidia" ];
}
