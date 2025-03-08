# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./lerisque-hwconf.nix
    ../cfg/base-nixos.nix
    ../cfg/desktop-gnome3.nix
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
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-goodix;
    };
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
    description = "Daniel de Kok";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
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
    clamav = {
      daemon.enable = true;
      scanner.enable = true;
      updater.enable = true;
    };
    tailscale = {
      enable = true;
      extraSetFlags = [ "--operator=daniel" ];
    };
  };

  systemd.services = {
    clamav-daemon.serviceConfig =
      let
        package = config.services.clamav.package;
      in
      {
        ConfigurationDirectory = "clamav";
        CacheDirectory = "clamav";
        LogsDirectory = "clamav";
        NoNewPrivileges = "yes";
        ProtectSystem = "strict";
        ProtectHome = "read-only";
        #ReadWritePaths = "/var/local/quarantine";
        TemporaryFileSystem = [ "/run/clamav" ];
        NoExecPaths = [ "/" ];
        ExecPaths = [ "${builtins.storeDir}" ];
        ProtectClock = "yes";
        ProtectHostname = "yes";
        ProtectKernelTunables = "yes";
        ProtectKernelModules = "yes";
        ProtectKernelLogs = "yes";
        ProtectControlGroups = "yes";
        RestrictSUIDSGID = "yes";
        SystemCallArchitectures = "native";
        LockPersonality = "yes";
        MemoryDenyWriteExecute = "yes";
        RestrictRealtime = "yes";
        IPAddressDeny = "any";
        RestrictAddressFamilies = [ "AF_UNIX" ];
        ProtectProc = "invisible";
        ProcSubset = "pid";
        CapabilityBoundingSet = [
          "CAP_CHOWN"
          "CAP_SETGID"
          "CAP_SETUID"
          "CAP_DAC_OVERRIDE"
          "CAP_MKNOD"
        ];
        RestrictNamespaces = "yes";
        SystemCallFilter = [
          "~@clock"
          "~@cpu-emulation"
          "~@debug"
          "~@module"
          "~@mount"
          "~@obsolete"
          "~@raw-io"
          "~@reboot"
          "~@resources"
          "~@swap"
        ];
      };
    clamav-freshclam.serviceConfig = {
      LogsDirectory = "clamav";
      ConfigurationDirectory = "clamav";
      RuntimeDirectory = "clamav";
      NoNewPrivileges = "yes";
      ProtectSystem = "full";
      ProtectHome = "tmpfs";
      PrivateTmp = "yes";
      PrivateDevices = "yes";
      NoExecPaths = [ "/" ];
      ExecPaths = [ "${builtins.storeDir}" ];
      ProtectClock = "yes";
      ProtectKernelTunables = "yes";
      ProtectKernelModules = "yes";
      ProtectKernelLogs = "yes";
      ProtectControlGroups = "yes";
      RestrictSUIDSGID = "yes";
      SystemCallArchitectures = "native";
      LockPersonality = "yes";
      MemoryDenyWriteExecute = "yes";
      RestrictRealtime = "yes";
      PrivateNetwork = "no";
      IPAddressAllow = "any";
      RestrictAddressFamilies = [
        "AF_INET"
        "AF_INET6"
      ];
      ProtectProc = "noaccess";
      ProcSubset = "pid";
      CapabilityBoundingSet = [
        "CAP_CHOWN"
        "CAP_SETGID"
        "CAP_SETUID"
        "CAP_DAC_OVERRIDE"
        "CAP_MKNOD"
      ];
      RestrictNamespaces = "yes";
      SystemCallFilter = [
        "~@clock"
        "~@cpu-emulation"
        "~@debug"
        "~@module"
        "~@mount"
        "~@obsolete"
        "~@raw-io"
        "~@reboot"
        "~@resources"
        "~@swap"
      ];
    };
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
