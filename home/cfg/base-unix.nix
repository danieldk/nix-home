{ pkgs, ... }:

{
  imports = [
    ./tmux.nix
  ];

  home.packages = with pkgs; [
    # Basic utilities
    asciinema
    bat
    binutils
    cachix
    fd
    gdb
    gitAndTools.gh
    htop
    ncdu
    nix-output-monitor
    ripgrep
    unzip
    zstd

    # Encryption
    openssh
  ] ++ lib.optionals pkgs.stdenv.isDarwin [
    # Better userland for macOS
    coreutils
    findutils
    gawk
    gnugrep
    gnused
    gnutar
  ];

  programs.home-manager = {
    enable = true;
  };

  programs.zellij = {
    enable = true;
    settings = {
      pane_frames = false;
      theme = "gruvbox-dark";
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = false;
  };
}
