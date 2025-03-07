{
  config,
  lib,
  pkgs,
  sloth,
  ...
}:
{
  config = {
    dbus.policies = {
      "${config.flatpak.appId}" = "own";
      "org.freedesktop.DBus" = "talk";
      "org.gtk.vfs.*" = "talk";
      "org.gtk.vfs" = "talk";
      "ca.desrt.dconf" = "talk";
      "org.freedesktop.portal.*" = "talk";
      "org.a11y.Bus" = "talk";
    };
    gpu.enable = lib.mkDefault true;
    gpu.provider = "nixos";
    fonts.enable = true;
    locale.enable = true;
    bubblewrap = {
      network = lib.mkDefault false;
      sockets = {
        pulse = lib.mkDefault true;
        wayland = lib.mkDefault true;
        x11 = lib.mkDefault true;
      };
      bind.rw = with sloth; [
        # XDG cache/config/state
        [
          (mkdir (concat' appDir "/config"))
          xdgConfigHome
        ]
        [
          (mkdir appCacheDir)
          xdgCacheHome
        ]
        [
          (mkdir appDataDir)
          xdgDataHome
        ]
        [
          (mkdir (concat' appDir "/state"))
          xdgStateHome
        ]

        # Portals
        [
          (concat' runtimeDir "/doc/by-app/${config.flatpak.appId}")
          (concat' runtimeDir "/doc")
        ]

        (concat' xdgCacheHome "/fontconfig")
        (concat' xdgCacheHome "/mesa_shader_cache")

        (concat' runtimeDir "/at-spi/bus")
        (concat' runtimeDir "/gvfsd")
      ];
      bind.ro = with sloth; [
        (concat' xdgConfigHome "/gtk-2.0")
        (concat' xdgConfigHome "/gtk-3.0")
        (concat' xdgConfigHome "/gtk-4.0")
        (concat' xdgConfigHome "/fontconfig")
      ];
      env = {
        XDG_DATA_DIRS = lib.makeSearchPath "share" [
          pkgs.adwaita-icon-theme
          pkgs.shared-mime-info
        ];
        XCURSOR_PATH = lib.concatStringsSep ":" [
          "${pkgs.adwaita-icon-theme}/share/icons"
          "${pkgs.adwaita-icon-theme}/share/pixmaps"
        ];
      };
    };
  };
}
