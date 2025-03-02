{ lib, pkgs, ... }:

{
  dconf.settings =
    let
      mkTuple = lib.hm.gvariant.mkTuple;
    in
    {
      "org/gnome/desktop/input-sources" = {
        current = "uint32 0";
        sources = [
          (mkTuple [
            "xkb"
            "us+mac"
          ])
          (mkTuple [
            "xkb"
            "us"
          ])
        ];
        xkb-options = [ "terminate:ctrl_alt_bksp" ];
      };

      "org/gnome/settings-daemon/plugins/color" = {
        night-light-enabled = true;
        night-light-temperature = "uint32 3918";
      };

      "org/gnome/system/location" = {
        enabled = true;
      };

      "org/gnome/mutter" = {
        attach-modal-dialogs = true;
        dynamic-workspaces = true;
        edge-tiling = true;
        experimental-features = [
          "scale-monitor-framebuffer"
          "xwayland-native-scaling"
        ];
        focus-change-on-pointer-rest = true;
        workspaces-only-on-primary = true;
      };

      "org/gnome/shell" = {
        enabled-extensions = [ "appindicatorsupport@rgcjonas.gmail.com" ];
      };

      "org/gnome/shell/keybindings" = {
        toggle-overview = [ "<Super>space" ];
      };
    };
}
