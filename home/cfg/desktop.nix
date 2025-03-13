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

      "org/gnome/desktop/peripherals/mouse" = {
        natural-scroll = true;
        speed = "1.0";
      };

      "org/gnome/desktop/wm/keybindings" = {
        move-to-workspace-left = [ "<Shift><Super>Left" ];
        move-to-workspace-right = [ "<Shift><Super>Right" ];
      };

      "org/gnome/desktop/wm/preferences" = {
        button-layout = "close,minimize,maximize:appmenu";
      };

      "org/gnome/settings-daemon/plugins/color" = {
        night-light-enabled = true;
        night-light-temperature = "uint32 3918";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Shift><Super>TouchpadOff";
        command = "xdg-open https://huggingface.co/chat/";
        name = "Hugging Chat";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        binding = "<Super>backslash";
        command = "1password --quick-access";
        name = "1Password quick access";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
        binding = "<Control>backslash";
        command = "1password --fill";
        name = "1Password fill in browser";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
        binding = "<Control><Super>space";
        command = "smile";
        name = "Smile emoji picker";
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
