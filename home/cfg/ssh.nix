{ pkgs, ... }:

{
  programs.ssh = {
    enable = true;

    extraConfig = ''
      PKCS11Provider ${pkgs.opensc}/lib/opensc-pkcs11.so
    '';

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
