let
  pkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixos-21.05.tar.gz";
  }) { config = { allowUnfree = true; }; };
  addDeployment = machineConfig: deploy: args@{ config, lib, pkgs, ... }:
    machineConfig args // { deployment = deploy; };
in {
  network = {
    pkgs = pkgs // { overlays = []; };
    description = "Personal VPSes";
  };

  "castle.danieldk.eu" = addDeployment (import ../machines/castle.nix) {
    healthChecks = {
      http = [
        {
          scheme = "https";
          port = 443;
          host = "ljdekok.com";
          description = "Check whether ljdekok.com is reachable.";
        }
      ];
    };
  };

  "mindfuzz" = import ../machines/mindfuzz.nix;

  "syncnode.dekok.dk" = addDeployment (import ../machines/syncnode.nix) {
    healthChecks = {
      http = [
        {
          scheme = "https";
          port = 443;
          host = "blob.danieldk.eu";
          description = "Check whether blob.danieldk.eu is reachable.";
        }
      ];
    };
  };
}
