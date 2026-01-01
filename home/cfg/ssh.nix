{ lib, pkgs, ... }:

{
  programs.ssh = {
    enable = true;

    # Will be removed in the future, see:
    # https://home-manager-options.extranix.com/?query=programs.ssh&release=master
    enableDefaultConfig = false;

    matchBlocks = {
      "*" = {
        forwardAgent = false;
        addKeysToAgent = "no";
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };

      "tgi-dev" = {
        hostname = "10.90.16.19";
        user = "daniel";
      };
      "tgi-dev-ubuntu" = {
        hostname = "10.90.6.238";
        user = "daniel";
      };
      "builder" = {
        hostname = "10.90.6.85";
        user = "daniel";
      };
      "builder2" = {
        hostname = "10.90.2.217";
        user = "daniel";
      };
      "builder-aarch64" = {
        hostname = "10.90.0.188";
        user = "daniel";
      };
    }
    // (lib.optionalAttrs pkgs.stdenv.isDarwin {
      "*" = {
        extraOptions = {
          IdentityAgent = "\"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock\"";
        };
      };
    });

    extraConfig = lib.optionalString pkgs.stdenv.isLinux ''
      Match exec "${pkgs.scaleft}/bin/sft resolve -q  %h"
        ProxyCommand "${pkgs.scaleft}/bin/sft" proxycommand  %h
        UserKnownHostsFile "~/.local/share/ScaleFT/proxycommand_known_hosts"
    '';
  };
}
