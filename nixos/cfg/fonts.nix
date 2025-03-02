# Font configuration.

{ config, pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;

    packages = with pkgs; [
      corefonts
      fira-code
      google-fonts
      jetbrains-mono
      mono-lisa
      noto-fonts
      noto-fonts-emoji
      source-code-pro
    ];
  };
}
