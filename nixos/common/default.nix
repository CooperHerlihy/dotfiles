{ ... }: {
    imports = [
        ./config.nix
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    users.users.herlihy = {
        isNormalUser = true;
        description = "herlihy";
        extraGroups = [ "wheel" "networkmanager" ];
    };

    networking.hostName = "nixos";

    networking.networkmanager.enable = true;

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # programs.mtr.enable = true;
    # programs.gnupg.agent.enable = true;
    # programs.gnupg.agent.enableSSHSupport = true;

    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;

    security.rtkit.enable = true;
    services.pipewire.enable = true;
    services.pipewire.alsa.enable = true;
    services.pipewire.alsa.support32Bit = true;
    services.pipewire.pulse.enable = true;
    services.pipewire.jack.enable = true;

    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;

    time.timeZone = "America/New_York";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    system.stateVersion = "25.11";
}
