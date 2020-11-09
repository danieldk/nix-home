# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
      ../cfg/desktop-gnome3.nix
    ];

  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/1c54b0f7-6ed6-40c2-93e0-501aa8ee3698";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/2773-084B";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/b975031c-6fda-4586-8619-cefe414da79f"; }
    ];

  nix.maxJobs = lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  nixpkgs.config = {
    allowUnfree = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_4_19;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true; 

  networking.hostName = "trex";
  networking.networkmanager.enable = true;

  i18n = {
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Europe/Amsterdam";

  environment.systemPackages = with pkgs; let
  myTuxpaint = tuxpaint.overrideAttrs (oldAttrs: rec {
    postInstall = ''
      mkdir -p $out/share/applications
      cp src/tuxpaint.desktop $out/share/applications/
    '' + oldAttrs.postInstall;
  });
  in [
    extremetuxracer
    firefox
    gcompris
    krita
    superTux
    superTuxKart
    myTuxpaint
  ];

  nix.buildCores = 4;
  nix.useSandbox = true;

  programs.bash.enableCompletion = true;
  programs.vim.defaultEditor = true;
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;

  # Services
  services.avahi.enable = true;
  services.openssh.enable = true;
  services.fstrim.enable = true;
  services.xserver.displayManager = {
    hiddenUsers = [ "daniel" "nobody" ];
  };
  security.pam.services = {
    gdm-password.text = ''
      auth sufficient pam_succeed_if.so user ingroup nopasswdlogin
    '';
  };

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    checkReversePath = false;
    allowedTCPPorts = [ 22 ];
    allowedUDPPorts = [ 5353 ];
  };

  # Hardware
  sound.enable = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [ vaapiIntel libvdpau-va-gl vaapiVdpau intel-ocl ];
  };
  hardware.pulseaudio.enable = true;

  users.users = {
    daniel = {
      createHome = true;
      description = "Daniël de Kok";
      home = "/home/daniel";
      #shell = pkgs.zsh;
      extraGroups = [ "wheel" "cdrom" "video" ];
      isNormalUser = true;
      openssh.authorizedKeys.keys = import ../cfg/danieldk-keys.nix;
    };
    doerte = {
      createHome = true;
      description = "Dörte de Kok";
      home = "/home/doerte";
      extraGroups = [ "wheel" "cdrom" "video" ];
      isNormalUser = true;
    };
    liset = {
      createHome = true;
      description = "Liset de Kok";
      home = "/home/liset";
      extraGroups = [ "cdrom" "video" "nopasswdlogin" ];
      isNormalUser = true;
    };
    root = {
      openssh.authorizedKeys.keys = import ../cfg/danieldk-keys.nix;
    };
  };

  users.groups = {
    nopasswdlogin.gid = null;
  };

  services.xserver.displayManager.gdm.autoLogin = {
    enable = true;
    user = "liset";
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?
}
