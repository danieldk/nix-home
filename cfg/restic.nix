{ pkgs, ... }:

let
  resticPassword = "export RESTIC_PASSWORD=$(pass Storage/Restic)";
  restic-b2 = pkgs.runCommand "restic-b2" {
    buildInputs = [ pkgs.makeWrapper ];
  } ''
    mkdir -p $out/bin
    makeWrapper ${pkgs.restic}/bin/restic $out/bin/restic-b2 \
      --run "export B2_ACCOUNT_ID=\"\$(pass show Storage/Backblaze/AppKey | grep AccountID: | cut -d ' ' -f 2)\"" \
      --run "export B2_ACCOUNT_KEY=\"\$(pass Storage/Backblaze/AppKey | head -n1)\"" \
      --add-flags "--password-command='pass Storage/Restic'" \
      --add-flags "-r b2:restic-mindbender"
  '';
  restic-mindfuzz = pkgs.runCommand "restic-mindfuzz" {
    buildInputs = [ pkgs.makeWrapper ];
  } ''
    mkdir -p $out/bin
    makeWrapper ${pkgs.restic}/bin/restic $out/bin/restic-mindfuzz \
      --add-flags "--password-command='pass Storage/Restic'" \
      --add-flags "-r sftp:mindfuzz:/home/daniel/backups/daniel"
  '';
in {
  home.packages = with pkgs; [
    restic
    restic-b2
    restic-mindfuzz
    sshfs
  ];

  systemd.user.services = {
    restic-local = let
      backup-local = pkgs.writeScript "restic-backup-local" ''
        #! ${pkgs.bash}/bin/sh

        restic=${restic-mindfuzz}/bin/restic-mindfuzz
        $restic backup --tag=resilio ~/resilio
        $restic backup -e target --tag=git ~/git
        $restic backup --tag=mail ~/Maildir
        #$restic forget --prune -H 10 -d 10 -w 10 -m 10 -y 10

        restic=${restic-b2}/bin/restic-b2
        $restic backup --tag=resilio ~/resilio
        $restic backup -e target --tag=git ~/git
        $restic backup --tag=mail ~/Maildir
        #$restic forget --prune -H 10 -d 10 -w 10 -m 10 -y 10
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

        restic=${restic-mindfuzz}/bin/restic-mindfuzz
        $restic backup --tag=castle ~/.var/backup/castle

        restic=${restic-b2}/bin/restic-b2
        $restic backup -e target --tag=castle ~/.var/backup/castle
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
        PartOf = [ "network-online.target" ];
      };

      Timer = {
        Persistent = "true";
        Unit = "restic-local.service";
        OnCalendar = "00/2:00";
      };

      Install = {
        WantedBy = [ "timers.target" ];
      };
    };

    restic-castle = {
      Unit = {
        Description = "Scheduled Restic backup (castle)";
        PartOf = [ "network-online.target" ];
      };

      Timer = {
        Persistent = "true";
        Unit = "restic-castle.service";
        OnCalendar = "00/2:30";
      };

      Install = {
        WantedBy = [ "timers.target" ];
      };
    };
  };
}
