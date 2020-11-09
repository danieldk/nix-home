let
  pkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs-channels/archive/nixos-20.03.tar.gz";
  }) {};
  addDeployment = machineConfig: deploy: args@{ config, lib, pkgs, ... }:
    machineConfig args // { deployment = deploy; };
in {
  network = {
    pkgs = pkgs // { overlays = []; };
    description = "Desktops";
  };

  "trex" = import ../machines/trex.nix;
}
