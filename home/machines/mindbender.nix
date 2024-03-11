{ pkgs, ... }:

{
  imports = [
    ../cfg/base-unix.nix
    ../cfg/direnv.nix
    ../cfg/git.nix
    ../cfg/go.nix
    ../cfg/fzf.nix
    ../cfg/ssh.nix
    ../cfg/vim.nix
    ../cfg/zsh.nix
  ];

  home.packages = with pkgs; [
    nix-bundle
    nixpkgs-review
  ];

  home.stateVersion = "24.05";
}
