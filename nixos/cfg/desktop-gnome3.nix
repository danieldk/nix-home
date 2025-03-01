{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./base-desktop.nix
  ];

  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "daniel" ];
  };

  services.pipewire.enable = true;

  services.xserver = {
    enable = true;
    desktopManager = {
      gnome.enable = true;
    };
    displayManager = {
      gdm.enable = true;
      gdm.wayland = true;
    };
  };

  xdg.portal.enable = true;

  environment = {
    #sessionVariables.NIXOS_OZONE_WL = "1";
    systemPackages =
      with pkgs;
      with gnomeExtensions;
      [
        appindicator
        #dash-to-dock
        #workspace-matrix
        libappindicator-gtk2
        libappindicator-gtk3
        #(callPackage ./gnome3/switcher {})
        gnome-tweaks
      ];
  };
}
