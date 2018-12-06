{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Basic utilities
    bat
    fd
    htop
    ncdu
    ripgrep
    unzip
    zstd

    # Encryption
    gnupg
    pass
    pass-find
  ];

  programs.home-manager = {
    enable = true;
  };
}
