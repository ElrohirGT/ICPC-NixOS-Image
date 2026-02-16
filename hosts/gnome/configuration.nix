{
  config,
  pkgs,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  networking.hostName = "gnome";
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Guatemala";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_GT.UTF-8";
    LC_IDENTIFICATION = "es_GT.UTF-8";
    LC_MEASUREMENT = "es_GT.UTF-8";
    LC_MONETARY = "es_GT.UTF-8";
    LC_NAME = "es_GT.UTF-8";
    LC_NUMERIC = "es_GT.UTF-8";
    LC_PAPER = "es_GT.UTF-8";
    LC_TELEPHONE = "es_GT.UTF-8";
    LC_TIME = "es_GT.UTF-8";
  };

  users.users.contestant = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager"];
    initialPassword = "icpc";
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  nix.settings = {
    show-trace = true;
    trusted-users = ["root"];
  };

  hardware.graphics.enable = true;
  security.sudo.enable = false;
  xdg.portal.enable = true;

  programs.java.enable = true;

  system.stateVersion = "25.11";
}
