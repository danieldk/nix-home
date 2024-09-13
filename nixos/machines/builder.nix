{ lib, modulesPath, pkgs, ... }: {
  imports = [ "${modulesPath}/virtualisation/amazon-image.nix" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    #package = pkgs.kernelPackages.nvidiaPackages.stable;
  };
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  
  networking = {
    firewall = {
      enable = true;
      checkReversePath = false;
      allowedTCPPorts = [ 22 ];
      allowedUDPPorts = [];
      allowedUDPPortRanges = [];
      logRefusedConnections = false;
    };

    #hostId = "353884b8";
    hostName = "daniel-tgi-dev";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  nix = {
    settings.max-jobs = 8;
    settings.cores = 32;
    settings.sandbox = true;
    settings.trusted-users = [ "daniel" ];
    extraOptions = ''
      experimental-features = nix-command flakes repl-flake
    '';
  };

  nixpkgs = {
    config = {
      allowUnfree = true;

      packageOverrides = pkgs: {};
    };
  };

  programs.zsh.enable = true;

  users = {
    users = {
      daniel = {
        isNormalUser = true;
        extraGroups = [ "wheel" "docker" "libvirtd" "video" ];
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
  };

  hardware.nvidia-container-toolkit.enable = true;
  
}
