{ config, pkgs, ... }: {
    imports = [
        ./hardware-configuration.nix
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "herlihy";
    # networking.wireless.enable = true;    # Enables wireless support via wpa_supplicant.

    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    networking.networkmanager.enable = true;

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

    services.printing.enable = true;

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # jack.enable = true;
    };

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    };

    # hardware.nvidia = {
    #     modesetting.enable = true;
    #
    #     nvidiaSettings = true;
    #     open = false;
    #     package = config.boot.kernel.Packages.nvidiaPackages.stable;
    #
    #     powerManagement.enable = true;
    #     powerManagerment.finegrained = false;
    # };

    services.xserver = {
        # Enable the X11 windowing system.
        enable = true;

        # Enable touchpad support (enabled default in most desktopManager).
        # libinput.enable = true;

        # videoDrivers = [ "nvidia" ];

        # Configure keymap in X11
        xkb.layout = "us";
        xkb.variant = "";
    };

    # services.displayManager.gdm.enable = true;
    # services.desktopManager.gnome.enable = true;

    # xdg.portal = {
    #     enable = true;
    #     extraPortals = [
    #         pkgs.xdg-desktop-portal-gtk
    #     ];
    #     config.common.default = "*";
    # };

    users.users.herlihy = {
        isNormalUser = true;
        description = "Herlihy";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [];
    };

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
        kitty
        gcc
        gnumake
        cmake
        libtool
        gh
        wofi
        hyprpaper
    ];

    programs.hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
    };

    programs.git.enable = true;
    programs.tmux.enable = true;
    programs.vim.enable = true;
    programs.neovim.enable = true;
    programs.firefox.enable = true;

    services.emacs = {
        enable = true;
        defaultEditor = true;
    };

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #     enable = true;
    #     enableSSHSupport = true;
    # };

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # nix.gc = {
    #     automatic = true;
    #     date = "daily";
    #     options = "--delete-older-than 3d";
    # };

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.11"; # Did you read the comment?
}
