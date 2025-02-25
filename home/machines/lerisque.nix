{ pkgs, specialArgs, ... }:

{
  imports = [
    ../cfg/base-desktop.nix
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
  ];

  home.stateVersion = "25.05";
}
