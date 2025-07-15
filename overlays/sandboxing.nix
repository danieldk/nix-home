self: super: {
  #obsidian =
  #  (self.mkNixPak {
  #    config =
  #      { sloth, ... }:
  #      rec {
  #        imports = [ ./sandboxing-modules/gui-base.nix ];
  #        app.package = super.obsidian;
  #        flatpak.appId = "md.obsidian.Obsidian";
  #      };
  #  }).config.env;

  protonmail-desktop =
    (self.mkNixPak {
      config =
        { sloth, ... }:
        rec {
          imports = [
            ./sandboxing-modules/gui-base.nix
            ./sandboxing-modules/network.nix
          ];
          app.package = super.protonmail-desktop;
          flatpak.appId = "me.proton.Mail";
          dbus.policies = {
            "org.freedesktop.secrets" = "talk";
          };
        };
    }).config.env;

  signal-desktop-bin =
    (self.mkNixPak {
      config =
        { sloth, ... }:
        rec {
          imports = [
            ./sandboxing-modules/gui-base.nix
            ./sandboxing-modules/network.nix
          ];
          app.package = super.signal-desktop-bin;
          flatpak.appId = "org.signal.Signal";
          # Electron IPC
          bubblewrap.bind.rw = [ "/tmp" ];
          dbus.policies = {
            "org.gnome.SessionManager" = "talk";
            "org.freedesktop.PowerManagement" = "talk";
            "org.freedesktop.ScreenSaver" = "talk";
            "org.freedesktop.secrets" = "talk";
            "org.gnome.Mutter.IdleMonitor" = "talk";
            "org.kde.StatusNotifierWatcher" = "talk";
            "com.canonical.AppMenu.Registrar" = "talk";
            "com.canonical.indicator.application" = "talk";
            "org.ayatana.indicator.application" = "talk";

            # Not yet supported.
            # "org.freedesktop.login1" = "system";
          };
        };
    }).config.env;

  # Disabled for now because it doesn't start.
  slack' =
    (self.mkNixPak {
      config =
        { sloth, ... }:
        rec {
          imports = [
            ./sandboxing-modules/gui-base.nix
            ./sandboxing-modules/network.nix
          ];
          app.package = super.slack;
          flatpak.appId = "com.slack.Slack";
          # Electron IPC
          bubblewrap.bind.rw = [
            "/tmp"
            sloth.xdgDownloadDir
          ];
          #bubblewrap.shareIpc = true;
          bubblewrap.env = {
            "NIXOS_OZONE_WL" = "1";
          };
          dbus.policies = {
            "com.canonical.AppMenu.Registrar" = "talk";
            "org.freedesktop.Notifications" = "talk";
            "org.freedesktop.ScreenSaver" = "talk";
            "org.freedesktop.secrets" = "talk";
            "org.kde.StatusNotifierWatcher" = "talk";
            "org.kde.kwalletd5" = "talk";
            "org.kde.kwalletd6" = "talk";

            # Not yet supported.
            # "org.freedesktop.Upower" = "system";
            # "org.freedesktop.login1" = "system";
          };
        };
    }).config.env;
}
