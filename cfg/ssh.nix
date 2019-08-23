{ pkgs, ... }:

{
  programs.ssh = {
    enable = true;

    compression = true;
    matchBlocks = {
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
