{ pkgs, ... }:

{
  programs.ssh = {
    enable = true;

    extraConfig = ''
      PKCS11Provider ${pkgs.opensc}/lib/opensc-pkcs11.so
    '';

    matchBlocks = {
    };
  };
}
