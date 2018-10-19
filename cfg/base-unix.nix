{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Basic utilities
    fd
    htop
    ncdu
    ripgrep
    unzip
    zstd

    # Development
    cargo-asm
    go
 
    # Encryption
    gnupg
    pass
    pass-find

    # Multimedia
    youtube-dl

    # Networking
    sshuttle

    # Publishing
    librsvg
    pandoc
  ];

  programs.home-manager = {
    enable = true;
  };
}
