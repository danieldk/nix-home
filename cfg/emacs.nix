{ pkgs, ... }:

{
  home.packages = [ pkgs.cargo pkgs.rust-analyzer pkgs.rustfmt ];

  programs.emacs = {
    enable = true;

    extraPackages = epkgs: with epkgs; [
      auctex
      avy
      company
      company-math
      counsel
      cython-mode
      diminish
      direnv
      evil
      evil-magit
      flycheck
      forge
      general
      go-mode
      ivy
      ivy-bibtex
      leuven-theme
      lsp-ivy
      lsp-mode
      lsp-ui
      pkgs.mu
      nlinum-relative
      magit
      markdown-mode
      nix-mode
      nix-update
      projectile
      swiper
      use-package
      which-key
      zenburn-theme

      # org-mode
      org
      org-bullets
      evil-org

      # Rust
      cargo

      # Protocol Buffers
      protobuf-mode
    ];
  };

  home.file =
    let
      fontSize = if pkgs.stdenv.isDarwin then "15" else "10";
      emacsFont = ''
        (when window-system
        (set-frame-font "Source Code Pro ${fontSize}"))
       '';
    in {
    ".emacs".text = emacsFont + builtins.readFile ./emacs/base +
      builtins.readFile ./emacs/dev;
    ".emacs-org".text = emacsFont + builtins.readFile ./emacs/base +
      builtins.readFile ./emacs/org;
  };
}
