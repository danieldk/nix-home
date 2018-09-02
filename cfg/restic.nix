{ pkgs, ... }:

let
  resticEnv = builtins.toFile "restic-env" ''
    export B2_ACCOUNT_ID=$(pass show Storage/Backblaze/AppKey | grep AccountID: | cut -d ' ' -f 2)
    export B2_ACCOUNT_KEY=$(pass Storage/Backblaze/AppKey | head -n1)
    export RESTIC_PASSWORD=$(pass Storage/Restic)
  '';
in {
  home.packages = with pkgs; [
    restic
    sshfs
  ];


  systemd.user.services = {
    restic-local = let
      backup-local = pkgs.writeScript "restic-backup-local" ''
        #! ${pkgs.bash}/bin/sh

        source ${resticEnv}

        UMBRELLA=sftp:umbrella:/data/daniel-backup
        restic -r $UMBRELLA backup --tag=dropbox ~/Dropbox
        restic -r $UMBRELLA backup -e target --tag=git ~/git
        restic -r $UMBRELLA backup --tag=mail ~/Maildir
        restic -r $UMBRELLA forget --prune -H 10 -d 10 -w 10 -m 10 -y 10 

        B2=b2:restic-mindbender
        restic -r $B2 backup -e target --tag=git ~/git
        restic -r $B2 backup --tag=mail ~/Maildir
        restic -r $B2 forget --prune -H 10 -d 10 -w 10 -m 10 -y 10
      '';
    in {
      Unit = {
        Description = "Local Restic backup";
      };

      Service = {
        Type = "oneshot";
        ExecStart = "${backup-local}";
      };
    };
  };

  systemd.user.timers = {
    restic-local = {
      Unit = {
        Description = "Scheduled local Restic backup";
      };

      Timer = {
        Persistent = "true";
        Unit = "restic-local.service";
        OnCalendar = "0/2:00:00";
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };

  home.file = {
    ".config/restic/env".source = ./restic/env;
    "bin/backup-local".source = ./restic/backup-local;
  };
}
