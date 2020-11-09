# Basic desktop environment.

{ config, pkgs, ... }:

{
  imports = [
    ./base-nixos.nix
    ./fonts.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  documentation.dev.enable = true;

  environment.systemPackages = [
  ];
}
