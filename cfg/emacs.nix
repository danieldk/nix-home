{ pkgs, ... }:

let
  package = if pkgs.stdenv.isDarwin then pkgs.emacsMacport else pkgs.emacs;
  emacsPackages = pkgs.emacsPackagesNgGen package;
  emacsWithPackages = emacsPackages.emacsWithPackages (epkgs: [
    epkgs.auctex
    epkgs.avy
    epkgs.company
    epkgs.company-math
    epkgs.counsel
    epkgs.diminish
    epkgs.direnv
    epkgs.evil
    epkgs.evil-magit
    epkgs.evil-mu4e
    epkgs.flycheck
    epkgs.forge
    epkgs.general
    epkgs.ivy
    epkgs.ivy-bibtex
    epkgs.leuven-theme
    epkgs.nlinum-relative
    epkgs.magit
    epkgs.markdown-mode
    epkgs.nix-mode
    epkgs.nix-update
    epkgs.projectile
    epkgs.swiper
    epkgs.use-package
    epkgs.which-key

    # org-mode
    epkgs.org
    epkgs.org-bullets
    epkgs.evil-org

    # Rust
    epkgs.cargo
    epkgs.flycheck-rust
    epkgs.racer
    epkgs.rust-mode
  ]);

  emacsBinary = if pkgs.stdenv.isDarwin then
    "${emacsWithPackages}/Applications/Emacs.app/Contents/MacOS/Emacs"
  else
    "${emacsWithPackages}/bin/emacs";

  org = pkgs.writeScriptBin "org" ''
    #!/bin/sh
    ${emacsBinary} -q --load ~/.emacs-org $@
  '';
  mue = pkgs.writeScriptBin "mue" ''
    #!/bin/sh
    ${emacsBinary} -q --load ~/.emacs-mu4e $@
  '';
in {
  home.packages = [ emacsWithPackages org mue ];

  home.file =
    let
      fontSize = if pkgs.stdenv.isDarwin then "15" else "12";
      emacsFont = ''
        (when window-system
        (set-frame-font "Source Code Pro ${fontSize}"))
       '';
    in {
    ".emacs".text = emacsFont + builtins.readFile ./emacs/base +
      builtins.readFile ./emacs/dev;
    ".emacs-mu4e".text = emacsFont + builtins.readFile ./emacs/base +
      builtins.readFile ./emacs/mu4e;
    ".emacs-org".text = emacsFont + builtins.readFile ./emacs/base +
      builtins.readFile ./emacs/org;
  };

 programs.zsh.shellAliases = {
   emacs = "${emacsBinary} -q --load ~/.emacs";
 };
}
