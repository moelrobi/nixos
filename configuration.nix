{ config, pkgs, options, ... }:

{
    imports = [
        ./base.nix
        ./machines/nexus
    ];
}