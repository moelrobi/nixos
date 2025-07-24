{ ... }: {
    home-manager.useUserPackages = true;
    home-manager.useGlobalPkgs = true;

    imports = [
        ./users/rob.nix
    ];
}