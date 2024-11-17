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
    btop
    cachix
    fd
    gdb
    gitAndTools.gh
    gpustat
    htop
    ncdu
    nix-output-monitor
    nvitop
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
      mouse_mode = false;
      pane_frames = false;
      theme = "gruvbox-dark";
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = false;
  };
}
