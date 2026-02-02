{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./base-desktop.nix
  ];

  hardware.bluetooth = {
    enable = true;
  };

  security.pam.services.login.fprintAuth = false;

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
  ];
}
