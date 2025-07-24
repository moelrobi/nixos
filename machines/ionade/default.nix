{ pkgs, config, ... }:

{
    imports = [
        ./../../users/rob_headless.nix
        ./hardware-configuration.nix
    ];

    networking.hostName = "ionade";

    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;

        open = false;

        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
}