{ pkgs, ...}:

{
  home.packages = with pkgs; [
    gopls
  ];

  programs.go.enable = true;
}
