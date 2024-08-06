{ pkgs, specialArgs, ... }:

{
  imports = [
    ../cfg/base-unix.nix
    ../cfg/direnv.nix
    ../cfg/git.nix
    ../cfg/fzf.nix
    ../cfg/vim.nix
    ../cfg/zsh.nix
  ];

  home.stateVersion = "24.05";
}
