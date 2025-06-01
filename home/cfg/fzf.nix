{ pkgs, ... }:

{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    initContent = builtins.readFile fzf/zshrc;
  };
}
