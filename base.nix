{
  config,
  lib,
  pkgs,
  options,
  ...
}: {
  imports = [
    <home-manager/nixos>
  ];

  boot.loader.limine.enable = true;
  boot.loader.limine.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["btrfs"];

  boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linuxKernel.kernels.linux_6_15);

  hardware = {
    enableAllFirmware = true;

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkgs.lib.allowUnfreePredicate;
  };

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";
  networking.timeServers = ["0.pool.ntp.org" "1.pool.ntp.org" "2.pool.ntp.org"] ++ options.networking.timeServers.default;

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "de";
  };

  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.avahi.openFirewall = true;

  security.sudo.wheelNeedsPassword = false;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    wireplumber.enable = true;
  };

  services.dbus.enable = true;
  services.gvfs.enable = true;

  programs.nix-ld.enable = true;
  programs.fish.enable = true;

  users.users.rob = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "Robin Möller";
    extraGroups = ["wheel" "networkmanager" "audio" "video"];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBvs6MW/nMv4rz7k9EGFmU9UABylCrQkZrai8DDV2MCqPKI0dl5seCgdGok8eJqm2tETJ4yt3EDRCBYioxnCg4PmApzXbZbQuVqEhshuxZuamdPw9HHdSDTL4MYlNWEdbGxbj5UyO+z9T8T+OowaC8RK78tBJWUI227HRRmDi6GxU5yckHyy/Jojlp6xDTe5bXPWXK43MmTUbqyUXYFdqRW/6DhSapGIL0eJaGI+jLoNICA0ooIZmnTanDL8xebcq6/jPmKfk0wGCVGOiHEhtnRYdxJBmT1jAIBGkB1uE99JGJyy2fvgUFKmtMzp5MPHf3MlIF+mHrgteVab59nK9h1X6dxn9BGLH8w2qiZZBCBDhlaj+lQjeEuHkvml6N2jAADhafFovpo+K8pWIVAZRA9jOvxz91VpMYnXW/lYwNiRjEuE4kvfCRG7JkrfMdEJbeuyCVokj1NDB443c+qLOVkTf5TbR4l3/O4j9GZ2Y5VnW/cdtUV9Zo88IPjdRApSE= Macbook"
    ];
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBvs6MW/nMv4rz7k9EGFmU9UABylCrQkZrai8DDV2MCqPKI0dl5seCgdGok8eJqm2tETJ4yt3EDRCBYioxnCg4PmApzXbZbQuVqEhshuxZuamdPw9HHdSDTL4MYlNWEdbGxbj5UyO+z9T8T+OowaC8RK78tBJWUI227HRRmDi6GxU5yckHyy/Jojlp6xDTe5bXPWXK43MmTUbqyUXYFdqRW/6DhSapGIL0eJaGI+jLoNICA0ooIZmnTanDL8xebcq6/jPmKfk0wGCVGOiHEhtnRYdxJBmT1jAIBGkB1uE99JGJyy2fvgUFKmtMzp5MPHf3MlIF+mHrgteVab59nK9h1X6dxn9BGLH8w2qiZZBCBDhlaj+lQjeEuHkvml6N2jAADhafFovpo+K8pWIVAZRA9jOvxz91VpMYnXW/lYwNiRjEuE4kvfCRG7JkrfMdEJbeuyCVokj1NDB443c+qLOVkTf5TbR4l3/O4j9GZ2Y5VnW/cdtUV9Zo88IPjdRApSE= Macbook"
  ];

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
    };
  };

  hardware.bluetooth.enable = true;

  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    age
    alejandra
    curl
    dig
    git
    gparted
    htop
    iotop
    jq
    libnotify
    lsof
    rsync
    screen
    sops
    tmux
    tree
    vim
    wget
    wireguard-tools
    xdg-utils
  ];

  environment.etc = {
    "xdg/gtk-2.0/gtkrc".text = ''
      gtk-application-prefer-dark-theme=1
    '';
    "xdg/gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme=1
    '';
    "xdg/gtk-4.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme=1
    '';
  };

  fonts = {
    packages = with pkgs; [
      hack-font
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      roboto
      font-awesome
      google-fonts

      corefonts
      vistafonts
    ];
    fontDir.enable = true;
    fontconfig.defaultFonts.monospace = [
      "Hack"
      "Noto Color Emoji"
    ];
  };

  programs.gnupg.agent.enable = true;
  services.gnome.gnome-keyring.enable = true;

  services.systembus-notify.enable = true;

  programs.dconf.enable = true;
  programs.dconf.profiles.user.databases = [
    {
      settings = {
        "org/gnome/desktop/input-sources" = {
          sources = "[('xkb', 'de')]";
        };
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };
    }
  ];

  security.polkit.enable = true;

  services.openssh.enable = true;

  system.autoUpgrade.enable = true;

  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 30d";

  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '';

  networking.firewall.enable = false;

  system.copySystemConfiguration = true;

  system.stateVersion = "25.05"; # Did you read the comment above?
}
