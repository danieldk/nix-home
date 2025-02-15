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
  ] ++ lib.optionals (!pkgs.stdenv.isDarwin) [
    gdb
    gpustat
    nvitop
  ];

  programs.home-manager = {
    enable = true;
  };

  programs.zellij = {
    enable = true;
    enableZshIntegration = false;
    settings = {
      keybinds = {
        tab = {
          "bind \"Shift Left\"" = { MoveTab = "Left"; };
          "bind \"Shift Right\"" = { MoveTab = "Right"; };
        };
      };
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
