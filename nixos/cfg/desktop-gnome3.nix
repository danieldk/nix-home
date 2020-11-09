{ config, lib, pkgs, ... }:

{
  imports = [
    ./base-desktop.nix
  ];

  services.pipewire.enable = true;

  services.xserver = {
    enable = true;
    desktopManager = {
      gnome3.enable = true;
    };
    displayManager = {
      gdm.enable = true;
      gdm.wayland = true;
    };
  };

  xdg.portal.enable = true;

  environment.systemPackages = with pkgs; with gnomeExtensions; [
    appindicator
    dash-to-dock
    workspace-matrix
    libappindicator-gtk2
    libappindicator-gtk3
    (callPackage ./gnome3/switcher {})
    gnome3.gnome-tweaks
  ];
}
