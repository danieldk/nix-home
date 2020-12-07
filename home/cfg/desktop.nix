{ lib, pkgs, ... }:

{
  dconf.settings = let
    mkTuple = lib.hm.gvariant.mkTuple;
  in {
    "org/gnome/desktop/background" = {
      picture-options = "zoom";
      picture-uri = "file://${pkgs.fedora-backgrounds.f33}/share/backgrounds/f33/default/f33.xml";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/input-sources" = {
      current = "uint32 0";
      sources = [ (mkTuple [ "xkb" "us+mac" ]) (mkTuple [ "xkb" "us" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" ];
    };

    "org/gnome/desktop/interface" = {
      gtk-im-module = "gtk-im-context-simple";
      gtk-theme = "Adwaita-dark";
    };

    "org/gnome/desktop/screensaver" = {
      picture-options = "zoom";
      picture-uri = "file://${pkgs.fedora-backgrounds.f33}/share/backgrounds/f33/default/f33.xml";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-temperature = "uint32 3700";
    };

    "org/gnome/system/location" = {
      enabled = true;
    };

    "org/gnome/mutter" = {
      attach-modal-dialogs = true;
      dynamic-workspaces = true;
      edge-tiling = true;
      focus-change-on-pointer-rest = true;
      workspaces-only-on-primary = true;
    };

    "org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9" = {
      background-color = "rgb(23,20,33)";
      foreground-color = "rgb(208,207,204)";
      use-theme-colors = false;
    };
  };
}
