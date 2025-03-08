{ config, pkgs, ... }:

{
  services = {
    clamav = {
      daemon.enable = true;
      scanner.enable = true;
      updater.enable = true;
    };
  };

  systemd.services = {
    clamav-daemon.serviceConfig =
      let
        package = config.services.clamav.package;
      in
      {
        ConfigurationDirectory = "clamav";
        CacheDirectory = "clamav";
        LogsDirectory = "clamav";
        NoNewPrivileges = "yes";
        ProtectSystem = "strict";
        ProtectHome = "read-only";
        #ReadWritePaths = "/var/local/quarantine";
        TemporaryFileSystem = [ "/run/clamav" ];
        NoExecPaths = [ "/" ];
        ExecPaths = [ "${builtins.storeDir}" ];
        ProtectClock = "yes";
        ProtectHostname = "yes";
        ProtectKernelTunables = "yes";
        ProtectKernelModules = "yes";
        ProtectKernelLogs = "yes";
        ProtectControlGroups = "yes";
        RestrictSUIDSGID = "yes";
        SystemCallArchitectures = "native";
        LockPersonality = "yes";
        MemoryDenyWriteExecute = "yes";
        RestrictRealtime = "yes";
        IPAddressDeny = "any";
        RestrictAddressFamilies = [ "AF_UNIX" ];
        ProtectProc = "invisible";
        ProcSubset = "pid";
        CapabilityBoundingSet = [
          "CAP_CHOWN"
          "CAP_SETGID"
          "CAP_SETUID"
          "CAP_DAC_OVERRIDE"
          "CAP_MKNOD"
        ];
        RestrictNamespaces = "yes";
        SystemCallFilter = [
          "~@clock"
          "~@cpu-emulation"
          "~@debug"
          "~@module"
          "~@mount"
          "~@obsolete"
          "~@raw-io"
          "~@reboot"
          "~@resources"
          "~@swap"
        ];
      };
    clamav-freshclam.serviceConfig = {
      LogsDirectory = "clamav";
      ConfigurationDirectory = "clamav";
      RuntimeDirectory = "clamav";
      NoNewPrivileges = "yes";
      ProtectSystem = "full";
      ProtectHome = "tmpfs";
      PrivateTmp = "yes";
      PrivateDevices = "yes";
      NoExecPaths = [ "/" ];
      ExecPaths = [ "${builtins.storeDir}" ];
      ProtectClock = "yes";
      ProtectKernelTunables = "yes";
      ProtectKernelModules = "yes";
      ProtectKernelLogs = "yes";
      ProtectControlGroups = "yes";
      RestrictSUIDSGID = "yes";
      SystemCallArchitectures = "native";
      LockPersonality = "yes";
      MemoryDenyWriteExecute = "yes";
      RestrictRealtime = "yes";
      PrivateNetwork = "no";
      IPAddressAllow = "any";
      RestrictAddressFamilies = [
        "AF_INET"
        "AF_INET6"
      ];
      ProtectProc = "noaccess";
      ProcSubset = "pid";
      CapabilityBoundingSet = [
        "CAP_CHOWN"
        "CAP_SETGID"
        "CAP_SETUID"
        "CAP_DAC_OVERRIDE"
        "CAP_MKNOD"
      ];
      RestrictNamespaces = "yes";
      SystemCallFilter = [
        "~@clock"
        "~@cpu-emulation"
        "~@debug"
        "~@module"
        "~@mount"
        "~@obsolete"
        "~@raw-io"
        "~@reboot"
        "~@resources"
        "~@swap"
      ];
    };
  };


}
