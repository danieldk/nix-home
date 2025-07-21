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

  services.desktopManager.gnome.enable = true;

  services.flatpak.enable = true;

  services.pipewire.enable = true;

  services.displayManager.gdm = {
    enable = true;
    wayland = true;
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
        gnome-tweaks
        smile
        switcher
      ];
  };
}
