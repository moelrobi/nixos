{
  pkgs,
  config,
  lib,
  ...
}: {
  home-manager.users.rob = {
    home.stateVersion = "25.05";

    programs.home-manager.enable = true;

    home.username = "rob";
    home.homeDirectory = "/home/rob";

    xdg.userDirs = {
      enable = true;
      createDirectories = true;
    };

    home.packages = with pkgs; [
      # Add any additional packages you want to install for the user here
    ];

    fonts.fontconfig.enable = true;

    programs.fish.enable = true;
  };
}
