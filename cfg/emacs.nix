{ pkgs, ... }:

let
  package = if pkgs.stdenv.isDarwin then pkgs.emacsMacport else pkgs.emacs;
  emacsPackages = pkgs.emacsPackagesNgGen package;
  emacsWithPackages = emacsPackages.emacsWithPackages (epkgs: [
    epkgs.company
    epkgs.counsel
    epkgs.diminish
    epkgs.evil
    (epkgs.evil-magit.overrideAttrs (attrs: {
      nativeBuildInputs = (attrs.nativeBuildInputs or []) ++ [ pkgs.git ];
    }))
    epkgs.evil-mu4e
    epkgs.flycheck
    epkgs.general
    epkgs.ivy
    epkgs.leuven-theme
    epkgs.nlinum-relative
    epkgs.magit
    epkgs.markdown-mode
    epkgs.nix-mode
    epkgs.projectile
    epkgs.swiper
    epkgs.use-package
    epkgs.which-key

    # org-mode
    epkgs.org
    epkgs.org-bullets
    epkgs.org-evil

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
in {
  home.packages = [ emacsWithPackages ];

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
    mue = "${emacsBinary} -q --load ~/.emacs-mu4e";
    org = "${emacsBinary} -q --load ~/.emacs-org";
  };
}
