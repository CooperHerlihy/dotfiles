{ config, pkgs, ... }: {
    # I don't know how to make this work

    # hardware.nvidia = {
    #     modesetting.enable = true;
    #     open = false;
    # };
    #
    # boot.blacklistedKernelModules = [ "nouveau" ];
    #
    # boot.extraModulePackages = [
    #     config.boot.kernelPackages.nvidiaPackages.stable
    # ];
    #
    # boot.kernelModules = [
    #     "nvidia"
    #     "nvidia_modeset"
    #     "nvidia_drm"
    # ];
    #
    # boot.kernelParams = [
    #     "nvidia-drm.modeset=1"
    # ];
}
