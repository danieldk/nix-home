{ config, lib, pkgs, ... }:

{
  imports = [
    ./base-desktop.nix
  ];

  services.xserver = {
    enable = true;
    desktopManager = {
      plasma5.enable = true;
    };
    displayManager = {
      gdm = {
        enable = true;
        #enableHidpi = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    gwenview
    korganizer
    okular
  ];
}
