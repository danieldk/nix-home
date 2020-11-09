{ config, pkgs, ... }:

let
  secrets = import ../secrets.nix;
  unstable = import <nixos-unstable> {};
in {
  boot.kernelPackages = pkgs.linuxPackages_hardened;

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
  boot.kernel.sysctl."user.max_user_namespaces" = 0;
  boot.kernel.sysctl."vm.mmap_rnd_bits" = 32;
  boot.kernel.sysctl."vm.mmap_min_addr" = 65536;

  nixpkgs.config.packageOverrides = pkgs: rec {
    gitea = unstable.gitea;
  };

  deployment.keys.psql-gitea.text = secrets.castle_gitea_dbpass;

  environment.systemPackages = with pkgs; [
    git
    pgcli
    vim
  ];

  services.postgresql = {
    enable = true;
  };

  services.gitea = {
    enable = true;
    database.type = "postgres";
    database.passwordFile = "/run/keys/psql-gitea";
    domain = "git.danieldk.eu";
    extraConfig = ''
      [service]
      DISABLE_REGISTRATION = true
    '';
    httpAddress = "127.0.0.1";
  };

  time.timeZone = "Europe/Amsterdam";

  users.extraUsers.daniel = {
    createHome = true;
    home = "/home/daniel";
    extraGroups = [ "wheel" ];
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICjEndjSNA5r4F5fdM9ZL9v1xY5+vGXYGHBUAQGAt5h3"
      "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAxQ5dl7Md+wbS5IzCjTV4MN3fyo+/aeVJFA6ITCq43lWMMmFluooGi078S8huWFZwjuphJota5g/M3Q/U3G7KiCfDZN4HwucPGT8NQFHntRKQ9DdjJfeD+zE3ZTdKYsXe3N5wI5KSIgZIWk6WA4viZLtVVFHrttDirC30g4H9Cx/OdoIzANDtWAOxkYNeTz/lFnawuzbUasVJsCxYJ7AI6BKhaYqR6Fr12ceHEtmXG5nsZ/r6rHqdZHCknvSx1lSbp/cLReWFvlxtipmbvFHAbaVoc1TsRwExvOw26eSOgjqNFKumriVeOTpIlaZXpzGy+tEHeymmN63fF1UmsHUHBw=="
    ];
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 3000 ];
  };

  security = {
    hideProcessInformation = true;
    lockKernelModules = true;
  };

  services.openssh.enable = true;
    
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedTlsSettings = true;
    
    commonHttpConfig = ''
      server_names_hash_bucket_size 64;
    '';

    virtualHosts."git.danieldk.eu" = {
      serverName = "git.danieldk.eu";
      root = "/var/ww/html";
      locations = {
        "/" = {
          proxyPass = "http://127.0.0.1:3000/";
        };
      };
    };
  };
}
