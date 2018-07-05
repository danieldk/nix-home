{ pkgs, ... }:

let
  unstable = import <nixos-unstable> {};
in {
  home.packages = with pkgs; [
    unstable.restic
  ];

  home.file = {
    ".config/restic/env".source = ./restic/env;
    "bin/backup-local".source = ./restic/backup-local;
  };
}