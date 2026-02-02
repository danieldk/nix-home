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

  services.desktopManager.gnome.enable = true;

  services.pipewire.enable = true;

  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

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
        (switcher.overrideAttrs (prevAttrs: {
          src = pkgs.fetchFromGitHub {
            owner = "daniellandau";
            repo = "switcher";
            rev = "e76dd38fa4c55c190e22c3415b468d483ffe950d";
            hash = "sha256-Byuj3pRav6+yJifR6OP8DO30ccZaxVf/ome6rwHfD8s=";
          };
        }))
      ];
  };
}
