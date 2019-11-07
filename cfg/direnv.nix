{ pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

  home.file.".direnvrc".source = ./direnv/use_nix;
}
