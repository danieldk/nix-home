{ config, lib, pkgs, ... }:

let
  secrets = import ../secrets.nix;
in {
  imports =
    [ <nixpkgs/nixos/modules/profiles/qemu-guest.nix>
    ];

  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "sr_mod" "virtio_blk" ];
  boot.kernelModules = [ ];
  boot.loader.grub.device = "/dev/vda";
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/333a5573-81ff-4c8b-b40c-0edf5e5a3b41";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/45612f70-4b3b-4b4c-bdb7-c6ac962ed6b0"; }
    ];

  nix.maxJobs = 1;

  #boot.kernelPackages = pkgs.linuxPackages_hardened;
  boot.kernelPackages = pkgs.linuxPackages;

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
  boot.kernel.sysctl."user.max_user_namespaces" = 1;
  boot.kernel.sysctl."vm.mmap_rnd_bits" = 32;
  boot.kernel.sysctl."vm.mmap_min_addr" = 65536;

  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  time.timeZone = "Europe/Amsterdam";

  users.extraUsers = {
    daniel = {
      createHome = true;
      home = "/home/daniel";
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
  };

  users.extraUsers.root = {
    openssh.authorizedKeys.keys = import ../cfg/danieldk-keys.nix;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 8883 ];
    allowedUDPPorts = [ 8883 ];
  };

  networking.hostName = "castle";

  security = {
    acme.acceptTerms = true;
    hideProcessInformation = true;
    lockKernelModules = true;
  };

  security.acme.certs = {
    "grafana.dekok.dk" = {
      email = "me@danieldk.eu";
    };

    "mqtt.dekok.dk" = {
      email = "me@danieldk.eu";
    };

    "scratch.doerte.eu" = {
      email = "me@doerte.eu";
    };

    "dekok.dk" = {
      extraDomains = { "www.dekok.dk" = null; };
      email = "me@danieldk.eu";
    };

    "ljdekok.com" = {
      extraDomains = { "www.ljdekok.com" = null; };
      email = "me@danieldk.eu";
    };

    "plantsulfur.org" = {
      extraDomains = { "www.plantsulfur.org" = null; };
      email = "me@danieldk.eu";
    };
  };

  services.openssh.enable = true;
  #services.openssh.permitRootLogin = "no";

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedTlsSettings = true;
    clientMaxBodySize = "250m";
    
    commonHttpConfig = ''
      server_names_hash_bucket_size 64;
    '';

    virtualHosts = {
      "apgc.eu" = {
        serverName = "apgc.eu";
        serverAliases = [ "www.apgc.eu" ];
        root = "/var/www/html";
        globalRedirect = "onlinelibrary.wiley.com/doi/full/10.1111/plb.12413";
      };

      "dekok.dk" = {
        serverName = "dekok.dk";
        serverAliases = [ "www.dekok.dk" ];
        forceSSL = true;
        enableACME = true;
        root = "/srv/www/dekok.dk";
      };

      "grafana.dekok.dk" = {
        serverName = "grafana.dekok.dk";
        forceSSL = true;
        enableACME = true;
        root = "/var/www/html";
        locations = {
          "/" = {
            proxyPass = "http://127.0.0.1:3000/";
          };
        };
      };

      "mqtt.dekok.dk" = {
        serverName = "mqtt.dekok.dk";
        forceSSL = true;
        enableACME = true;
        root = "/srv/www/mqtt.dekok.dk";
      };

      "scratch.doerte.eu" = {
        serverName = "scratch.doerte.eu";
        extraConfig = "autoindex on;";
        forceSSL = true;
        enableACME = true;
        root = "/home/doerte/scratch.doerte.eu";
      };

      "ljdekok.com" = {
        serverName = "ljdekok.com";
        serverAliases = [ "www.ljdekok.com" ];
        forceSSL = true;
        enableACME = true;
        root = "/srv/www/ljdekok.org/htdocs";
        locations = {
          "/" = {
            extraConfig = ''
              uwsgi_pass unix:/run/uwsgi/ljdekok.sock;
              include ${pkgs.nginx}/conf/uwsgi_params;
            '';
          };
          "/wiki/" = {
            alias = "/srv/www/ljdekok.org/htdocs/";
          };
          "=/robots.txt" = {
            alias = "/srv/www/ljdekok.org/htdocs/robots.txt";
          };
          "=/favicon.ico" = {
            alias = "/srv/www/ljdekok.org/htdocs/favicon.ico";
          };
        };
      };

      "plantsulfur.org" = {
        serverName = "plantsulfur.org";
        serverAliases = [ "www.plantsulfur.org" ];
        root = "/srv/www/plantsulfur.org/htdocs";
        forceSSL = true;
        enableACME = true;
        locations = {
          "/" = {
            extraConfig = ''
              uwsgi_pass unix:/run/uwsgi/plantsulfur.sock;
              include ${pkgs.nginx}/conf/uwsgi_params;
            '';
          };
          "/wiki/" = {
            alias = "/srv/www/plantsulfur.org/htdocs/";
          };
          "=/robots.txt" = {
            alias = "/srv/www/plantsulfur.org/htdocs/robots.txt";
          };
          "=/favicon.ico" = {
            alias = "/srv/www/plantsulfur.org/htdocs/favicon.ico";
          };
        };
      };
    };
  };

  services.grafana = {
    enable = true;
    analytics.reporting.enable = false;
    package = pkgs.grafana;
  };

  services.mosquitto = {
    enable = true;
    host = "0.0.0.0";
    checkPasswords = true;
    ssl = {
      enable = true;
      #cafile = "/var/lib/mosquitto/ca.crt";
      #certfile = "/var/lib/mosquitto/server.crt";
      #keyfile = "/var/lib/mosquitto/server.key";
      cafile = "/var/lib/mosquitto/fullchain.pem";
      certfile = "/var/lib/mosquitto/fullchain.pem";
      keyfile = "/var/lib/mosquitto/key.pem";
    };
    extraConf = "require_certificate false";
    users = {
       sensornode = {
         acl = ["topic readwrite sensor/#" ];
         password = "player.sect.kay.manacle.afire";
       };
       smartmeter = {
         acl = ["topic readwrite smartmeter/#" ];
         password = "viand.sware.daunt.touch.receptor";
       };
       telegraf = {
         acl = ["topic readwrite sensor/#" "topic readwrite smartmeter/#" ];
         password = "player.sect.kay.manacle.afire";
       };
    };
  };

  services.influxdb = {
    enable = true;
    #extraConfig = {
    #  http = {
    #    enabled = true;
    #    bind-address = ":8086";
    #    auth-enabled = true;
    #    log-enabled = true;
    #    write-tracing = false;
    #    pprof-enabled = false;
    #  };
    #};
  };

  services.telegraf = {
    enable = true;
    extraConfig = {
      inputs = {
        mqtt_consumer = {
          servers = ["tcp://localhost:1883"];
          username = "telegraf";
          password = "player.sect.kay.manacle.afire";
          qos = 0;
          topics = [ "sensor/#" "smartmeter/#" ];
        };
      };
      outputs = {
        influxdb = {
          database = "sensors";
          urls = [ "http://localhost:8086" ];
        };
      };
    };
  };


  services.uwsgi = let
    ljdekokMoinmoin = pkgs.python27Packages.moinmoin.overridePythonAttrs (attrs: {
      doCheck = false;
    });
  in {
    enable = true;
    user = "nginx";
    group = "nginx";
    plugins = [ "cgi" "python2" ];
    
    instance = {
      type = "emperor";
      
      vassals = {
        ljdekok = {
          type = "normal";
          pythonPackages = self: with self; [ ljdekokMoinmoin ];
          master = true;
          socket = "/run/uwsgi/ljdekok.sock";
          wsgi-file = "${ljdekokMoinmoin}/share/moin/server/moin.wsgi";
          chdir = "/srv/www/ljdekok.org";
          plugins = [ "python2" ];
        };

        plantsulfur = {
          type = "normal";
          pythonPackages = self: with self; [ ljdekokMoinmoin ];
          master = true;
          socket = "/run/uwsgi/plantsulfur.sock";
          wsgi-file = "${ljdekokMoinmoin}/share/moin/server/moin.wsgi";
          chdir = "/srv/www/plantsulfur.org";
          plugins = [ "python2" ];
        };
      };
    };
  };
}
