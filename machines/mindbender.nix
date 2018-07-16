{ pkgs, ... }:

let
  unstable = import <nixos-unstable> {};
in {
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
    unstable.bubblewrap
    cargo-asm
    unstable.corebird
    fsa6
    gcc
    gdb
    google-chrome
    unstable.gnupg
    htop
    unstable.mpv
    ncdu
    unstable.pass
    unstable.ripgrep
    skypeforlinux
    spotify
    unstable.tdesktop
    unstable.makemkv
    unstable.youtube-dl
  ];

  programs.firefox = {
    enable = true;
  };
}
