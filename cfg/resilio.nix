{ pkgs, ... }:

{
  home.packages = with pkgs; [
    resilio-sync
  ];

  systemd.user.services.rslsync = {
    Unit = {
      Description = "Resilio Sync";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      Restart = "on-failure";
      RestartSec = 1;
      ExecStart = "${pkgs.resilio-sync}/bin/rslsync --nodaemon";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
