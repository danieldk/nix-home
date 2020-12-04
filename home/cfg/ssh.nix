{ pkgs, ... }:

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
  };
}
