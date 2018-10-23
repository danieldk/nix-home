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

        restic=${pkgs.restic}/bin/restic

        source ${resticEnv}

        HOST=sftp:mindfuzz:/home/daniel/backups/daniel
        $restic -r $HOST backup --tag=dropbox ~/Dropbox
        $restic -r $HOST backup -e target --tag=git ~/git
        $restic -r $HOST backup --tag=mail ~/Maildir
        $restic -r $HOST forget --prune -H 10 -d 10 -w 10 -m 10 -y 10 

        B2=b2:restic-mindbender
        $restic -r $B2 backup -e target --tag=git ~/git
        $restic -r $B2 backup --tag=mail ~/Maildir
        $restic -r $B2 forget --prune -H 10 -d 10 -w 10 -m 10 -y 10
      '';
    in {
      Unit = {
        Description = "Restic backup (local)";
      };

      Service = {
        Type = "oneshot";
        ExecStart = "${backup-local}";
      };
    };

    restic-castle = let
      backup-castle = pkgs.writeScript "restic-backup-castle" ''
        #! ${pkgs.bash}/bin/sh

        set -e

        CASTLE_BACKUP_DIR=''${HOME}/.var/backup/castle/

        if [ ! -d ''${CASTLE_BACKUP_DIR} ] ; then
          mkdir -p ''${CASTLE_BACKUP_DIR}
        fi

        rsync -avz root@castle.danieldk.eu:/var/lib/gitolite/ \
          ''${CASTLE_BACKUP_DIR}/gitosis/
        rsync -avz root@castle.danieldk.eu:/srv/www/ \
          ''${CASTLE_BACKUP_DIR}/www/

        source ${resticEnv}

        restic=${pkgs.restic}/bin/restic

        HOST=sftp:mindfuzz:/home/daniel/backups/castle
        $restic -r $HOST backup --tag=castle ~/.var/backup/castle

        B2=b2:restic-castle
        $restic -r $B2 backup -e target --tag=castle ~/.var/backup/castle
      '';
    in {
      Unit = {
        Description = "Restic backup (castle)";
      };

      Service = {
        Type = "oneshot";
        ExecStart = "${backup-castle}";
      };
    };
  };

  systemd.user.timers = {
    restic-local = {
      Unit = {
        Description = "Scheduled Restic backup (local)";
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

    restic-castle = {
      Unit = {
        Description = "Scheduled Restic backup (castle)";
      };

      Timer = {
        Persistent = "true";
        Unit = "restic-castle.service";
        OnCalendar = "0/2:00:00";
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
