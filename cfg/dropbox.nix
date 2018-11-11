{ pkgs, ... }:

{
  home.packages = with pkgs; [
    dropbox
  ];

  systemd.user.services.dropbox = {
    Unit = {
      Description = "Dropbox";
      PartOf = [ "network-online.target" ];
    };

    Service = {
      Restart = "on-failure";
      RestartSec = 5;
      ExecStart = "${pkgs.dropbox}/bin/dropbox";
      Environment = "QT_PLUGIN_PATH=/run/current-system/sw/${pkgs.qt5.qtbase.qtPluginPrefix}";
    };

    Install = {
      WantedBy = [ "basic.target" ];
    };
  };
}
