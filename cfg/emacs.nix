{ pkgs, ... }:

let
  unstable = with pkgs.stdenv;
  if isDarwin then import <nixpkgs-unstable> {}
  else import <nixos-unstable> {};
in {
  programs.emacs = {
    enable = true;
    package = unstable.emacs;
    extraPackages = epkgs: [
      epkgs.company
      epkgs.counsel
      epkgs.diminish
      epkgs.evil
      epkgs.evil-magit
      epkgs.evil-mu4e
      epkgs.flycheck
      epkgs.general
      epkgs.ivy
      epkgs.leuven-theme
      epkgs.magit
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
    ];
  };

  home.file = {
    ".emacs".text = builtins.readFile ./emacs/base +
      builtins.readFile ./emacs/dev;
    ".emacs-mu4e".text = builtins.readFile ./emacs/base +
      builtins.readFile ./emacs/mu4e;
    ".emacs-org".text = builtins.readFile ./emacs/base +
      builtins.readFile ./emacs/org;
  };

  programs.zsh.shellAliases = {
    mue = "emacs -q --load ~/.emacs-mu4e";
    org = "emacs -q --load ~/.emacs-org";
  };
}
