{ lib, pkgs, ... }:

{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "castle" = {
        hostname = "castle.danieldk.eu";
        user = "daniel";
      };

      "syncnode" = {
        hostname = "syncnode.dekok.dk";
        user = "daniel";
      };
    };

    # IdentityAgent is not supported in machBlocks.
    extraConfig = ''
      Host *
        IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    '';
  };
}
