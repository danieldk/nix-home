# Basic desktop environment.

{ config, pkgs, ... }:

{
  imports = [
    ./base-nixos.nix
    ./fonts.nix
  ];

  boot = {
    binfmt.emulatedSystems = [ "aarch64-linux" ];

    kernel.sysctl = {
      "kernel.perf_event_paranoid" = 0;
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  documentation.dev.enable = true;

  environment.systemPackages = with pkgs; [
    linuxPackages.perf
  ];

  hardware = {
    pulseaudio = {
      enable = true;
      support32Bit = true;
    };
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services = {
    avahi = {
      enable = true;
      nssmdns = true;
    };

    fwupd.enable = true;

    interception-tools.enable = true;

    pcscd.enable = true;
  };

  systemd.services.display-manager.restartIfChanged = false;
}
