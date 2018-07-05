{ pkgs, ... }:

let
  unstable = import <nixpkgs-unstable> {};
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
    unstable.gnupg
    htop
    ncdu
    unstable.pass
    unstable.ripgrep
    unstable.youtube-dl
  ];
}
