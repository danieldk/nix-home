{ pkgs, ... }:

let
  unstable = import <nixos-unstable> {};
in {
  imports = [
    ../cfg/git.nix
    ../cfg/fzf.nix
    #./cfg/rust.nix
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
    rustChannels.stable.rust
    youtube-dl
  ];
}
