{
  config,
  pkgs,
  options,
  ...
}: let
  add-unstable-packages = final: _prev: {
    unstable = import <nixpkgs-unstable> {
      system = "x86_64-linux";
    };
  };
in {
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  nixpkgs.overlays = [add-unstable-packages];

  imports = [
    ./base.nix

    # ./machines/ionade
    ./machines/maelle
  ];
}
