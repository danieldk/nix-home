{ lib, pkgs, ... }:

{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "tgi-dev" = {
        hostname = "10.90.16.19";
        user = "daniel";
      };

      "tgi-dev-ubuntu" = {
        hostname = "10.90.6.238";
        user = "daniel";
      };
      "builder" = {
        hostname = " 10.90.6.85";
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
