{ pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    networking.hostname = "nexus";

    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;

        open = true;

        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    services.xserver.videoDrivers = [ "nvidia" ];

}