{ pkgs, ... }:

let
  unstable = import <nixos-unstable> {};
in {
  home.packages = with pkgs; [
    isync
    msmtp
    unstable.mu
  ];

  home.file = {
    ".mbsyncrc".source = ./mail/mbsyncrc;
    ".msmtprc".source = ./mail/msmtprc;
  };
}
