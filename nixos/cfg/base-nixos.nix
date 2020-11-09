# Basic NixOS Unix environment.

{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    manpages
    unzip
  ];
}
