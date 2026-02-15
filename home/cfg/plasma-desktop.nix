{ pkgs, ... }:

{
  imports = [ ./base-desktop.nix ];

  programs.plasma = {
    enable = true;

    input = {
      mice = [
    {
      enable = true;
      name = "Logitech MX Ergo Multi-Device Trackball ";
      naturalScroll = true;
      vendorId = "046d";
      productId = "b01d";
    }
    ];

    touchpads = [
      {
      enable = true;
      name = "SYNA8018:00 06CB:CE67 Touchpad";
      naturalScroll = true;
      vendorId = "06cb";
      productId = "ce67";
    }
    ];
  };


    shortcuts = {
      plasmashell = {
        "activate application launcher" = "Meta+Space";
      };
    };
  };
}
