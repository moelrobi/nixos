{ config, pkgs, options, ... }:

{
    imports = [
        ./base.nix
        ./machines/ionade
    ];
}