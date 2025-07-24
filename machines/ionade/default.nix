{ pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    networking.hostname = "ionade";
    networking.useDHCP = true;

    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;

        open = false;

        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
    }
}