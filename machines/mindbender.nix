{ pkgs, ... }:

let
  unstable = import <nixos-unstable> {};
in {
  imports = [
    ../cfg/dropbox.nix
    ../cfg/emacs.nix
    ../cfg/git.nix
    ../cfg/fzf.nix
    ../cfg/openconnect.nix
    ../cfg/restic.nix
    ../cfg/rust.nix
    ../cfg/ssh.nix
    ../cfg/vim.nix
    ../cfg/zsh.nix
  ];

  home.packages = with pkgs; [
    gcc
    gdb
    gnupg
    htop
    mpv
    ncdu
    pass
    ripgrep
    skypeforlinux
    spotify
    tdesktop
    unstable.makemkv
    youtube-dl
  ];

  programs.firefox = {
    enable = true;
  };
}
