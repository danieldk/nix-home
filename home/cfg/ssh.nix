{ pkgs, ... }:

{
  programs.ssh = {
    enable = true;

    extraConfig = ''
      PKCS11Provider ${pkgs.opensc}/lib/opensc-pkcs11.so
    '';

    compression = true;
    matchBlocks = {
      "aion" = {
        hostname = "aion.sfs.uni-tuebingen.de";
        user = "daniel";
      };

      "hopper" = {
        hostname = "hopper.sfs.uni-tuebingen.de";
        user = "daniel";
      };

      "shaw" = {
        hostname = "shaw.sfs.uni-tuebingen.de";
        user = "daniel";
      };

      "tesniere" = {
        hostname = "tesniere.sfs.uni-tuebingen.de";
        user = "ddekok";
      };

      "turing" = {
        hostname = "turing.sfs.uni-tuebingen.de";
        user = "ddekok";
      };

      "turing-sfb" = {
        hostname = "turing-sfb.sfs.uni-tuebingen.de";
        user = "daniel";
      };
    };
  };
}
