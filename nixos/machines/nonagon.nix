{
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./nonagon-hwconf.nix
    ../cfg/base-nixos.nix
  ];

  boot = {
    # Use the systemd-boot EFI boot loader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  boot.binfmt.emulatedSystems = [ "riscv64-linux" ];

  environment = {
    systemPackages = with pkgs; [ ];
  };

  hardware = {
    enableRedistributableFirmware = true;

    firmware = with pkgs; [
      linux-firmware
    ];

    #nvidia = {
    #  modesetting.enable = true;
    #  open = false;
    #};

    graphics.enable = true;
  };

  networking = {
    firewall = {
      enable = true;
      checkReversePath = false;
      allowedTCPPorts = [ 22 ];
      allowedUDPPorts = [ ];
      allowedUDPPortRanges = [ ];
      logRefusedConnections = false;
    };

    #hostId = "353884b8";
    hostName = "nonagon";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  nix = {
    settings.max-jobs = 8;
    settings.cores = 16;
    settings.sandbox = true;
    settings.trusted-users = [ "daniel" ];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs = {
    config = {
      allowUnfree = true;

      packageOverrides = pkgs: { };
    };
  };

  #powerManagement.cpuFreqGovernor = "ondemand";
  programs.zsh.enable = true;

  services = {
    fstrim.enable = true;

    fwupd.enable = true;

    openssh = {
      enable = true;
      extraConfig = ''
        AcceptEnv COLORTERM
      '';
    };

    #xserver.videoDrivers = [ "nvidia" ];
  };

  users = {
    users = {
      daniel = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "docker"
          "libvirtd"
          "video"
        ];
        shell = pkgs.zsh;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA6l265QPVJjOMTXZGjKYX7lIlpn3rPWWUoN01MHvOdl"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH57+P0J6+ZZOM4G6ArHE5R5I3uEfrV8sAT1x+ltyDEu"
        ];
      };
    };
  };

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };

  systemd.tmpfiles.rules = [
    "w /sys/devices/system/cpu/intel_pstate/max_perf_pct - - - - 90"
  ];

  system.stateVersion = "25.11";
}
