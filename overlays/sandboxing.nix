self: super: {
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
