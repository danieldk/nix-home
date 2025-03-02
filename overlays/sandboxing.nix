self: super:
let
  xdgDirs = sloth: pname: [
    [
      (sloth.mkdir (sloth.concat' sloth.homeDir "/.local/state/nixpak/${pname}/cache"))
      (sloth.concat' sloth.homeDir "/.cache")
    ]
    [
      (sloth.mkdir (sloth.concat' sloth.homeDir "/.local/state/nixpak/${pname}/config"))
      (sloth.concat' sloth.homeDir "/.config")
    ]
    [
      (sloth.mkdir (sloth.concat' sloth.homeDir "/.local/state/nixpak/${pname}/local"))
      (sloth.concat' sloth.homeDir "/.local")
    ]
  ];
in
{
  obsidian =
    (self.mkNixPak {
      config =
        { sloth, ... }:
        rec {
          app.package = super.obsidian;
          flatpak.appId = "md.obsidian.Obsidian";
          dbus.enable = true;
          dbus.policies = {
            "org.freedesktop.DBus" = "talk";
          };
          gpu.enable = true;
          bubblewrap = {
            sockets.x11 = true;
            bind.rw = [
              (sloth.concat' sloth.homeDir "/git/quartz/content")
            ] ++ xdgDirs sloth app.package.pname;
            bind.ro = [
              "/run/current-system"
            ];
          };
          fonts.enable = true;
        };
    }).config.env;

  protonmail-desktop = self.bwrapper {
    pkg = super.protonmail-desktop;
    runScript = "proton-mail";
    privateTmp = false;
    additionalFolderPathsReadWrite = [
      "$HOME/Downloads"
    ];
    dbusTalks = [
      "org.freedesktop.secrets"
    ];
    overwriteExec = true;
  };

  signal-desktop = self.bwrapper {
    pkg = super.signal-desktop;
    runScript = "signal-desktop";
    privateTmp = false;
    additionalFolderPathsReadWrite = [
      "$HOME/Downloads"
    ];
    dbusTalks = [
      "org.gnome.SessionManager"
      "org.freedesktop.PowerManagement"
      "org.freedesktop.ScreenSaver"
      "org.freedesktop.secrets"
      "org.gnome.Mutter.IdleMonitor"
      "org.kde.StatusNotifierWatcher"
      "com.canonical.AppMenu.Registrar"
      "com.canonical.indicator.application"
      "org.ayatana.indicator.application"
    ];
    systemDbusTalks = [
      "org.freedesktop.login1"
    ];
  };

  slack = self.bwrapper {
    pkg = super.slack;
    runScript = "slack";
    privateTmp = false;
    additionalFolderPathsReadWrite = [
      "$HOME/Downloads"
    ];
    dbusTalks = [
      #"org.gnome.SessionManager"
      "org.freedesktop.Notifications"
      "org.freedesktop.ScreenSaver"
      "org.freedesktop.secrets"
      "org.kde.StatusNotifierWatcher"
      "org.kde.kwalletd5"
      "org.kde.kwalletd6"
    ];
    systemDbusTalks = [
      "org.freedesktop.Upower"
      "org.freedesktop.login1"
    ];
  };
}
