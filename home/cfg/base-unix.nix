{ pkgs, ... }:

{
  imports = [
    ./tmux.nix
  ];

  home.packages = with pkgs; [
    # Basic utilities
    bat
    binutils
    fd
    gdb
    gitAndTools.gh
    htop
    ncdu
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

  home.sessionVariables = {
    EDITOR = "emacs";
  };

  programs.home-manager = {
    enable = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = false;
  };
}
