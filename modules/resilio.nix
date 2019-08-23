{ config, lib, pkgs, ... }:

with lib;

{
  meta.maintainers = [ maintainers.danieldk ];

  options = {
    services.resilio = {
      enable = mkEnableOption "Resilio file synchronization";

      deviceName = mkOption {
        type = types.str;
        example = "Voltron";
        default = "syncnode";
        description = ''
          Name of the Resilio Sync device.
        '';
      };

      listeningPort = mkOption {
        type = types.int;
        default = 0;
        example = 44444;
        description = ''
          Listening port. Defaults to 0 which randomizes the port.
        '';
      };

      checkForUpdates = mkOption {
        type = types.bool;
        default = true;
        description = ''
          Determines whether to check for updates and alert the user
          about them in the UI.
        '';
      };

      useUpnp = mkOption {
        type = types.bool;
        default = true;
        description = ''
          Use Universal Plug-n-Play (UPnP)
        '';
      };

      downloadLimit = mkOption {
        type = types.int;
        default = 0;
        example = 1024;
        description = ''
          Download speed limit. 0 is unlimited (default).
        '';
      };

      uploadLimit = mkOption {
        type = types.int;
        default = 0;
        example = 1024;
        description = ''
          Upload speed limit. 0 is unlimited (default).
        '';
      };

      httpListenAddr = mkOption {
        type = types.str;
        default = "0.0.0.0";
        example = "1.2.3.4";
        description = ''
          HTTP address to bind to.
        '';
      };

      httpListenPort = mkOption {
        type = types.int;
        default = 9000;
        description = ''
          HTTP port to bind on.
        '';
      };

      httpLogin = mkOption {
        type = types.str;
        example = "allyourbase";
        default = "";
        description = ''
          HTTP web login username.
        '';
      };

      httpPass = mkOption {
        type = types.str;
        example = "arebelongtous";
        default = "";
        description = ''
          HTTP web login password.
        '';
      };

      encryptLAN = mkOption {
        type = types.bool;
        default = true;
        description = "Encrypt LAN data.";
      };

      enableWebUI = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Enable Web UI for administration. Bound to the specified
          <literal>httpListenAddress</literal> and
          <literal>httpListenPort</literal>.
          '';
      };

      storagePath = mkOption {
        type = types.path;
        default = "${config.xdg.configHome}/resilio-sync";
        description = ''
          Where Resilio Sync will store it's database files (containing
          things like username info and licenses). Generally, you should not
          need to ever change this.
        '';
      };

      apiKey = mkOption {
        type = types.str;
        default = "";
        description = "API key, which enables the developer API.";
      };

      directoryRoot = mkOption {
        type = types.str;
        default = "";
        example = "/media";
        description = "Default directory to add folders in the web UI.";
      };

      sharedFolders = mkOption {
        default = [];
        example =
          [ { secret         = "AHMYFPCQAHBM7LQPFXQ7WV6Y42IGUXJ5Y";
              directory      = "/home/user/sync_test";
              useRelayServer = true;
              useTracker     = true;
              useDHT         = false;
              searchLAN      = true;
              useSyncTrash   = true;
              knownHosts     = [
                "192.168.1.2:4444"
                "192.168.1.3:4444"
              ];
            }
          ];
        description = ''
          Shared folder list. If enabled, web UI must be
          disabled. Secrets can be generated using <literal>rslsync
          --generate-secret</literal>. Note that this secret will be
          put inside the Nix store, so it is realistically not very
          secret.
        '';
      };
    };
  };

  config = let
    cfg = config.services.resilio;
    sharedFoldersRecord = map (entry: {
      secret = entry.secret;
      dir = entry.directory;
  
      use_relay_server = entry.useRelayServer;
      use_tracker = entry.useTracker;
      use_dht = entry.useDHT;
  
      search_lan = entry.searchLAN;
      use_sync_trash = entry.useSyncTrash;
      known_hosts = entry.knownHosts;
    }) cfg.sharedFolders;
    configFile = pkgs.writeText "config.json" (builtins.toJSON ({
      device_name = cfg.deviceName;
      storage_path = cfg.storagePath;
      listening_port = cfg.listeningPort;
      use_gui = false;
      check_for_updates = cfg.checkForUpdates;
      use_upnp = cfg.useUpnp;
      download_limit = cfg.downloadLimit;
      upload_limit = cfg.uploadLimit;
      lan_encrypt_data = cfg.encryptLAN;
    } // optionalAttrs (cfg.directoryRoot != "") { directory_root = cfg.directoryRoot; }
      // optionalAttrs cfg.enableWebUI {
      webui = { listen = "${cfg.httpListenAddr}:${toString cfg.httpListenPort}"; } //
        (optionalAttrs (cfg.httpLogin != "") { login = cfg.httpLogin; }) //
        (optionalAttrs (cfg.httpPass != "") { password = cfg.httpPass; }) //
        (optionalAttrs (cfg.apiKey != "") { api_key = cfg.apiKey; });
    } // optionalAttrs (sharedFoldersRecord != []) {
      shared_folders = sharedFoldersRecord;
    }));
  in mkMerge [
    (mkIf cfg.enable {
      assertions =
        [ { assertion = cfg.deviceName != "";
            message   = "Device name cannot be empty.";
          }
          { assertion = cfg.enableWebUI -> cfg.sharedFolders == [];
            message   = "If using shared folders, the web UI cannot be enabled.";
          }
          { assertion = cfg.apiKey != "" -> cfg.enableWebUI;
            message   = "If you're using an API key, you must enable the web server.";
          }
        ];
  
      systemd.user.services = {
        resilio = {
          Unit = {
            Description = "Resilio Sync Service";
            After = [ "network.target" "local-fs.target" ];
          };

          Service = {
            Restart = "on-abort";
            UMask = "0002";
            ExecStart = "${pkgs.resilio-sync}/bin/rslsync --nodaemon --config ${configFile}";
            ExecStartPre = ''${pkgs.bash}/bin/bash -c "${pkgs.coreutils}/bin/mkdir -p '${cfg.storagePath}'"'';
          };

          Install = {
            WantedBy = [ "default.target" ];
          };
        };
      };
    })
  ];
}
