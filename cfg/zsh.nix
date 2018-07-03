{ pkgs, ... }:

{
  home.packages = with pkgs; [
    direnv
  ];

  programs.zsh = {
    enable = true;

    initExtra = builtins.readFile zsh/zshrc;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "pass" "vi-mode" "z" ];
      theme = "agnoster";
    };
  };
}
