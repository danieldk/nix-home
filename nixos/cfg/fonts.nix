# Font configuration.

{ config, pkgs, ... }:

{
  fonts = {
    enableFontDir = true;

    fonts = with pkgs; [
      corefonts
      fira-code
      google-fonts
      jetbrains-mono
      noto-fonts
      noto-fonts-emoji
      source-code-pro
    ];
  };
}
