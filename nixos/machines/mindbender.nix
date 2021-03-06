{ lib, config, pkgs, ... }:

let
  pwhash = import mindbender/pwhash.nix;
in {
  imports = [
      ./mindbender-hwconf.nix
      ../cfg/desktop-gnome3.nix
    ];

  boot = {
    kernelPackages = pkgs.linuxPackages_5_11;

    # Use the systemd-boot EFI boot loader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  #console.font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";

  environment = {
    systemPackages = with pkgs; [
      #(softmaker-office.override {
      #  officeVersion = {
      #    edition = "2018";
      #    version = "978";
      #    sha256 = "14qnlbczq1zcz24vwy2yprdvhyn6bxv1nc1w6vjyq8w5jlwqsgbr";
      #  };
      #})
    ];
  };

  hardware = {
    cpu.amd.updateMicrocode = true;

    enableRedistributableFirmware = true;

    firmware = with pkgs; [
      firmwareLinuxNonfree
    ];

    opengl = {
      enable = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    };

    sane = {
      enable = true;
      extraBackends = [ pkgs.hplipWithPlugin ];
    };
  };

  networking = {
    firewall = {
      enable = true;
      checkReversePath = false;
      allowedTCPPorts = [ 22 ];
      allowedUDPPorts = [ 5353 ];
      allowedUDPPortRanges = [ { from = 32768; to = 61000; } ];
      logRefusedConnections = false;
    };

    #hostId = "353884b8";
    hostName = "mindbender";
    networkmanager.enable = true;
    useDHCP = false;
  };

  nix = {
    package = pkgs.nixUnstable;
    buildCores = 16;
    maxJobs = 8;
    trustedUsers = [ "daniel" ];
    useSandbox = true;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs = {
    config = {
      allowUnfree = true;

      packageOverrides = pkgs: {
        vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
      };
    };
  };

  powerManagement.cpuFreqGovernor = "ondemand";


  services = {
    fstrim.enable = true;

    openssh = {
      enable = true;
      forwardX11 = true;
    };

    printing = {
      enable = true;
      drivers = [ pkgs.hplip ];
    };

    udev.extraRules = ''
      # Solo Key
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="a2ca", TAG+="uaccess"

      # Micro:Bit
      ATTRS{idVendor}=="0d28", ATTRS{idProduct}=="0204", GROUP="plugdev"

      # Jetvision ADS-B
      ATTRS{idVendor}=="0bda", ATTRS{idProduct}=="2838", GROUP:="plugdev"

      SUBSYSTEM=="usb", ATTR{idVendor}=="2516", ATTR{idProduct}=="0051", TAG+="uaccess"
    '';

    xserver = {
      libinput = {
        enable = true;

        touchpad = {
          scrollButton = 8;
        };
      };
      videoDrivers = [ "nvidia" ];
    };
  };

  systemd.tmpfiles.rules = [
    "L /etc/ipsec.secrets - - - - /etc/ipsec.d/ipsec.nm-l2tp.secrets"
  ];

  users = {
    extraGroups.plugdev = { };

    users = {
      daniel = {
        isNormalUser = true;
        extraGroups = [ "wheel" "audio" "cdrom" "docker" "libvirtd" "video" "plugdev" "dialout" "scanner" ];
        shell = pkgs.zsh;
      };

      reviewer = {
        isNormalUser = true;
        createHome = true;
      };
    };
  };

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };

  system.stateVersion = "20.09";
}

