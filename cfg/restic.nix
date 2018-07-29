{ pkgs, ... }:

{
  home.packages = with pkgs; [
    restic
    sshfs
  ];

  home.file = {
    ".config/restic/env".source = ./restic/env;
    "bin/backup-b2".source = ./restic/backup-b2;
    "bin/backup-local".source = ./restic/backup-local;
  };
}
