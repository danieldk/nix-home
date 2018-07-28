{ pkgs, ... }:

{
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
    dact
    gnupg
    htop
    ncdu
    pass
    ripgrep
    youtube-dl

    # Environments
    pandocEnv

    # Fonts
    source-code-pro

    Dash
    iTerm2
    TableFlip
  ];

  home.sessionVariables = {
    NIX_PATH = "$HOME/git/nixpkgs:nixpkgs=$HOME/git/nixpkgs:nixpkgs-unstable=$HOME/git/nixpkgs";
  };
}
