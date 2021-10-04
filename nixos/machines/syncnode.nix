{ config, lib, pkgs, ... }:
{
  imports =
    [ <nixpkgs/nixos/modules/profiles/qemu-guest.nix>
    ];

  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "sd_mod" "sr_mod" ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/7d2d9337-c2d8-4e52-955e-cb8d48b953d8";
      fsType = "ext4";
    };

  fileSystems."/storage" =
    { device = "/dev/disk/by-id/scsi-0HC_Volume_2687473";
      fsType = "ext4";
      options = [ "discard" "nofail" "defaults" ];
    };

  swapDevices = [ ];

  boot.loader.grub.device = "/dev/sda";

  # Kernel hardening.
  boot.kernelParams = [
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

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim
  ];

  nix.maxJobs = lib.mkDefault 1;
  nixpkgs.config.allowUnfree = true;

  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedTlsSettings = true;

    commonHttpConfig = ''
      server_names_hash_bucket_size 64;
    '';

    virtualHosts = {
      "blob.danieldk.eu" = {
        serverName = "blob.danieldk.eu";
        forceSSL = true;
        enableACME = true;
        extraConfig = "autoindex on;";
        root = "/storage/www/blob.danieldk.eu";
      };

      "tensordot.com" = {
        serverName = "tensordot.com";
        serverAliases = [ "www.tensordot.com" ];
        forceSSL = true;
        enableACME = true;
        root = "/storage/www/www.tensordot.com";
      };
    };
  };

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 ];
      allowedUDPPorts = [ ];
    };

    interfaces.ens3.ipv6.addresses = [{
      address = "2a01:4f8:1c17:7d38::1";
      prefixLength = 64;
    }];

    defaultGateway6 = {
      address = "fe80::1";
      interface = "ens3";
    };

    hostName = "syncnode";
  };

  security = {
    lockKernelModules = true;

    acme.acceptTerms = true;

    acme.certs = {
      "blob.danieldk.eu" = {
        email = "me@danieldk.eu";
      };

      "tensordot.com" = {
        email = "me@danieldk.eu";
      };
    };
  };

  users.users = {
    root = {
      openssh.authorizedKeys.keys = import ../cfg/danieldk-keys.nix;
    };

    daniel = {
      createHome = true;
      home = "/home/daniel";
      extraGroups = [ "wheel" ];
      isNormalUser = true;
      openssh.authorizedKeys.keys = import ../cfg/danieldk-keys.nix;
    };
  };

  system.stateVersion = "18.09"; # Did you read the comment?
}
