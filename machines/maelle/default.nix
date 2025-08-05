{
  pkgs,
  unstable,
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

  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "rob";

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Disable the GNOME3/GDM auto-suspend feature that cannot be disabled in GUI!
  # If no user is logged in, the machine will power down after 20 minutes.
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  services.sunshine = {
    enable = true;
    package = unstable.sunshine;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  programs.firefox.enable = true;
  programs._1password.enable = true;
  programs._1password-gui.enable = true;

  environment.systemPackages = with pkgs; [
    # Add any additional packages you want to install for the system here
    lutris
  ];

  environment.variables = {
    SSH_AUTH_SOCK = "~/.1password/agent.sock";
  };

  environment.sessionVariables = {
    SSH_AUTH_SOCK = "~/.1password/agent.sock";
  };
}
