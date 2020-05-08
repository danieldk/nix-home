{ pkgs, ...}:

{
  home.packages = with pkgs; [
    (callPackage go/gopls {})
  ];

  programs.go.enable = true;

  programs.emacs.init.usePackage = {
    go-mode = {
      enable = true;
      mode = [ ''"\\.go\\'"'' ];
      hook = [
        "(before-save . lsp-format-buffer)"
        "(before-save . lsp-organize-imports)"
      ];
    };

    lsp-mode = {
      hook = [
        "(go-mode . lsp)"
      ];
    };
  };
}
