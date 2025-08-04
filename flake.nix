{
  descriotion = "Flake";
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
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        unstable = nixpkgs-unstable.legacyPackages.${system};
        hm = home-manager.packages.${system}.home-manager;
      in {
        nixosConfigurations = {
          maelle = pkgs.lib.nixosSystem {
            inherit system;
            modules = [
              ./base.nix
              ./machines/maelle.nix
              home-manager.nixosModules.home-manager
            ];
          };
        };
      }
    );
}
