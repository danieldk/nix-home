{ pkgs, ... }:

let
  sources = import ../nix/sources.nix;
in {
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
    gnupg
    openssh
    pass
    pass-find

    # Nix tools
    niv
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
    path = toString sources.home-manager;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = false;
  };
}
