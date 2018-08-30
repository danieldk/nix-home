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

    # Multimedia
    youtube-dl

    # Networking
    sshuttle

    # Publishing
    librsvg
    pandoc
  ];
}
