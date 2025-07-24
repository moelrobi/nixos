{ pkgs, config, lib, ... }:

{
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
      discord
      steam
      spotify
    ];

    fonts.fontconfig.enable = true;

    programs.fish.enable = true;

    services.flameshot.enable = true;

    dconf = {
        enable = true;
        settings = {
            "org/gnome/desktop/input-sources" = {
                mru-sources="[('xkb', 'us')]";
                sources="[('xkb', 'de')]";
            };
            "org/gnome/desktop/interface" = {
                color-scheme = "prefer-dark";
            };
        };
    };

    programs.ssh = {
           enable = true;
           extraConfig = ''
                Host *
                    IdentityAgent ~/.1password/agent.sock
          '';
     };
  };
}
