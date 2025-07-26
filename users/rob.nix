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
    home.keyboard = "de";

    xdg.userDirs = {
      enable = true;
      createDirectories = true;
    };

    home.packages = with pkgs; [
      # Add any additional packages you want to install for the user here
      alvr
      ansible
      discord
      fastfetch
      steam
      spotify
      r2modman
      vscode
    ];

    fonts.fontconfig.enable = true;

    programs.fish.enable = true;
    programs.fish.interactiveShellInit = ''
      set fish_greeting
      set -gx SSH_AUTH_SOCK ~/.1password/agent.sock
    '';

    services.flameshot.enable = true;

    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/input-sources" = {
          sources = "[('xkb', 'de')]";
        };
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };
    };

    programs.git = {
      enable = true; # Ensure the Git program is enabled
      userEmail = "robin@moeller.mx";
      userName = "Robin Möller";
      extraConfig = {
        init = {
          defaultBranch = "main"; # Set the default branch name for new repositories
        };
      };
    };

    programs.ssh = {
      enable = true;
      matchBlocks = {
        "*" = {
          identityAgent = "~/.1password/agent.sock";
        };
      };
    };
  };
}
