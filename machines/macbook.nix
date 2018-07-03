{ pkgs, ... }:

let
  unstable = import <nixpgs-unstable> {};
in {
  imports = [
    ../cfg/emacs.nix
    ../cfg/fzf.nix
    ../cfg/git.nix
    ../cfg/rust.nix
    ../cfg/ssh.nix
    ../cfg/vim.nix
    ../cfg/zsh.nix
  ];

  home.packages = with pkgs; [
    gnupg
    htop
    ncdu
    pass
    ripgrep
    youtube-dl
  ];
}
