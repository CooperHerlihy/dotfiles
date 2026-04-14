{ inputs, config, lib, pkgs, ... }:
{
    imports = [
        ./hardware-configuration.nix
        inputs.home-manager.nixosModules.home-manager
    ];

    nixpkgs.config.allowUnfree = true;

    nix = {
        settings.experimental-features = [ "nix-command" "flakes" ];
        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
        };
    };

    users.users.herlihy = {
        isNormalUser = true;
        description = "Herlihy";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [];
    };

    home-manager = {
        extraSpecialArgs = { inherit inputs; };
        users.herlihy = import ./home.nix;
    };

    programs.hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
    };

    # services.hypridle.enable = true;
    # programs.hyprlock.enable = true;

    programs.git.enable = true;
    programs.tmux.enable = true;
    programs.vim.enable = true;
    programs.neovim.enable = true;
    # services.emacs.enable = true;

    programs.firefox.enable = true;
    services.tor.enable = true;

    environment.systemPackages = with pkgs; [
        kitty
        gcc
        gnumake
        cmake
        gh
        unzip
        mako
        wofi
        hyprpaper
        tor-browser
    ];

    networking = {
        hostName = "nixos";

        networkmanager.enable = true;

        # proxy.default = "http://user:password@proxy:port/";
        # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

        # Open ports in the firewall.
        # firewall.allowedTCPPorts = [ ... ];
        # firewall.allowedUDPPorts = [ ... ];
        # Or disable the firewall altogether.
        # firewall.enable = false;
    };

    services.xserver = {
        enable = true;
        videoDrivers = lib.mkDefault [ "nvidia" ];

        # Enable touchpad support (enabled default in most desktopManager).
        # libinput.enable = true;

        xkb.layout = "us";
        xkb.variant = "";
    };

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    };

    hardware.nvidia = {
        modesetting.enable = true;

        powerManagement.enable = false;
        powerManagement.finegrained = false;

        open = true;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;

        prime = {
            amdgpuBusId = "PCI:6:0:0";
            nvidiaBusId = "PCI:1:0:0";
        };
    };

    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
    };

    security.rtkit.enable = true;

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # jack.enable = true;
    };

    services.printing.enable = true;

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

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    system.stateVersion = "25.11";
}

