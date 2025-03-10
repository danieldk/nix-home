# Basic NixOS Unix environment.

{ config, pkgs, ... }:
{
  environment = {
    shells = [
      pkgs.bashInteractive
      pkgs.zsh
    ];

    systemPackages = with pkgs; [
      git
      git-crypt
      man-pages
      man-pages-posix
      unzip
    ];
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Amsterdam";

  programs = {
    bash.completion.enable = true;
    zsh.enable = true;
    zsh.enableCompletion = true;
  };

}
