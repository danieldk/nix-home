{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "pass" "vi-mode" ];
      theme = "agnoster";
    };
  };
}
