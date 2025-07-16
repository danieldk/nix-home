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

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
    };

    interception-tools.enable = true;

    pcscd.enable = true;
  };

  systemd.services.display-manager.restartIfChanged = false;
}
