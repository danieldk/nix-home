{ pkgs, ... }:

{

  home.packages = with pkgs; [
    isync
    msmtp
    mu
  ];

  home.file = {
    ".mbsyncrc".source = ./mail/mbsyncrc;
    ".msmtprc".source = ./mail/msmtprc;
  };
}
