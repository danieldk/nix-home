{ pkgs, ... }:

let
  package = if pkgs.stdenv.isDarwin then pkgs.emacsMacport else pkgs.emacs;
  emacsPackages = pkgs.emacsPackagesNgGen package;
  emacsWithPackages = emacsPackages.emacsWithPackages (epkgs: with epkgs; [
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
    evil-mu4e
    flycheck
    forge
    general
    go-mode
    ivy
    ivy-bibtex
    leuven-theme
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

    # org-mode
    org
    org-bullets
    evil-org

    # Rust
    cargo
    flycheck-rust
    racer
    rust-mode

    # Protocol Buffers
    protobuf-mode
  ]);

  emacsBinary = if pkgs.stdenv.isDarwin then
    "${emacsWithPackages}/Applications/Emacs.app/Contents/MacOS/Emacs"
  else
    "${emacsWithPackages}/bin/emacs";

  orgMacs = pkgs.writeScriptBin "org" ''
    #!/bin/sh
    ${emacsBinary} -q --load ~/.emacs-org $@
  '';
  muMacs = pkgs.writeScriptBin "mue" ''
    #!/bin/sh
    ${emacsBinary} -q --load ~/.emacs-mu4e $@
  '';
in {
  home.packages = [ emacsWithPackages orgMacs muMacs ];

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
    ".emacs-mu4e".text = emacsFont + builtins.readFile ./emacs/base +
      builtins.readFile ./emacs/mu4e;
    ".emacs-org".text = emacsFont + builtins.readFile ./emacs/base +
      builtins.readFile ./emacs/org;
  };

 programs.zsh.shellAliases = {
   emacs = "${emacsBinary} -q --load ~/.emacs";
 };
}
