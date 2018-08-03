{ pkgs, ... }:

{
  imports = [
    ../cfg/dropbox.nix
    ../cfg/emacs.nix
    ../cfg/git.nix
    ../cfg/fzf.nix
    ../cfg/mail.nix
    ../cfg/mupdf.nix
    ../cfg/openconnect.nix
    ../cfg/restic.nix
    ../cfg/rust.nix
    ../cfg/ssh.nix
    ../cfg/vim.nix
    ../cfg/zsh.nix
  ];

  home.packages = with pkgs; [
    binutils
    bubblewrap
    cargo-asm
    corebird
    dbxml
    gnome3.dconf
    gnome3.defaultIconTheme
    fsa6
    gcc
    gdb
    google-chrome
    gnupg
    htop
    jupyterEnv
    keybase
    keybase-gui
    mpv
    ncdu
    nixops-pinned
    pandocEnv
    pass
    ripgrep
    skypeforlinux
    spotify
    tdesktop
    makemkv
    youtube-dl
  ];

  programs.firefox = {
    enable = true;
  };

  home.sessionVariables = {
    NIX_PATH = "$HOME/git/nixpkgs:nixpkgs=$HOME/git/nixpkgs:nixpkgs-unstable=$HOME/git/nixpkgs";
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
  };

  services.keybase.enable = true;
  services.kbfs.enable = true;
}
