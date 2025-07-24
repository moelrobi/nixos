{ pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    networking.hostname = "nexus";
    networking.useDHCP = true;

    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;

        open = true;

        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
    }
}