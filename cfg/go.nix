{ pkgs, ...}:

{
  programs.go.enable = true;

  programs.emacs.init.usePackage = {
    go-mode = {
      enable = true;
    };
  };
}
