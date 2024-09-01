{ pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
  };

  home.file.".direnvrc".source = ./direnv/use_nix;
}
