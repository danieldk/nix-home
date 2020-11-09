# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  fileSystems."/" =
    { device = "zpool/root/nixos";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "zpool/home";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/4CB3-3762";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/433af8b4-5192-404a-8eb2-727db7b10086"; }
    ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  boot.extraModulePackages = [ ];
  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "usbhid" "usb_storage" "sd_mod" "sdhci_pci" "rtsx_pci_sdmmc" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.kernelPackages = pkgs.linuxPackages_4_19;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true; 
  boot.supportedFilesystems = [ "zfs" ];

  boot.kernelParams = [
    # Limit maximum ARC size to 4GB
    "zfs.zfs_arc_max=4294967296"

    # Overwrite free'd memory
    "page_poison=1"

    # Disable legacy virtual syscalls
    "vsyscall=none"

    # Disable hibernation (allows replacing the running kernel)
    "nohibernate"
  ];

  boot.kernel.sysctl."kernel.kexec_load_disabled" = true;
  boot.kernel.sysctl."kernel.unprivileged_bpf_disabled" = true;
  boot.kernel.sysctl."net.core.bpf_jit_harden" = true;
  boot.kernel.sysctl."vm.mmap_rnd_bits" = 32;
  boot.kernel.sysctl."vm.mmap_min_addr" = 65536;

  networking.hostName = "mindfuzz";
  #networking.networkmanager.enable = true;

  i18n = {
    # Bigger console font for 4k screen.
    consoleFont = "latarcyrheb-sun32";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
  ];

  nix.buildCores = 2;
  nix.maxJobs = 2;
  nix.useSandbox = true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  programs.bash.enableCompletion = true;
  programs.vim.defaultEditor = true;
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;

  # Services
  services.avahi.enable = true;

  services.fwupd.enable = true;

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };

  #services.plex = {
  #  enable = true;
  #  openFirewall = true;
  #};
  
  services.resilio = {
    enable = true;
    enableWebUI = true;
    deviceName = "mindfuzz";
  };

  services.samba = {
    enable = true;
    shares = {
      homes = {
        comment = "Home Directories";
        browseable = "no";
        writable = "yes";
      };
      media = {
        path = "/srv/media";
        "valid users" = "daniel doerte mediaclient";
        browsable = "yes";
        writable = "no";
        "write list" = "daniel doerte";
        "inherit acls" = "yes";
      };
    };
  };
  services.zfs.autoScrub.enable = true;

  networking.firewall = {
    enable = true;
    checkReversePath = false;
    allowedTCPPorts = [ 22 53 80 139 443 445 1883 3000 9000 ];
    allowedUDPPorts = [ 53 137 138 1883 ];
  };

  networking.hostId = "8bfc957f";

  # Hardware
  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableAllFirmware = true;

  users.users = {
    root = {
      openssh.authorizedKeys.keys = import ../cfg/danieldk-keys.nix;
    };

    daniel = {
      createHome = true;
      home = "/home/daniel";
      shell = pkgs.zsh;
      extraGroups = [ "wheel" ];
      isNormalUser = true;
      openssh.authorizedKeys.keys = import ../cfg/danieldk-keys.nix;
    };

    doerte = {
      createHome = true;
      home = "/home/doerte";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA8Xz5MAKVBVGeyeybDaTXz+kBlzPiLrX6K1DKeVjchUu8nnahTIFPjv5vlLZMc3SUKiNNdTCuOJD4e6Nv2xFP+CO+7vV4AEJbRPyBRVx+3VPH8anGtg6Eyrc8EeqEr8G4tKf5cmVYNzzEnEo01Pc7iGWCA19Qe+Dy2k7RSyLNhzPLUCPD3rKTn0asK4bfw9kfmAcbYe/gaV22ZZYBrbK6A0W2cxT1ZMJz7ollDHehP+WKAIMHioMwFAlkqUAqqeb3D2okBcSkYg8pduUy6lsu251iEvdn8L3oRD2/F/oKxgUyYm8REEJWT7Nh23aTjqBbhIieIMaoFRrZoYikrgZ5Fw== me@doerte.eu"
      ];
    };

    mediaclient = {};
  };

  system.stateVersion = "18.09";
}
