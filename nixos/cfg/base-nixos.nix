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
      unzip
    ];
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Amsterdam";

  programs = {
    bash.enableCompletion = true;
    vim.defaultEditor = true;
    zsh.enable = true;
    zsh.enableCompletion = true;
  };

}
