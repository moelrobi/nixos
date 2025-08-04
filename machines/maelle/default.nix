{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../users/rob.nix
  ];

  networking.hostName = "maelle";

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = true;

    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  services.xserver.enable = true;
  services.xserver.xkb.layout = "de";
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.videoDrivers = ["nvidia"];

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

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
