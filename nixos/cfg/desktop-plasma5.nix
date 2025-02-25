{ config, lib, pkgs, ... }:

{
  imports = [
    ./base-desktop.nix
  ];

  services.desktopManager.plasma6 = {
    enable = true;
  };

  services.displayManager = {
    defaultSession = "plasma";
    sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    gwenview
    korganizer
    okular
  ];
}
