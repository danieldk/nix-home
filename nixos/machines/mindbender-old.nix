# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let linuxPackages = pkgs.linuxPackages_4_19;
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../cfg/desktop-gnome3.nix
    ];

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
    };
  };

  boot.kernelPackages = linuxPackages;

  #boot.extraModulePackages = [ config.boot.kernelPackages.rtl8812au ];
  boot.kernelParams = [
    # Limit maximum ARC size to 4GB
    "zfs.zfs_arc_max=4294967296"
  ];
  boot.extraModprobeConfig = ''
    options snd_hda_intel power_save=1
  '';
  boot.kernel.sysctl = {
    "kernel.perf_event_paranoid" = 0;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true; 
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.enableUnstable = true;

  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.hplipWithPlugin ];
  };

  networking.hostName = "mindbender";
  networking.networkmanager.enable = false;

  console = {
    # Bigger console font for 4k screen.
    font = "latarcyrheb-sun32";
    keyMap = "us";
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    git-crypt
    linuxPackages.perf
    softmaker-office
    #nixops
  ];

  nix = {
    buildCores = 4;
    maxJobs = 4;
    trustedUsers = [ "daniel" ];
    useSandbox = true;
  };

  powerManagement.cpuFreqGovernor = "powersave";

  programs.bash.enableCompletion = true;
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.vim.defaultEditor = true;
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;

  # Services
  services.avahi = {
    enable = true;
    nssmdns = true;
  };
  services.fstrim.enable = true;
  services.fwupd.enable = true;
  services.interception-tools.enable = true;
  services.openssh.enable = true;
  services.pcscd.enable = true;
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];
  services.udev.extraRules = ''
    # Solo Key
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="a2ca", TAG+="uaccess", MODE="0660", GROUP="plugdev" 

    # Micro:Bit
    ATTRS{idVendor}=="0d28", ATTRS{idProduct}=="0204", GROUP="plugdev"

    # Jetvision ADS-B
    ATTRS{idVendor}=="0bda", ATTRS{idProduct}=="2838", GROUP:="plugdev"
  '';
  services.zfs.autoScrub.enable = true;
  services.xserver.videoDrivers = [ "intel" ];

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    checkReversePath = false;
    allowedTCPPorts = [ 22 ];
    allowedUDPPorts = [ 5353 ];
    allowedUDPPortRanges = [ { from = 32768; to = 61000; } ];
  };
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Hardware
  sound.enable = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-media-driver
      intel-ocl
    ];
  };
  hardware.u2f.enable = true;

  users.extraGroups.plugdev = { };

  users.extraUsers.daniel = {
    createHome = true;
    home = "/home/daniel";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "cdrom" "libvirtd" "video" "plugdev" "dialout" "scanner" ];
    isNormalUser = true;
    subGidRanges = [
      {
        count = 2048;
        startGid = 100001;
      }
    ];
    subUidRanges = [
      {
        count = 2048;
        startUid = 100001;
      }
    ];
  };

  virtualisation.libvirtd.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?

}
