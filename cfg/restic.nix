{ pkgs, ... }:

let
  unstable = import <nixos-unstable> {};
in {
  home.packages = with pkgs; [
    unstable.restic
    sshfs
  ];

  home.file = {
    ".config/restic/env".source = ./restic/env;
    "bin/backup-b2".source = ./restic/backup-b2;
    "bin/backup-local".source = ./restic/backup-local;
  };
}
