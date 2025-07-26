{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../users/rob.nix
  ];

  networking.hostName = "nexus";

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = true;

    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  networking.hosts = {
    "10.0.10.20" = ["web-nix" "web-nix.uwu.tools" "discord.scprp.de"];
  };

  services.xserver.enable = true;
  services.xserver.xkb.layout = "de";
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.videoDrivers = ["nvidia"];

  programs.firefox.enable = true;
  programs._1password.enable = true;
  programs._1password-gui.enable = true;

  environment.variables = {
    SSH_AUTH_SOCK = "~/.1password/agent.sock";
  };

  environment.sessionVariables = {
    SSH_AUTH_SOCK = "~/.1password/agent.sock";
  };
}
