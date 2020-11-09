{ pkgs, ... }:

{
  imports = [ ../modules/resilio.nix ];

  services.resilio = {
    enable = true;
    enableWebUI = true;
    deviceName = "mindbender";
    directoryRoot = "/home/daniel/resilio";
    httpListenPort = 10000;
  };
}
