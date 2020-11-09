{ pkgs, ... }:

{
  imports = [
    ../modules/emacs-init.nix

    ../cfg/emacs.nix
    ../cfg/fzf.nix
    ../cfg/git.nix
    ../cfg/rust.nix
    ../cfg/ssh.nix
    ../cfg/vim.nix
    ../cfg/zsh.nix
  ];

  home.packages = with pkgs; [
    htop
    ncdu
    ripgrep
  ];

  programs.home-manager.enable = true;
  programs.home-manager.path = "./home-manager";

  programs.zsh.profileExtra = ''
    source ~/.nix-profile/etc/profile.d/nix.sh
    export NIX_PATH="$NIX_PATH:nixos=$HOME/.nix-defexpr/channels/nixpkgs"
    export NIX_PATH="$NIX_PATH:nixos-unstable=$HOME/.nix-defexpr/channels/nixpkgs"
  '';
}
