{ pkgs, ... }:

{
  programs.zsh.enable = true;

  programs.zsh.oh-my-zsh = {
    enable = true;
    plugins = [ "git" "pass" ];
    theme = "agnoster";
  };
}
