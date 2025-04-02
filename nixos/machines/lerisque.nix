{ config, pkgs, ... }:

{
  imports = [
    ./lerisque-hwconf.nix
    ../cfg/base-nixos.nix
    ../cfg/desktop-gnome3.nix
    ../cfg/clamav.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable plymouth and also show it for LUKS (needs systemd in initrd).
  boot.plymouth.enable = true;
  boot.initrd.systemd.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  networking.hostName = "lerisque";

  networking.networkmanager.enable = true;

  nix = {
    settings.max-jobs = 4;
    settings.cores = 16;
    settings.sandbox = true;
    settings.trusted-users = [ "daniel" ];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  services.fprintd = {
    enable = true;
    #tod = {
    #  enable = true;
    #  driver = pkgs.libfprint-2-tod1-goodix;
    #};
  };

  services.kolide-launcher.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    browsed.enable = false;
  };

  users.users.daniel = {
    isNormalUser = true;
    description = "Daniël de Kok";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      asdbctl
    ];
  };

  environment.systemPackages = with pkgs; [
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.zsh.enable = true;

  services = {
    fstrim.enable = true;
    tailscale = {
      enable = true;
      extraSetFlags = [ "--operator=daniel" ];
    };
    udev.packages = [ pkgs.asdbctl ];
  };

  networking.modemmanager = {
    enable = true;
    fccUnlockScripts = [
      {
        id = "2c7c:6008";
        path = "${pkgs.modemmanager}/share/ModemManager/fcc-unlock.available.d/2c7c";
      }
    ];
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
