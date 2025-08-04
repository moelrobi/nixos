{
  description = "Flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    flake-utils,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    unstable = nixpkgs-unstable.legacyPackages.${system};
    hm = home-manager.packages.${system}.home-manager;
  in {
    nixosConfigurations = {
      maelle = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {unstable = unstable;};
        modules = [
          ./base.nix
          ./machines/maelle/default.nix
          ./machines/maelle/hardware-configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
