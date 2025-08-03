{
  config,
  pkgs,
  options,
  ...
}: {
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  imports = [
    ./base.nix

    # ./machines/ionade
    ./machines/maelle
  ];
}
